<?php
// Copyright © 2023 Michael Thompson
// SPDX-License-Identifier: GPL-2.0-or-later

class Styler {
   private $referencedStyles = array();

   private static $baseStyles = array(
      "elDestinoStyle" => array(
         "color" => "#1f78b4",
         "opacity" => 0.9,
         "fill" => TRUE,
         "fillColor" => "#1f78b4",
         "fillOpacity" => 0.1,
      ),
      "indefiniteAreaStyle" => array(
         "color" => "#b47820",
         "opacity" => 0.8,
         "fill" => TRUE,
         "fillColor" => "#b47820",
         "fillOpacity" => 0.1,
      ),
      "bellamyRoadStyle" => array(
         "color" => '#33AA33',
      ),
      "roadOfInterest" => array(
         "color" => '#AA3333',
         "opacity" => 0.6,
         "width" => 5,
      ),
      "railroad" => array(
         "color" => "#000000",
         "opacity" => 0.9,
         "width" => 1,
         "dashArray" => "3 5",
      ),
   );

   private static $attestationStyles = array(
      'authority' => array(
         array("opacity" => 0.8, "width" => 3),
         array("opacity" => 0.8, "width" => 2),
         array("opacity" => 0.7, "width" => 2),
         array("opacity" => 0.7, "width" => 1),
      ),
      'confidence' => array(
         'highest' => array(),
         'high'    => array(),
         'medium'  => array(),
         'low'     => array("width" => 2),
         'lowest'  => array("width" => 1),
      ),
      'modernity' => array(
         'name' =>  array(),
         'path' =>  array("dashArray" => "4 4"),
         'excur' => array("dashArray" => "4 8"),
         'guess' => array("dashArray" => "2 8"),
      ),
   );


   function checkStyleName($name) {
      if (!isset(self::$baseStyles[$name])) {
         return FALSE;
      }
      if (!isset($referencedStyles[$name])) {
         $this->referencedStyles[$name] = self::$baseStyles[$name];
      }
      return TRUE;
   }

   function getNumberOfAuthorityLevels() {
      return count(self::$attestationStyles['authority']);
   }

   function getAttesterStyle($combo) {
      $names = array();
      foreach ($combo as $key => $value) {
         $names[] = "{$key}_$value";
      }
      $name = implode('__', $names);
      if (!isset($this->referencedStyles[$name])) {
         $style = NULL;
         foreach ($combo as $key => $value) {
            if (isset($style)) {
               $style = array_merge(self::$attestationStyles[$key][$value]);
            }
            else {
               $style = self::$attestationStyles[$key][$value];
            }
         }
         $this->referencedStyles[$name] = $style;
      }
      return $name;
   }

   function generateCode() {
      $out = array();
      foreach ($this->referencedStyles as $name => $obj) {
         $out[] = "$name=" . guideToJavascriptObject($obj);
      }
      return 'var ' . implode(',', $out) . ";\n";
   }
}

