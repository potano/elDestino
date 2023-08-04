<?php
// Copyright © 2023 Michael Thompson
// SPDX-License-Identifier: GPL-2.0-or-later


abstract class MapReferenceItem extends MapItem {
   protected $targetName;
   protected $targetObject;

   function __construct($vectors, $source, $ownerName, $target) {
      $this->source = $source;
      $this->name = $vectors->registerReferenceItem($this, $ownerName, $target);
      $this->targetName = $target;
   }

   function setTargetObject($targetObject) {
      $this->targetObject = $targetObject;
   }

   function getTargetObject() {
      return $this->targetObject;
   }

   abstract function acceptableTypes();

   function generateCode() {
      if ($this->targetObject->itemIndex < 0) {
         return $this->targetObject->generateCode();
      }
      return "s{$this->targetObject->itemIndex}";
   }
}

class MapLayerReference extends MapReferenceItem {
   function acceptableTypes() {
      return array('layer');
   }
}

class MapFeatureReference extends MapReferenceItem {
   function acceptableTypes() {
      return array('feature', 'marker', 'point', 'path', 'polygon', 'rectangle', 'circle',
        'route');
   }
}

class MapPathReference extends MapReferenceItem {
   function acceptableTypes() {
      return array('path');
   }
}

class MapSegmentReference extends MapReferenceItem {
   function acceptableTypes() {
      return array('segment');
   }
}

