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

$routesegs = array();
foreach ($segments as $segment) {
   $routesegs[] = array('segment' => $segment['name'], 'certainty' => 5);
}
$routes = array(
   $basename => array('name' => $basename, 'segments' => $routesegs)
);


$doc = array('routes' => $routes, 'segments' => $segments);

printJson($doc, 0, array());
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



function printJson($json, $numTabs, $coordinates) {
   if (is_string($json)) {
      echo "\"$json\"";
   }
   elseif (is_bool($json)) {
      echo $json ? 'true' : 'false';
   }
   elseif (is_null($json)) {
      echo 'null';
   }
   elseif (is_numeric($json)) {
      echo $json;
   }
   elseif (is_array($json)) {
      $keys = array_keys($json);
      $indexed = TRUE;
      foreach ($keys as $key) {
         if (!is_int($key)) {
            $indexed = FALSE;
            break;
         }
      }
      $headLeader = str_repeat("\t", $numTabs);
      $leader = $headLeader . "\t";
      ++$numTabs;
      if (!$keys) {
         echo $indexed ? '[]' : '{}';
      }
      elseif ($indexed) {
         if ($coordinates && is_float($json[0])) {
            echo "[\n";
            foreach ($json as $i => $val) {
               $odd = $i & 1;
               if (!$odd) {
                  echo "$headLeader\t";
               }
               printf(FLOATFMT, $val);
               echo $odd ? ",\n" : ', ';
            }
            echo "$headLeader]";
         }
         else {
            echo "[\n";
            foreach ($keys as $i => $key) {
               echo $leader;
               printJson($json[$key], $numTabs, $coordinates);
               echo $i < count($keys) - 1 ? ",\n" : "\n";
            }
            echo "$headLeader]";
         }
      }
      else {
         echo "{\n";
         foreach ($keys as $i => $key) {
            echo $leader, QUOTE_KEYS || !preg_match('/^[[:alpha:]]\w*$/', $key) ? "\"$key\"" : $key,
               ": ";
            printJson($json[$key], $numTabs, $key == 'points');
            echo $i < count($keys) - 1 ? ",\n" : "\n";
         }
         echo "$headLeader}";
      }
   }
   else {
      fatal("unknown object type $json");
   }
}

