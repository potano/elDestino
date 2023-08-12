<?php

$digits = '6';
$filename = NULL;

$args = $argv;
$myself = array_shift($args);
while ($args) {
   $arg = array_shift($args);
   if (substr($arg, 0, 1) == '-') {
      $parm = $want = NULL;
      if (substr($arg, 1, 1) == '-') {
         $parts = explode('=', $arg, 2);
         $parts[] = NULL;
         list($arg, $parm) = $parts;
      }
      switch ($arg) {
         case '--digits':
            $want = 'digits';
            break;
         default:
            fatal("Unknown switch $arg");
      }
      if (isset($want)) {
         if (!isset($parm)) {
            if (!$args || substr($arg, 0, 1) == '-') {
               fatal("$arg requires a parameter");
            }
            $parm = array_shift($args);
         }
         $$want = $parm;
      }
   }
   elseif (!isset($filename)) {
      $filename = $arg;
   }
   else {
      fatal("Uknown '$arg' argument");
   }
}

if (!ctype_digit($digits)) {
   fatal("--digits switch requires an integer value");
}
if (!isset($filename)) {
   fatal("Need an input filename");
}
if (!is_file($filename)) {
   fatal("$filename does not exist or is not a file");
}

define('FLOATFMT', '%.' . $digits . 'f');
define('QUOTE_KEYS', TRUE);

if (!preg_match('/(.*?)\.(geojson|gpx)$/', basename($filename), $matches)) {
   fatal("Cannot recognize extension of $filename");
}
list(, $basename, $ext) = $matches;

$blob = file_get_contents($filename);
if ($blob === FALSE) {
   fatal("Cannot read $filename");
}

$segments = array();
switch ($ext) {
   case 'geojson':
      $json = json_decode($blob, 1);
      if ($json === FALSE) {
         fatal("$filename does not contain valid JSON");
      }
      getGeoJsonSegments($segments, $json, $basename);
      break;
   case 'gpx':
      $doc = simplexml_load_string($blob);
      if ($blob === FALSE) {
         fatal("$filename does not contain valid XML");
      }
      getGpxSegments($segments, $doc, $basename);
      break;
   default:
      fatal("Unknown extension $ext");
}

$routesegs = $paths = array();
foreach ($segments as $segment) {
   $paths[] = array_merge(array($segment['type'], $segment['name']), $segment['points']);
   $routesegs[] = array('segment', $segment['name']);
}
$collectionType = 'route';
if (isset($paths[0][0]) && $paths[0][0] == 'polygon') {
   $collectionType = 'feature';
}
$routes = array(
   array($collectionType, $basename, $routesegs)
);

$doc = array($routes, $paths);
//print_r($doc); exit(0);

printSexp($doc, 0, array());
echo "\n";




function fatal($msg) {
   fwrite(STDERR, "$msg\n");
   exit(1);
}


function getGeoJsonSegments(& $segments, $json, $basename) {
   if ($json['type'] == 'FeatureCollection') {
      foreach ($json['features'] as $feature) {
         getGeoJsonSegments($segments, $feature, $basename);
      }
   }
   elseif ($json['type'] == 'Feature') {
      if (!isset($json['geometry']['type'])) {
         fatal("Expecting geometry");
      }
      switch ($json['geometry']['type']) {
         case 'MultiLineString':
            $geoType = 'path';
            $numLevels = 1;
            break;
         case 'MultiPolygon':
            $geoType = 'polygon';
            $numLevels = 2;
            break;
         default:
            fatal("Expecting MultiLineString");
      }
      $name = $basename;
      if (isset($json['properties'])) {
         $properties = $json['properties'];
         if (isset($properties['id'])) {
            $name .= '_' . $properties['id'];
         }
         elseif (isset($properties['source'])) {
            $name .= '_' . $properties['source'];
         }
      }
      $groups = $json['geometry']['coordinates'];
      if ($numLevels == 1) {
         foreach ($groups as $pairs) {
            $segments[] = getGeoJsonSegment($geoType, $name, $pairs);
         }
      }
      elseif ($numLevels == 2) {
         foreach ($groups as $group) {
            foreach ($group as $px => $pairs)
               $gname = $name . '_' . ($px + 1);
               $segments[] = getGeoJsonSegment($geoType, $gname, $pairs);
         }
      }
   }
   else {
      fatal("Can't use {$json['type']} GeoJSON object");
   }
}

function getGeoJsonSegment($type, $name, $pairs) {
   $segment = array();
   foreach ($pairs as $pair) {
      list($long, $lat) = $pair;
      $segment[] = $lat;
      $segment[] = $long;
   }
   return array('type' => $type, 'name' => $name, 'points' => $segment);
}


function getGpxSegments(& $segments, $doc, $basename) {
   $num = 0;
   foreach ($doc->trk as $trk) {
      $nm = (string) $trk->name;
      if (strlen($nm)) {
         $name = $nm;
      }
      else {
         $name = $basename;
      }
      foreach ($trk->trkseg as $num => $trkseg) {
         $num = (int) $num;
         $segname = $num ? "$name_$num" : $name;
         $segment = array();
         foreach ($trkseg->trkpt as $trkpt) {
            $segment[] = (float) $trkpt['lat'];
            $segment[] = (float) $trkpt['lon'];
         }
         $segment = array('type' => 'path', 'name' => $name, 'points' => $segment);
         $segments[] = $segment;
      }
   }
}



function printSexp($doc, $indent) {
   if (is_string($doc)) {
      echo "\"$doc\"";
   }
   elseif (is_bool($doc)) {
      echo $doc ? 'true' : 'false';
   }
   elseif (is_null($doc)) {
      echo 'null';
   }
   elseif (is_numeric($doc)) {
      echo $doc;
   }
   elseif (is_array($doc)) {
      if (!$doc) {
         return;
      }
      if (is_array($doc[0])) {
         foreach ($doc as $arr) {
            printSexp($arr, $indent, FALSE);
         }
         return;
      }
      $headLeader = str_repeat(" ", $indent);
      echo "({$doc[0]}";
      $next = 1;
      if (isset($doc[1]) && !is_array($doc[1])) {
         echo ' ', printSexp($doc[1], 0, FALSE);
         $next = 2;
         $indent += strlen($doc[0]) + 2;
      }
      else {
         $indent += 3;
      }
      $leader = str_repeat(" ", $indent);
      echo "\n";
      $keys = array_keys($doc);
      $indexed = TRUE;
      if (($doc[0] == 'path' || $doc[0] == 'polygon') && is_float($doc[$next])) {
         foreach (array_slice($doc, $next) as $i => $val) {
            $odd = $i & 1;
            if (!$odd) {
               echo "$leader";
            }
            printf(FLOATFMT, $val);
            echo $odd ? "\n" : ' ';
         }
      }
      else {
         foreach (array_slice($keys, $next) as $i => $key) {
            echo $leader;
            printSexp($doc[$key], $indent);
            echo "\n";
         }
      }
      echo "$headLeader)\n";
   }
   else {
      fatal("unknown object type $json");
   }
}

