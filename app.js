// Copyright © 2023 Michael Thompson
// SPDX-License-Identifier: GPL-2.0-or-later
(function () {
   var doc = dommy(), body = doc.body, walker = doc.walker, objMerge = doc.objMerge;

   var viewport = body.getVisible();
   var h1Height = viewport.height;

   var mapdiv = body.tag('div id=map');
   mapdiv.move({height: h1Height});
   var initialZoom = h1Height > 300 ? 13 : 12;
   var initialCenter = [30.405, -84.05];
   if (window.force) {
      if (force.initialZoom) {
         initialZoom = force.initialZoom
      }
      if (force.initialCenter) {
         initialCenter = force.initialCenter
      }
   }

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

   var features = allData.features;
   var styles = allData.styles;
   var texts = allData.texts;
   var points = allData.points;

   var layerControl = L.control.layers().addTo(map);
   for (var wk = walker(allData.menuitems); wk(); ) {
      var menuitem = wk.value.menuitem;
      var layerGroup = L.layerGroup();
      addItems(layerGroup, wk.value.f, {});
      layerControl.addOverlay(layerGroup, menuitem);
      layerGroup.addTo(map);
   }

   var locationController = makeLocationController(map);
   var infoCtl = makeTextinfoControl(map);



   function addItems(group, objectList, parentStyle) {
      if (objectList) {
         for (var wk = walker(objectList); wk(); ) {
            addItem(group, wk.value, parentStyle);
         }
      }
   }

   function addItem(group, i, parentStyle) {
      var obj = features[i];
      var geo, style = parentStyle;
      if (obj.style) {
         style = objMerge(style, styles[obj.style]);
      }
      switch (obj.t) {
         case 'feature':
         case 'route':
            if (!obj.f) {
               return;
            }
            geo = L.featureGroup();
            geo.setStyle(style);
            addItems(geo, obj.f, style);
            break;
         case 'segment':
            geo = L.featureGroup();
            geo.setStyle(style);
            addItems(geo, obj.f, style);
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
            geo = L.marker(toPair(obj.loc), {icon: icon});
            break;
         case 'path':
            if (style.hidePath) {
               return;
            }
            // fall through
         case 'polygon':
         case 'rectangle':
            geo = makers[obj.t](toPairs(obj.loc));
            geo.setStyle(style);
            break;
         case 'circle':
            var fn = obj.asPixels ? L.circleMarker : L.circle;
            geo = fn(toPair(obj.loc), {radius: obj.radius});
            geo.setStyle(style);
            break;
         default:
            console.log("Unknown item type " + obj.t);
      }
      if (obj.popup) {
         geo.bindPopup(texts[obj.popup]);
      }
      group.addLayer(geo);
   }


   function toPair(loc) {
      return points.slice(loc[0], loc[0] + 2)
   }

   function toPairs(loc) {
      var pos = loc[0], lim = pos + loc[1];
      var out = [];
      while (pos < lim) {
         out.push(points.slice(pos, pos + 2));
         pos += 2;
      }
      return out;
   }


   function makeLocationController(map) {
      map.locate({
         watch: true,
         setView: false,
         enableHighAccuracy: true,
      });
      map.on('locationfound', handleLocation);
      map.on('locationerror', handleError);

      var marker, sureLocationIcon, staleLocationIcon, isSure;

      function handleLocation(evt) {
         if (!marker) {
            sureLocationIcon = makeIcon(true);
            staleLocationIcon = makeIcon(false);
            marker = L.marker(evt.latlng, {
               icon: sureLocationIcon,
               keyboard: false,
               alt: "",
            });
            marker.addTo(map);
            isSure = true;
            return;
         }
         if (!isSure) {
            marker.setIcon(sureLocationIcon);
            isSure = true;
         }
         marker.setLatLng(evt.latlng);
      }

      function handleError(evt) {
         if (marker && isSure) {
            marker.setIcon(staleLocationIcon);
            isSure = false;
         }
      }

      function makeIcon(makeSure) {
         var svg = body.wrapNS('svg', ['svg viewBox="0 0 40 40"',
            ['radialGradient id=g',
               'stop offset=0 @stop-color=color',
               'stop offset=0.5 @stop-color=color',
               'stop offset=0.9 stop-color=white',
               'stop offset=1 stop-color=black'],
            'circle fill=url(#g) cx=20 cy=20 r=20'], {color: makeSure ? 'blue' : 'grey'});
         var iconURL = 'data:image/svg+xml;base64,' + btoa(svg.toXML());
         return L.icon({
            iconUrl: iconURL,
            iconSize: [16, 16],
            iconAnchor: [8, 8],
            className: "marker-text-icon",
         });
      }
   }



   function makeTextinfoControl(map) {
      L.Control.Textinfo = L.Control.extend({
         onAdd: function (map) {
            var svg = body.wrap([':svg svg style=width:48px;height:48px viewport="0 0 48 48"',
               'circle cx=25 cy=25 r=20 fill=blue',
               'text font-family=serif font-size=40 font-style=italic fill=white x=20 y=38 _=i'
            ]);
            svg.track('click', goToTextinfo);
            return svg.dom;
         },
         onRemove: function (map) {},
      });

      L.control.textinfo = function (opts) {
         return new L.Control.Textinfo(opts);
      }

      L.control.textinfo({position: 'topright'}).addTo(map);
      return {};
   }

   function goToTextinfo() {
      if (!infoCtl.pages) {
         var ajax = dommy.ajax({method: 'GET'});
         ajax.request({uri: 'mapinfo.xml'}, {success: receiveData});
      }
      else {
         displayMainPage();
      }

      function receiveData(response) {
         if (response.responseXML) {
            infoCtl.pages = {};
            for (var wk = walker(response.responseXML.documentElement.children); wk(); ) {
               var elem = wk.value;
               if (elem.tagName == 'page') {
                  infoCtl.pages[elem.id] = elem;
               }
            }
            infoCtl.breadcrumb = [];
         }
         displayMainPage();
      }

      function displayMainPage() {
         mapdiv.hide();
         displayPage('main');
      }

      function displayPage(pageName) {
         var page = infoCtl.pages[pageName];
         if (!page) {
            return
         }
         if (!infoCtl.textDiv) {
            infoCtl.textDiv = body.tag(['div id=textDiv',
               ['div class=frametop',
                  ['span $=back',
                     [':svg svg viewBox="0 0 50 50"',
                        'polyline stroke=black stroke-width=4 fill=none points="23 10 10 25 23 40"',
                        'line stroke=black stroke-width=4 x1=12 y1=25 x2=40 y2=25'],
                     'span $=backText _ Go back'],
               ],
               ['div class=framebody $=textTarget']], infoCtl);
            infoCtl.back.track('click', goBack);
         }
         else {
            infoCtl.textTarget.removeChildren();
            infoCtl.textDiv.show();
         }
         infoCtl.backText.setText('Go back' + (infoCtl.breadcrumb.length ? '' : ' to map'));
         infoCtl.breadcrumb.push(pageName);
         renderDocElemChildren(infoCtl.textTarget, page);
      }

      function goBack() {
         infoCtl.breadcrumb.pop();
         if (infoCtl.breadcrumb.length) {
            var name = infoCtl.breadcrumb.pop();
            displayPage(name);
         }
         else {
            infoCtl.textDiv.hide();
            mapdiv.show();
         }
      }

      function renderDocElemChildren(target, elem) {
         for (var wk = walker(elem.childNodes); wk(); ) {
            var node = wk.value;
            switch (node.nodeType) {
               case 1:        // element
                  renderDocElem(target, node);
                  break;
               case 3:        // text node
               case 4:        // CDATA
                  target.addText(node.data);
                  break;
            }
         }
      }

      function renderDocElem(target, elem) {
         switch (elem.tagName) {
            case 'linkcol':
               var col = target.tag('div class=halfColumns');
               renderDocElemChildren(col, elem)
               break;
            case 'link':
               var link = target.tag('span class=link');
               renderDocElemChildren(link, elem);
               var ref = elem.getAttribute('ref');
               if (ref) {
                  link.track('click', doc.curry(displayPage, ref));
               }
               break;
            case 'strip':
               var color = elem.getAttribute('color');
               target.append([':svg svg viewBox="0 0 150 50"',
                  'rect @fill=color width=150 height=20 x=0 y=25'
               ], {color: color});
               break;
            case 'h':
            case 'h2':
               var node = target.tag({h: 'h2', h2: 'h3'}[elem.tagName]);
               renderDocElemChildren(node, elem);
               break;
            case 'a':
               var link = target.tag('a target=_blank class=link')
               link.setAttribute('href', elem.getAttribute('href'))
               renderDocElemChildren(link, elem);
               break;
            case 'br':
               target.append('br');
               break;
            default:
               var node = target.tag(elem.tagName);
               renderDocElemChildren(node, elem);
               break;
         }
      }
   }
})();

