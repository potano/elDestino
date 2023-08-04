<?php

define('FLOATFMT', '%.6f');
define('QUOTE_KEYS', TRUE);

if ($argc < 2) {
   fatal("Need an input filename");
}
$filename = $argv[1];
if (!is_file($filename)) {
   fatal("$filename does not exist or is not a file");
}

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
   $paths[] = array_merge(array('path', $segment['name']), $segment['points']);
   $routesegs[] = array('segment', $segment['name']);
}
$routes = array(
   array('route', $basename, $routesegs)
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
      if (!isset($json['geometry']) || $json['geometry']['type'] != 'MultiLineString') {
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
      $segment = array();
      foreach ($json['geometry']['coordinates'] as $pairs) {
         foreach ($pairs as $pair) {
            list($long, $lat) = $pair;
            $segment[] = $lat;
            $segment[] = $long;
         }
      }
      $segment = array('name' => $name, 'points' => $segment);
      $segments[] = $segment;
   }
   else {
      fatal("Can't use {$json['type']} GeoJSON object");
   }
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
         $segment = array('name' => $name, 'points' => $segment);
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
      if ($doc[0] == 'path' && is_float($doc[$next])) {
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

