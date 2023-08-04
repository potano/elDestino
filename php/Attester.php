<?php
// Copyright © 2023 Michael Thompson
// SPDX-License-Identifier: GPL-2.0-or-later


class Attester {
   private $styler;
   private $authorityMultiplier;

   private static $allowed = array(
      'old_map' => array('authority', 2, 'traced from labelled route on old map'),
      'witness' => array('authority', 2, 'described in a account by a contemporaneous witness'),
      'marker' => array('authority', 2, 'described on a historical marker'),
      'scholarly' => array('authority', 2, 'described in a latter-day scholarly work'),
      'published' => array('authority', 1, 'published in a non-scholarly latter-day work'),
      'folktale' => array('authority', 1, 'part of the oral folklore of a place'),
      'modern_name' => array('modern', 'name', 'modern route with name indicative of historic use'),
      'modern_path' => array('modern', 'path', 'modern route without name hinting of history'),
      'excursion' => array('modern', 'excur', 'mapped paths away from straightend highways'),
      'guess' => array('modern', 'guess', 'connects better-attested points'),
      'highest' => array('confidence', 'highest', 'highest confidence'),
      'high' => array('confidence', 'high', 'high confidence'),
      'medium' => array('confidence', 'medium', 'medium confidence'),
      'low' => array('confidence', 'low', 'low confidence'),
      'lowest' => array('confidence', 'lowest', 'lowest confidence'),
   );

   function __construct($styler) {
      $this->styler = $styler;
      $authoritySum = 0;
      foreach (self::$allowed as $item) {
         if ($item[0] == 'authority') {
            $authoritySum += $item[1];
         }
      }
      $this->authorityMultiplier = $styler->getNumberOfAuthorityLevels() / $authoritySum;
   }

   function tokenAttributes($token, $source) {
      if (!isset(self::$allowed[$token])) {
         $source->fatal("Unknown attribution keyword '$token'");
      }
      return self::$allowed[$token];
   }

   function getStyle($parentType, $authority, $confidence, $modernity) {
      $combo = array();
      if (isset($authority)) {
         $combo['authority'] = (int) (0.5 + $authority * $this->authorityMultiplier);
      }
      if (isset($confidence)) {
         $combo['confidence'] = $confidence;
      }
      if (isset($modernity)) {
         $combo['modernity'] = $modernity;
      }
      return $this->styler->getAttesterStyle($combo);
   }
}

