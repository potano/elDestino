<?php
// Copyright © 2023 Michael Thompson
// SPDX-License-Identifier: GPL-2.0-or-later


class VectorData {
   private $root;
   private $styler;
   private $attester;
   private $mapItems = array();
   private $referenceItems = array();
   private $sourcesToTargets;
   private $inboundNodes;

   private static $schema;

   private static function init() {
      $literals = array(
         '=string' => LispValue::tString,
         '=symbol' => LispValue::tSymbol,
         '=sym' => LispValue::tSymbolOrString,
         '=name' => LispValue::tSymbolOrString,
         '=num' => LispValue::tNum,
         '=int' => LispValue::tInt,
         '=float' => LispValue::tFloat,
         '=floats' => LispValue::tFloat,
      );
      $nonterminals = array(
         '0' => 'layers feature segment route path',
         'layers' => 'layer',
         'layer' => '=name menuitem features',
         'menuitem' => '=string',
         'features' => '=sym',
         'feature' => '=name popup marker style attestation ' .
            'point path route polygon rectangle circle feature features',
         'marker' => '=name html popup =floats',
         'html' => '=string',
         'popup' => '=string',
         'style' => '=sym',
         'attestation' => '=sym',
         'point' => '=name =floats',
         'paths' => '=sym',
         'path' => '=name popup style attestation =floats',
         'route' => '=name popup style attestation segment path segments',
         'rectangle' => '=name popup style attestation =floats',
         'polygon' => '=name popup style attestation =floats',
         'circle' => '=name popup style attestation =floats radius pixels',
         'radius' => '=num',
         'pixels' => '=int',
         'segment' => '=name popup style attestation path paths',
         'segments' => '=sym',
      );
      $schema = array();
      foreach ($nonterminals as $name => $list) {
         $lists = $terminals = array();
         $mask = 0;
         $nameable = FALSE;
         foreach (explode(' ', $list) as $index => $sym) {
            if (substr($sym, 0, 1) == '=') {
               if (!$index && $sym == '=name') {
                  $nameable = TRUE;
               }
               elseif (($symMask = $literals[$sym]) & $mask) {
                  throw new Exception("Internal error: $sym reuses a mask bit");
               }
               else {
                  $terminals[$literals[$sym]] = $sym;
                  $mask |= $symMask;
               }
            }
            else {
               $lists[$sym] = 1;
            }
         }
         $schema[$name] = compact('lists', 'mask', 'terminals', 'nameable');
      }
      self::$schema = $schema;
   }

   function __construct() {
      if (!isset(self::$schema)) {
         self::init();
      }
      $this->styler = new Styler();
      $this->attester = new Attester($this->styler);
   }

   function consumeFileSexps($filename, $sexp) {
      if (!is_object($sexp) || !$sexp->is_list() || !count($sexp->get())) {
         throw new Exception("File $filename is empty");
      }
      $this->parseList(NULL, $sexp);
   }

   function resolveReferences() {
      $sourcesToTargets = array();
      $inbound = array_fill_keys(array_keys($this->mapItems), array());
      foreach ($this->referenceItems as $refItem) {
         list($object, $ownerName, $targetName) = $refItem;
         if (!isset($this->mapItems[$ownerName])) {
            $object->fatal("Internal error: owner item '$ownerName' is not registered");
         }
         if (!isset($this->mapItems[$targetName])) {
            $object->fatal("Cannot resolve reference target '$targetName'");
         }
         $targetObject = $this->mapItems[$targetName];
         $targetType = $targetObject->itemType();
         $acceptableTypes = $object->acceptableTypes();
         if (!in_array($targetType, $acceptableTypes)) {
            $object->fatal("Referenced item '$targetName' is a '$targetType'; only " .
               self::andList($acceptableTypes, 'or') . " allowed");
         }
         $object->setTargetObject($targetObject);
         if (isset($sourcesToTargets[$ownerName])) {
            $sourcesToTargets[$ownerName][] = $targetName;
         }
         else {
            $sourcesToTargets[$ownerName] = array($targetName);
         }
         $inbound[$targetName][] = $ownerName;
      }

      //Identify the nodes which are potentially the heads of cycles:  the root nodes
      // plus any interior nodes that are the targets of more than one node.
      // Taking this step lets us avoid the expense of doing a full cycle-detection
      // analysis of every node in the graph.  It also simplifies the cycle-detection
      // algorithm.
      $root = $this->root->getName();
      $multipleInletNodes = array($root);
      foreach ($inbound as $targetName => $sources) {
         if (!$sources && $targetName != $root) {
            $this->mapItems[$targetName]->fatal("Orphan node (nothing links to it)");
         }
         if (count($sources) < 2 || !isset($sourcesToTargets[$targetName])) {
            continue;
         }
         $multipleInletNodes[] = $targetName;
      }
      //Test for the existence of cycles starting from the identified nodes.
      foreach ($multipleInletNodes as $nodeName) {
         $stack = array($sourcesToTargets[$nodeName]);
         while ($stack) {
            $top = array_pop($stack);
            if (!$top) {
               continue;
            }
            $next = array_shift($top);
            array_push($stack, $top);
            if (in_array($next, $multipleInletNodes)) {
               $this->mapItems[$next]->fatal("Node $next causes a dependency-graph cycle");
            }
            if (isset($sourcesToTargets[$next])) {
               array_push($stack, $sourcesToTargets[$next]);
            }
         }
      }

      $this->sourcesToTargets = $sourcesToTargets;
      $this->inboundNodes = $inbound;
   }

