<?php
// Copyright © 2023 Michael Thompson
// SPDX-License-Identifier: GPL-2.0-or-later

require_once(__DIR__ . "/Sexp.php");
require_once(__DIR__ . "/VectorData.php");
require_once(__DIR__ . "/MapItem.php");
require_once(__DIR__ . "/MapReferenceItem.php");
require_once(__DIR__ . "/Attester.php");
require_once(__DIR__ . "/Styler.php");

define('DEG_TO_RADIANS', M_PI / 180);
define('METERS_PER_MILE', 1609.344);
define('EARTH_RADIUS', 6372768);
//Earth radius is computed according to the WGS 84 datum at 30.174861°N, the latitude midway
// between Tallahassee (30.455000°N) and St. Augustine (29.894722°N)
// Calculator URL: https://planetcalc.com/7721/

$sourceDir = '.';
$generate = $measure = $upto = NULL;
$asMiles = FALSE;

$args = $argv;
$myself = array_shift($args);
while ($args) {
   $arg = array_shift($args);
   if (substr($arg, 0, 1) == '-') {
      $want = $parm = NULL;
      if (substr($arg, 1, 1) == '-' && ($p = strpos($arg, '=')) > 0) {
         list($arg, $parm) = explode('=', $arg, 2);
      }
      switch ($arg) {
         case '-d':
            $want = 'sourceDir';
            break;
         case '-g':
            $want = 'generate';
            break;
         case '-m':
            $want = 'measure';
            break;
         case '-u':
            $want = 'upto';
            break;
         case '--miles':
            $asMiles = TRUE;
            break;
         default:
            fatal("Unknown switch $arg");
      }
      if (isset($want)) {
         if (!isset($parm)) {
            if (!isset($args[0]) || (substr($args[0], 0, 1) == '-' && strlen($args[0]) > 1)) {
               fatal("$arg switch requires a parameter value");
            }
            $parm = array_shift($args);
         }
         $$want = $parm;
      }
   }
   else {
      fatal("Unknown argument $arg");
   }
}

if ($generate == '-') {
   $generate = 'php://stdout';
}


$vectors = new VectorData();

if (substr($sourceDir, -1) == '/') {
   $sourceDir = substr($sourceDir, 0, -1);
}
try {
   foreach (glob("$sourceDir/*.sexp") as $filename) {
      $proc = new Sexp();
      $data = $proc->parse(file_get_contents($filename), $filename);
      $vectors->consumeFileSexps($filename, $data);
   }
   $vectors->resolveReferences();
//   print_r($vectors);
   if ($generate) {
      $jsblob = $vectors->generateCode();
      $jsblob = "(function () { $jsblob })()\n";
      file_put_contents($generate, $jsblob);
   }
   elseif (strlen($measure)) {
      measure($vectors, $measure, $upto, $asMiles);
   }
} catch (Exception $e) {
   fatal($e->getMessage());
}


function fatal($msg) {
   fwrite(STDERR, "$msg\n");
   exit(1);
}


function measure($vectors, $name, $upto, $asMiles) {
   if (isset($upto)) {
      if ($asMiles) {
         $upto *= METERS_PER_MILE;
      }
      elseif (!ctype_digit($upto)) {
         fatal("Need an integer value for the -u (upto) switch");
      }
   }
   $obj = $vectors->getMapitem($name);
   if (!isset($obj)) {
      fatal("No such object $name");
   }
   $coords = array();
   $itemType = $obj->itemType();
   switch ($itemType) {
      case 'path':
         $coords = $obj->getCoords();
         break;
      case 'route':
         foreach ($obj->getSegments() as $segment) {
            if ($segment instanceof MapSegmentReference) {
               $segment = $segment->getTargetObject();
            }
            foreach ($segment->getPaths() as $path) {
               if ($path instanceof MapPathReference) {
                  $path = $path->getTargetObject();
               }
               $pc = $path->getCoords();
               if ($coords) {
                  $ending = array_slice($coords, count($coords) - 2);
                  $start = array_splice($pc, 0, 2);
                  if ($start[0] != $ending[0] || $start[1] != $ending[1]) {
                     fatal("Path " . $path->getName() . " does not continue previous path");
                  }
                  $coords = array_merge($coords, $pc);
               }
               else {
                  $coords = $pc;
               }
            }
         }
         break;
      default:
         fatal("Named $itemType object is not a route or a path");
   }
   foreach ($coords as $i => $c) {
      $coords[$i] *= DEG_TO_RADIANS;
   }
   $distance = 0;
   $prevLat = $prevLong = $prevDistance = NULL;
   for ($i = 0; $i < count($coords); $i += 2) {
      $lat = $coords[$i];
      $long = $coords[$i + 1];
      if ($i) {
         // Haversine distance computation
         $sinDlat = sin(($lat - $prevLat) / 2);
         $sinDlong = sin(($long - $prevLong) / 2);
         $a = $sinDlat * $sinDlat + cos($lat) * cos($prevLat) * $sinDlong * $sinDlong;
         $c = 2 * atan2(sqrt($a), sqrt(1 - $a));
         $seglen = EARTH_RADIUS * $c;
         $distance += $seglen;
      }
      if (isset($upto) && $distance >= $upto) {
         printf("Distance to %0.6f latitude %0.6f longitude: %0.1f meters (%0.2f miles)\n",
            $lat / DEG_TO_RADIANS, $long / DEG_TO_RADIANS, $distance, $distance / METERS_PER_MILE);
         if ($prevDistance && ($upto - $prevDistance) < ($distance - $upto)) {
            printf("Distance to %0.6f latitude %0.6f longitude: %0.1f meters (%0.2f miles)\n",
               $lat / DEG_TO_RADIANS, $long / DEG_TO_RADIANS, $prevDistance,
               $prevDistance / METERS_PER_MILE);
         }
         return;
      }
      $prevLat = $lat;
      $prevLong = $long;
      $prevDistance = $distance;
   }
   if (isset($upto)) {
      fatal("$itemType is shorter than $upto meters\n");
   }
   printf("%0.1f meters (%0.2f miles)\n", $distance, $distance / METERS_PER_MILE);
}

