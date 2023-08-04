<?php
// Copyright © 2023 Michael Thompson
// SPDX-License-Identifier: GPL-2.0-or-later


abstract class MapItem {
   protected $name;
   protected $source;
   protected $type;
   protected $itemIndex = -1;

   function getName() {
      return $this->name;
   }

   function getItemIndex() {
      return $this->itemIndex;
   }

   function setItemIndex($value) {
      $this->itemIndex = $value;
   }

   function itemType() {
      return $this->type;
   }

   function fatal($msg) {
      $this->source->fatal($msg);
   }

   function generateCode() {
      return guideToJavascriptObject($this->generateGuide());
   }
}

class MapLayers extends MapItem {
   protected $layers = array();

   function __construct($vectors, $source, $name) {
      $this->source = $source;
      $this->name = $vectors->registerMapItem($this, $name);
   }

   function addLayer($layer) {
      $this->layers[] = $layer;
   }

   function generateGuide() {
      return $this->layers;
   }
}

class MapLayer extends MapItem {
   protected $menuitem;
   protected $features = array();
   protected $type = 'layer';

   function __construct($vectors, $source, $layerName) {
      $this->source = $source;
      $this->name = $vectors->registerMapItem($this, $layerName);
   }

   function setMenuitem($text) {
      $this->menuitem = $text;
   }

   function addFeature($feature) {
      $this->features[] = $feature;
   }

   function generateGuide() {
      return array('menuitem' => $this->menuitem, 'features' => $this->features);
   }
}

class MapFeature extends MapItem {
   use MemberAccess;
   protected $popup;
   protected $markerHtml;
   protected $style;
   protected $attestation;
   protected $geometry;
   protected $features = array();
   protected $type = 'feature';

   function __construct($vectors, $source, $featureName) {
      $this->source = $source;
      $this->name = $vectors->registerMapItem($this, $featureName);
   }

   function setPopup($data) {
      $this->popup = $data;
   }

   function setStyle($style) {
      $this->style = $style;
   }

   function setAttestation($att) {
      $this->attestation = $att;
   }

   function addFeature($feature) {
      $this->features[] = $feature;
   }

   function generateGuide() {
      return $this->membersToArray(array('popup', 'style', 'features'), 'feature');
   }
}

class MapMarker extends MapItem {
   use MemberAccess;
   protected $popup;
   protected $html;
   protected $style;
   protected $attestation;
   protected $coords;
   protected $type = 'marker';

   function __construct($vectors, $source, $featureName) {
      $this->source = $source;
      $this->name = $vectors->registerMapItem($this, $featureName);
   }

   function setPopup($data) {
      $this->popup = $data;
   }

   function setHtml($data) {
      $this->html = $data;
   }

   function setStyle($style) {
      $this->style = $style;
   }

   function setAttestation($att) {
      $this->attestation = $att;
   }

   function setCoords($coords) {
      $this->coords = $coords;
   }

   function generateGuide() {
      return $this->membersToArray(array('popup', 'html', 'style', 'coords'), 'marker');
   }
}

class MapPath extends MapItem {
   use MemberAccess;
   protected $popup;
   protected $style;
   protected $attestation;
   protected $coords;
   protected $type = 'path';

   function __construct($vectors, $source, $name) {
      $this->source = $source;
      $this->name = $vectors->registerMapItem($this, $name);
   }

   function setPopup($popup) {
      $this->popup = $popup;
   }

   function setStyle($style) {
      $this->style = $style;
   }

   function setAttestation($attestation) {
      $this->attestation = $attestation;
   }

   function setCoords($coords) {
      $this->coords = $coords;
   }

   function getCoords() {
      return $this->coords;
   }

   function generateGuide() {
      return $this->membersToArray(array('popup', 'style', 'attestation', 'coords'), $this->type);
   }
}

class MapPoint extends MapPath {
   protected $type = 'point';
}

class MapPolygon extends MapPath {
   protected $type = 'polygon';
}

class MapRectangle extends MapPath {
   protected $type = 'rectangle';
}

class MapCircle extends MapPath {
   use MemberAccess;
   protected $radius;
   protected $asPixels;
   protected $type = 'circle';

   function setRadius($radius, $units) {
      $this->radius = $radius;
      $this->asPixels = $units == 'pixels';
   }

   function generateGuide() {
      return $this->membersToArray(array('popup', 'style', 'coords', 'radius', 'asPixels'),
         'circle');
   }
}

class MapSegment extends MapItem {
   use MemberAccess;
   protected $type = 'segment';
   protected $popup;
   protected $style;
   protected $attestation;
   protected $paths;

   function __construct($vectors, $source, $name) {
      $this->source = $source;
      $this->name = $vectors->registerMapItem($this, $name);
   }

   function setPopup($popup) {
      $this->popup = $popup;
   }

   function setStyle($style) {
      $this->style = $style;
   }

   function setAttestation($attestation) {
      $this->attestation = $attestation;
   }

   function addPath($path) {
      $this->paths[] = $path;
   }

   function getPaths() {
      return $this->paths;
   }