   function generateCode() {
      $objects = array();
      $this->walkNodeDependencies($objects, $this->root->getName());
      $blobs = array();
      $lastI = count($objects) - 1;
      foreach ($objects as $i => $object) {
         if ($i < $lastI) {
            $blobs[] = "var s$i=" . $object->generateCode();
         }
         else {
            $blobs[] = "allVectors = " . $object->generateCode() . ";\n";
         }
      }
      return $this->styler->generateCode() . implode("\n", $blobs);
   }

   function getMapitem($name) {
      return isset($this->mapItems[$name]) ? $this->mapItems[$name] : NULL;
   }

   private function walkNodeDependencies(& $objects, $name) {
      if (isset($this->sourcesToTargets[$name])) {
         foreach ($this->sourcesToTargets[$name] as $child) {
            $this->walkNodeDependencies($blobs, $child);
         }
      }
      if (count($this->inboundNodes[$name]) != 1) {
         $target = $this->mapItems[$name];
         if ($target->getItemIndex() < 0) {
            $target->setItemIndex(count($objects));
            $objects[] = $target;
         }
      }
   }

   private function parseList($parent, $list) {
      if (!is_object($list)) {
         throw new Exception("Non-object found");
      }
      if (!$list->is_list()) {
         $list->fatal("List expected");
      }
      $symbol = $list->get_head();
      if (!isset(self::$schema[$symbol])) {
         $this->fatal("Unknown list type $symbol");
      }
      $guide = self::$schema[$symbol];
      $prepared = array();
      $itemName = NULL;
      foreach ($list->get() as $index => $item) {
         if ($item->is_list()) {
            $head = $item->get_head();
            if (isset($guide['lists'][$head])) {
               $prepared[] = array($head, $item, '');
            }
            else {
               $item->fatal("Unexpected '$head' list");
            }
         }
         elseif (!$index && $guide['nameable'] &&
               ($item->typeMask() & LispValue::tSymbolOrString)) {
            $itemName = $item->get();
         }
         elseif ($guide['mask'] & ($itemMask = $item->typeMask())) {
            foreach ($guide['terminals'] as $tstMask => $sym) {
               if ($itemMask & $tstMask) {
                  if ($sym == '=floats') {
                     if ($prepared && $prepared[count($prepared)-1][0] == '=floats') {
                        $prepared[count($prepared)-1][2][] = $item->get();
                     }
                     else {
                        $prepared[] = array($sym, $item, array($item->get()));
                     }
                  }
                  else {
                     $prepared[] = array($sym, $item, $item->get());
                  }
                  break;
               }
            }
         }
         else {
            $item->fatal("Unexpected atom '" . $item->get() . "'");
         }
      }

      $method = 'make' . ucfirst($symbol);
      return $this->$method($parent, $list->trim(), $itemName, $prepared);
   }

   private function make0($parent, $source, $itemName, $prepared) {
      foreach ($prepared as $item) {
         $this->parseList(NULL, $item[1]);
      }
      return NULL;
   }

