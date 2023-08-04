#!/bin/sh
# Copyright © 2023 Michael Thompson
# SPDX-License-Identifier: GPL-2.0-or-later

dommyTs=$(stat -c %Y vendor/dommyAll.js)
leafletTs=$(stat -c %Y vendor/leaflet/leaflet.js)
leafletCssTs=$(stat -c %Y vendor/leaflet/leaflet.css)
localCssTs=$(stat -c %Y local.css)
dataTs=$(stat -c %Y data.js)
appTs=$(stat -c %Y app.js)

mydir=$(dirname $0)

cat >"$mydir/index.html" <<END
<html>
   <head>
      <!-- SPDX-License-Identifier: GPL-2.0-or-later -->
      <meta charset="UTF-8"/>
      <title>El Destino and Aspalaga</title>
      <meta name="viewport"
         content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
      <script src="dommyAll.js?t=$dommyTs"></script>
      <link rel="stylesheet" href="leaflet.css?t=$leafletCssTs"/>
      <link rel="stylesheet" href="local.css?t=$localCssTs"/>
      <script src="leaflet.js?t=$leafletTs"></script>
      <script src="data.js?t=$dataTs"></script>
   </head>
   <body>
      <script src="app.js?t=$appTs"></script>
   </body>
</html>
END

