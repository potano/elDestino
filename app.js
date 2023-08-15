// Copyright © 2023 Michael Thompson
// SPDX-License-Identifier: GPL-2.0-or-later
(function () {
   var doc = dommy(), body = doc.body, walker = doc.walker, objMerge = doc.objMerge;

   var viewport = body.getVisible();
   var h1Height = viewport.height;

   var mapdiv = body.tag('div $=map id=map');
   mapdiv.move({height: h1Height});
   var initialZoom = h1Height > 300 ? 13 : 12;
   var initialCenter = [30.405, -84.05];

   var makers = {
      path:      L.polyline,
      polygon:   L.polygon,
      rectangle: L.rectangle,
   };

   var map = L.map('map', {attributionControl: false}).setView(initialCenter, initialZoom)
   var osm = L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="http://openstreetmap.org/copyright">OpenStreetMap</a>'
   }).addTo(map);
   L.control.attribution().addAttribution('Main app © 2023, Michael Thompson').addTo(map);

   var layerControl = L.control.layers().addTo(map);
   for (var wk = walker(allVectors); wk(); ) {
      var menuitem = wk.value.menuitem;
      var layerGroup = L.layerGroup();
      addItems(layerGroup, wk.value.features, {});
      layerControl.addOverlay(layerGroup, menuitem);
      layerGroup.addTo(map);
   }

   function addItems(group, objectList, parentStyle) {
      for (var wk = walker(objectList); wk(); ) {
         addItem(group, wk.value, parentStyle);
      }
   }

   function addItem(group, obj, parentStyle) {
      var geo, style = parentStyle;
      if (obj.style) {
         style = objMerge(style, obj.style);
      }
      if (obj.attestation) {
         style = objMerge(style, obj.attestation);
      }
      switch (obj.t) {
         case 'feature':
         case 'route':
            if (!obj.features) {
               return;
            }
            geo = L.featureGroup();
            geo.setStyle(style);
            addItems(geo, obj.features, style);
            break;
         case 'segment':
            geo = L.featureGroup();
            geo.setStyle(style);
            addItems(geo, obj.paths, style);
            break;
         case 'marker':
            var icon;
            if (obj.html) {
               icon = L.divIcon({
                  className: 'marker-text-icon',
                  html: obj.html
               });
            }
            else {
               icon = new L.Icon.Default;
            }
            geo = L.marker(toPair(obj.coords), {icon: icon});
            break;
         case 'path':
         case 'polygon':
         case 'rectangle':
            geo = makers[obj.t](toPairs(obj.coords));
            geo.setStyle(style);
            break;
         case 'point':
            geo = L.point(obj.coords[0], obj.coords[1]);
            break;
         case 'circle':
            var fn = obj.asPixels ? L.circleMarker : L.circle;
            geo = fn([obj.coords[0], obj.coords[1]], {radius: obj.radius});
            geo.setStyle(style);
         default:
            console.log("Unknown item type " + obj.t);
      }
      if (obj.popup) {
         geo.bindPopup(obj.popup);
      }
      group.addLayer(geo);
   }


   function toPair(arr) {
      return arr.slice(0, 2);
   }

   function toPairs(arr) {
      var out = [];
      for (var i = 0; i < arr.length; i += 2) {
         out.push(arr.slice(i, i + 2));
      }
      return out;
   }
})();