   private function makeLayers($parent, $source, $itemName, $prepared) {
      $obj = new MapLayers($this, $source, NULL);
      $this->root = $obj;
      $myName = $obj->getName();
      foreach ($prepared as $item) {
         $layer = $this->parseList(NULL, $item[1]);
         $refObj = new MapLayerReference($this, $source, $myName, $layer->getName());
         $obj->addLayer($refObj);
      }
      return NULL;
   }

   private function makeLayer($parent, $source, $itemName, $prepared) {
      if (!isset($itemName)) {
         $source->fatal("Layer name missing");
      }
      $obj = new MapLayer($this, $source, $itemName);
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case 'menuitem':
               $data = $this->parseList(NULL, $item);
               $obj->setMenuitem($data);
               break;
            case 'features':
               $features = $this->parseList($obj, $item);
               foreach ($features as $feature) {
                  $obj->addFeature($feature);
               }
               break;
         }
      }
      return $obj;
   }

   private function makeMenuitem($parent, $source, $itemName, $prepared) {
      $menuitem = '';
      foreach ($prepared as $p) {
         $menuitem .= $p[2];
      }
      return $menuitem;
   }

   private function makeFeatures($parent, $source, $itemName, $prepared) {
      $features = array();
      $ownerName = $parent->getName();
      foreach ($prepared as $p) {
         $obj = new MapFeatureReference($this, $source, $ownerName, $p[2]);
         $features[] = $obj;
      }
      return $features;
   }

   private function makeFeature($parent, $source, $itemName, $prepared) {
      if (!isset($parent) && !isset($itemName)) {
         $source->fatal("No name given for non-embedded feature");
      }
      $obj = new MapFeature($this, $source, $itemName);
      $myName = $obj->getName();
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case 'popup':
               $data = $this->parseList($obj, $item);
               $obj->setPopup($data);
               break;
            case 'style':
               $data = $this->parseList($obj, $item);
               $obj->setStyle($data);
               break;
            case 'attestation':
               $data = $this->parseList($obj, $item);
               $obj->setAttestation($data);
               break;
            case 'point':
            case 'path':
            case 'route':
            case 'polygon':
            case 'rectangle':
            case 'circle':
            case 'marker':
            case 'segment':
            case 'feature':
               $feature = $this->parseList($obj, $item);
               $refObj = new MapFeatureReference($this, $source, $myName, $feature->getName());
               $obj->addFeature($refObj);
               break;
            case 'features':
            case 'segments':
               $features = $this->parseList($obj, $item);
               foreach ($features as $refObj) {
                  $obj->addFeature($refObj);
               }
               break;
         }
      }
      return $obj;
   }

   private function makePopup($parent, $source, $itemName, $prepared) {
      $string = '';
      foreach ($prepared as $p) {
         $string .= $p[2];
      }
      return $string;
   }

   private function makeStyle($parent, $source, $itemName, $prepared) {
      $obj = new MapStyle($this, $this->styler);
      foreach ($prepared as $p) {
         $obj->addKeyword($p[2], $p[1]);
      }
      return $obj;
   }

   private function makeAttestation($parent, $source, $itemName, $prepared) {
      $obj = new MapAttestation($this->attester, $parent);
      foreach ($prepared as $p) {
         $obj->addAttestation($p[2], $p[1]);
      }
      return $obj;
   }

   private function makeMarker($parent, $source, $itemName, $prepared) {
      $obj = new MapMarker($this, $source, $itemName);
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case 'html':
               $data = $this->parseList($obj, $item);
               $obj->setHtml($data);
               break;
            case 'popup':
               $data = $this->parseList($obj, $item);
               $obj->setPopup($data);
               break;
            case 'style':
               $data = $this->parseList($obj, $item);
               $obj->setStyle($data);
               break;
            case 'attestation':
               $data = $this->parseList($obj, $item);
               $obj->setAttestation($data);
               break;
            case '=floats':
               $nums = $text;
               if (count($nums) != 2) {
                  $source->fatal("Need a single latitude/longitude tuple");
               }
               $obj->setCoords($nums);
               break;
         }
      }
      return $obj;
   }

   private function makeHtml($parent, $source, $itemName, $prepared) {
      $string = '';
      foreach ($prepared as $p) {
         $string .= $p[2];
      }
      return $string;
   }

   private function makePoint($parent, $source, $itemName, $prepared) {
      $obj = new MapPoint($this, $source, $itemName);
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case '=floats':
               $nums = $text;
               if (count($nums) != 2) {
                  $source->fatal("Need a single latitude/longitude tuple");
               }
               $obj->setCoords($nums);
               break;
         }
      }
      return $obj;
   }

   private function makePath($parent, $source, $itemName, $prepared) {
      $obj = new MapPath($this, $source, $itemName);
      $coords = array();
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case '=floats':
               $coords = array_merge($coords, $text);
               break;
            case 'popup':
               $data = $this->parseList($obj, $item);
               $obj->setPopup($data);
               break;
            case 'style':
               $data = $this->parseList($obj, $item);
               $obj->setStyle($data);
               break;
            case 'attestation':
               $data = $this->parseList($obj, $item);
               $obj->setAttestation($data);
               break;
         }
      }
      if (!count($coords)) {
         $source->fatal("Need at least one latitude/longitude tuple");
      }
      if (count($coords) & 1) {
         $source->fatal("Odd number of latitude/longitude values");
      }
      $obj->setCoords($coords);
      return $obj;
   }

   private function makeRectangle($parent, $source, $itemName, $prepared) {
      $obj = new MapRectangle($this, $source, $itemName);
      $coords = array();
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case '=floats':
               $coords = array_merge($coords, $text);
               break;
            case 'popup':
               $data = $this->parseList($obj, $item);
               $obj->setPopup($data);
               break;
            case 'style':
               $data = $this->parseList($obj, $item);
               $obj->setStyle($data);
               break;
            case 'attestation':
               $data = $this->parseList($obj, $item);
               $obj->setAttestation($data);
               break;
         }
      }
      if (!count($coords)) {
         $source->fatal("Need at least one latitude/longitude tuple");
      }
      if (count($coords) & 1) {
         $source->fatal("Odd number of latitude/longitude values");
      }
      $obj->setCoords($coords);
      return $obj;
   }

   private function makePolygon($parent, $source, $itemName, $prepared) {
      $obj = new MapPolygon($this, $source, $itemName);
      $coords = array();
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case '=floats':
               $coords = array_merge($coords, $text);
               break;
            case 'popup':
               $data = $this->parseList($obj, $item);
               $obj->setPopup($data);
               break;
            case 'style':
               $data = $this->parseList($obj, $item);
               $obj->setStyle($data);
               break;
            case 'attestation':
               $data = $this->parseList($obj, $item);
               $obj->setAttestation($data);
               break;
         }
      }
      if (!count($coords)) {
         $source->fatal("Need at least one latitude/longitude tuple");
      }
      if (count($coords) & 1) {
         $source->fatal("Odd number of latitude/longitude values");
      }
      $obj->setCoords($coords);
      return $obj;
   }

   private function makeCircle($parent, $source, $itemName, $prepared) {
      $obj = new MapCircle($this, $source, $itemName);
      $radius = $radiusUnits = NULL;
      $coords = array();
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case '=float':
               $coords[] = $text;
               break;
            case 'popup':
               $data = $this->parseList($obj, $item);
               $obj->setPopup($data);
               break;
            case 'style':
               $data = $this->parseList($obj, $item);
               $obj->setStyle($data);
               break;
            case 'attestation':
               $data = $this->parseList($obj, $item);
               $obj->setAttestation($data);
               break;
            case 'radius':
            case 'pixels':
               $data = $this->parseList($obj, $item);
               list($radius, $radiusUnits) = $data;
               break;
         }
      }
      if (count($coords) != 2) {
         $source->fatal("Need latitude/longitude of center of circle");
      }
      $obj->setCoords($coords);
      return $obj;
      if (!isset($radius)) {
         $source->fatal("Radius of circle is unspecified");
      }
      $obj->setRadius($radius, $radiusUnits);
      return $obj;
   }

   private function makeRadius($parent, $source, $itemName, $prepared) {
      return array($prepared[0][2], 'meters');
   }

   private function makePixels($parent, $source, $itemName, $prepared) {
      return array($prepared[0][2], 'pixels');
   }

   private function makeRoute($parent, $source, $itemName, $prepared) {
      if (!isset($parent) && !isset($itemName)) {
         $source->fatal("No name given for non-embedded route");
      }
      $obj = new MapRoute($this, $source, $itemName);
      $myName = $obj->getName();
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case 'popup':
               $data = $this->parseList($obj, $item);
               $obj->setPopup($data);
               break;
            case 'style':
               $data = $this->parseList($obj, $item);
               $obj->setStyle($data);
               break;
            case 'attestation':
               $data = $this->parseList($obj, $item);
               $obj->setAttestation($data);
               break;
            case 'path':
            case 'segment':
               $segment = $this->parseList($obj, $item);
               $refObj = new MapSegmentReference($this, $source, $myName, $segment->getName());
               $obj->addSegment($refObj);
               break;
            case 'segments':
               $segments = $this->parseList($obj, $item);
               foreach ($segments as $refObj) {
                  $obj->addSegment($refObj);
               }
               break;
         }
      }
      return $obj;
   }

   private function makeSegment($parent, $source, $itemName, $prepared) {
      if (!isset($parent) && !isset($itemName)) {
         $source->fatal("No name given for non-embedded segment");
      }
      $obj = new MapSegment($this, $source, $itemName);
      $myName = $obj->getName();
      foreach ($prepared as $p) {
         list($symbol, $item, $text) = $p;
         switch ($symbol) {
            case 'popup':
               $data = $this->parseList($obj, $item);
               $obj->setPopup($data);
               break;
            case 'style':
               $data = $this->parseList($obj, $item);
               $obj->setStyle($data);
               break;
            case 'attestation':
               $data = $this->parseList($obj, $item);
               $obj->setAttestation($data);
               break;
            case 'path':
               $path = $this->parseList($obj, $item);
               $refObj = new MapPathReference($this, $source, $myName, $path->getName());
               $obj->addPath($refObj);
               break;
            case 'paths':
               $paths = $this->parseList($obj, $item);
               foreach ($paths as $refObj) {
                  $obj->addPath($refObj);
               }
               break;
         }
      }
      return $obj;
   }

   private function makeSegments($parent, $source, $itemName, $prepared) {
      $segments = array();
      $ownerName = $parent->getName();
      foreach ($prepared as $p) {
         $obj = new MapSegmentReference($this, $source, $ownerName, $p[2]);
         $segments[] = $obj;
      }
      return $segments;
   }

   private function makePaths($parent, $source, $itemName, $prepared) {
      $paths = array();
      $ownerName = $parent->getName();
      foreach ($prepared as $p) {
         $obj = new MapPathReference($this, $source, $ownerName, $p[2]);
         $paths[] = $obj;
      }
      return $paths;
   }




   public function registerMapItem($object, $name) {
      $index = count($this->mapItems);
      if (isset($name)) {
         if (isset($this->mapItems[$name])) {
            $object->fatal("Duplicate use of name '$name'");
         }
      }
      else {
         $name = ":$index";
      }
      $this->mapItems[$name] = $object;
      return $name;
   }

   public function registerReferenceItem($object, $ownerName, $targetName) {
      $this->referenceItems[] = array($object, $ownerName, $targetName);
   }

   public function registerMapItemUse($name, $user, $acceptableTypes) {
      if (!isset($this->mapItems[$name])) {
         $user->fatal("Cannot locate object with symbol '$name'");
      }
      $target = $this->mapItems[$name];
      $type = $target->itemType();
      if (!in_array($type, $acceptableTypes)) {
         $user->fatal("Referenced item '$name' is a '$type'; only " .
            self::andList($acceptableTypes, 'or') . " allowed");
      }
      if (isset($this->mapItems[$name]['uses'])) {
         $this->mapItems[$name]['uses']++;
      }
      else {
         $this->mapItems[$name]['uses'] = 1;
      }
      return $this->mapItems[$name]['object']->getItemIndex();
   }

   private static function andList($words, $conjunction = 'and') {
      if (count($words) > 1) {
         if (count($words) > 2) {
            for ($i = count($words) - 1; $i >= 0; $i--) {
               $words[$i] .= ',';
            }
         }
         $words = array_splice($words, count($words) - 1, 0, $conjunction);
      }
      return implode(' ', $words);
   }
}