   function generateGuide() {
      return $this->membersToArray(array('popup', 'style', 'attestation', 'paths'), 'segment');
   }
}

class MapRoute extends MapItem {
   use MemberAccess;
   protected $type = 'route';
   protected $popup;
   protected $style;
   protected $attestation;
   protected $segments = array();

   function __construct($vectors, $source, $routeName) {
      $this->source = $source;
      $this->name = $vectors->registerMapItem($this, $routeName);
   }

   function setPopup($popup) {
      $this->popup = $popup;
   }

   function setStyle($style) {
      $this->style = $style;
   }

   function setAttestation($attestattion) {
      $this->attestation = $attestation;
   }

   function addSegment($segment) {
      $this->features[] = $segment;
   }

   function getSegments() {
      return $this->features;
   }

   function generateGuide() {
      return $this->membersToArray(array('popup', 'style', 'features'), 'route');
   }
}


class MapStyle extends MapItem {
   //Note that this is not a structural element: it is not to be registered with registerMapItem
   protected $vectors;
   protected $styler;
   protected $styleName;

   function __construct($vectors, $styler) {
      $this->vectors = $vectors;
      $this->styler = $styler;
   }

   function addKeyword($kw, $source) {
      if (isset($this->styleName)) {
         $source->fatal("More than one style name specified");
      }
      if (!$this->styler->checkStyleName($kw)) {
         $source->fatal("Unknown style name $kw");
      }
      $this->styleName = $kw;
   }

   function generateCode() {
      return isset($this->styleName) ? $this->styleName : '';
   }
}

class MapAttestation extends MapItem {
   //Note that this is not a structural element: it is not to be registered with registerMapItem
   const segment = 'segment';
   const path = 'path';
   private $parentType;
   private $attester;
   private $attestations = array();
   private $authorityWeight = 0;
   private $confidenceLevel;
   private $modernityLevel;

   function __construct($attester, $parent) {
      $this->attester = $attester;
      $this->parentType = $parent->itemType();
   }

   function addAttestation($token, $source) {
      if (isset($this->attestations[$token])) {
         $source->fatal("Already applied '$token' attestation");
      }
      list($type, $weight) = $this->attester->tokenAttributes($token, $source);
      switch ($type) {
         case 'authority':
            if ($this->parentType == self::path) {
               $source->fatal("Cannot apply '$type' attestation to path");
            }
            $this->authorityWeight += $weight;
            break;
         case 'confidence':
            if ($this->parentType == self::path) {
               $source->fatal("Cannot apply '$token' attestation to path");
            }
            if (isset($this->confidenceLevel)) {
               $source->fatal("Cannot apply '$token' confidence attestation; already have '" .
                  $this->confidenceLevel . "'");
            }
            $this->confidenceLevel = $weight;
            break;
         case 'modern':
            if ($this->parentType == self::segment) {
               $source->fatal("Cannot apply '$token' attestation to segment");
            }
            if (isset($this->modernityLevel)) {
               $source->fatal("Cannot apply '$token' attestation; already have '" .
                  $this->confidenceLevel . "'");
            }
            $this->modernityLevel = $weight;
            break;
      }
      $this->attestations[$token] = 1;
   }

   function generateCode() {
      return $this->attester->getStyle($this->parentType, $this->authorityWeight,
         $this->confidenceLevel, $this->modernityLevel);
   }
}



trait MemberAccess {
   function membersToArray($names, $typename = NULL) {
      $out = isset($typename) ? array('t' => $typename) : array();
      foreach ($names as $name) {
         if (isset($this->$name)) {
            $out[$name] = $this->$name;
         }
      }
      return $out;
   }
}


function guideToJavascriptObject($arr) {
   $out = '';
   if (is_object($arr)) {
      return $arr->generateCode();
   }
   if (!is_array($arr)) {
      if (is_bool($arr)) {
         return $arr ? 'true' : 'false';
      }
      if (is_null($arr)) {
         return 'null';
      }
      if (is_numeric($arr)) {
         return $arr;
      }
      if (substr($arr, 0, 2) == '!~') {
         return substr($arr, 2);
      }
      while (strlen($arr)) {
         preg_match("/^(.*?)([\\n']|$)/m", $arr, $matches);
         list($match, $clean, $sep) = $matches;
         $out .= $clean;
         if ($sep == "'") {
            $out .= "\\'";
         }
         else if ($sep == "\n") {
            $out .= "\\n";
         }
         $arr = substr($arr, strlen($match));
      }
      return "'$out'";
   }
   $isArray = TRUE;
   foreach (array_keys($arr) as $index => $key) {
      if ((!is_int($key) && !ctype_digit($key)) || $key != $index) {
         $isArray = FALSE;
         break;
      }
   }
   if ($isArray) {
      $out .= "[";
      foreach ($arr as $item) {
         $out .= guideToJavascriptObject($item) . ",";
      }
      return "$out]";
   }
   $out .= "{";
   foreach ($arr as $key => $item) {
      $out .= "$key: " . guideToJavascriptObject($item) . ",\n";
   }
   return "$out}";
}

