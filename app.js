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

   return;


   var layerdata = {
      type: "FeatureCollection",
      name: "elDestinoPlantationBoundary",
      crs: {
         type: "name",
         properties: {
              "name": "urn:ogc:def:crs:OGC:1.3:CRS84"
         }
      },
      features: [
         {
            type: "Feature",
            properties: {
               id: 1,
               name: "El Destino Boundary",
               style: elDestinoStyle,
               popupContent: "<b>El Destino Plantation</b><br/>" +
                  "Both existing old maps agree on these boundaries as set in relation to modern " +
                  "section lines.  These lines often do not coincide with current property lines.",
            },
            geometry: {
               type: "MultiPolygon",
               coordinates: [
                  [
                     [
                        [ -84.0412134, 30.3833206 ], [ -84.0455995, 30.3833206 ],
                        [ -84.0455995, 30.3796931 ], [ -84.0498856, 30.3796931 ],
                        [ -84.0498856, 30.3833206 ], [ -84.0584963, 30.3833206 ],
                        [ -84.0586137, 30.3761966 ], [ -84.0754678, 30.3762343 ],
                        [ -84.0753678, 30.3871234 ], [ -84.0837604, 30.3871234 ],
                        [ -84.0837604, 30.3837108 ], [ -84.0879989, 30.3837108 ],
                        [ -84.0879989, 30.3940455 ], [ -84.0962518, 30.3940455 ],
                        [ -84.0962518, 30.4167330 ], [ -84.0876768, 30.4167330 ],
                        [ -84.0876768, 30.4308070 ], [ -84.0836255, 30.4308070 ],
                        [ -84.0836255, 30.4272773 ], [ -84.0802494, 30.4301520 ],
                        [ -84.0749320, 30.4334633 ], [ -84.0748806, 30.4452291 ],
                        [ -84.0624781, 30.4452291 ], [ -84.0624781, 30.4487331 ],
                        [ -84.0582031, 30.4487331 ], [ -84.0582031, 30.4455448 ],
                        [ -84.0537367, 30.4473520 ], [ -84.0537367, 30.4343073 ],
                        [ -84.0495432, 30.4343073 ], [ -84.0495432, 30.4306793 ],
                        [ -84.0454063, 30.4306793 ], [ -84.0454063, 30.4050960 ],
                        [ -84.0283557, 30.4050960 ], [ -84.0283557, 30.3978547 ],
                        [ -84.0343911, 30.3978547 ], [ -84.0343911, 30.3905757 ],
                        [ -84.0359537, 30.3905757 ], [ -84.0412134, 30.3905757 ],
                        [ -84.0412134, 30.3833206 ]
                     ]
                  ]
               ]
            }
         },

         {
            type: "FeatureCollection",
            name: "St. Augustine Road not on OSM passing through El Destino Plantation",
            crs: {
               type: "name",
               properties: {
                  name: "urn:ogc:def:crs:OGC:1.3:CRS84"
               }
            },
            features: [
               {
                  type: "Feature",
                  properties: {
                     id: 1,
                     source: "elDestino 40ac grid",
                     style: roadFromOldMapStyle,
                  },
                  geometry: {
                     type: "MultiLineString",
                     coordinates: [
                        [
                           [-84.0637924, 30.4007320],
                           [-84.0643471, 30.4010054],
                           [-84.0650207, 30.4012446],
                           [-84.0657735, 30.4013471],
                           [-84.0672791, 30.4013129],
                           [-84.0683489, 30.4012788],
                           [-84.0697357, 30.4012788],
                           [-84.0705678, 30.4015522],
                           [-84.0721923, 30.4026457],
                           [-84.0727470, 30.4036026],
                           [-84.0729847, 30.4045252],
                           [-84.0731432, 30.4052087],
                           [-84.0735394, 30.4059605],
                           [-84.0744507, 30.4069857],
                           [-84.0759564, 30.4080792],
                           [-84.0765428, 30.4087269],
                           [-84.0770052, 30.4093712],
                           [-84.0775032, 30.4100767],
                           [-84.0780012, 30.4106289],
                           [-84.0786059, 30.4110584],
                           [-84.0798153, 30.4114572],
                           [-84.0813449, 30.4121455],
                           [-84.0824940, 30.4131023],
                           [-84.0833724, 30.4138193],
                           [-84.0842616, 30.4144941],
                           [-84.0849730, 30.4151997],
                           [-84.0878543, 30.4178991]
                        ]
                     ]
                  }
               },
               {
                  type: "Feature",
                  properties: {
                     id: 2,
                     source: "USGS topo",
                     style: roadFromTopoStyle,
                  },
                  geometry: {
                     type: "MultiLineString",
                     coordinates: [
                        [
                           [-84.0637924, 30.4007320],
                           [-84.0630396, 30.4003902],
                           [-84.0620586, 30.3999789],
                           [-84.0611574, 30.3995363],
                           [-84.0601076, 30.3990574],
                           [-84.0592675, 30.3986403],
                           [-84.0586042, 30.3983273],
                           [-84.0582162, 30.3981222],
                           [-84.0575278, 30.3977767],
                           [-84.0569396, 30.3974960],
                           [-84.0565766, 30.3973557],
                           [-84.0561057, 30.3971094],
                           [-84.0551944, 30.3965968],
                           [-84.0545605, 30.3962209],
                           [-84.0540850, 30.3959475],
                           [-84.0538217, 30.3958565],
                           [-84.0536537, 30.3958367],
                           [-84.0534960, 30.3958284],
                           [-84.0533288, 30.3958284],
                           [-84.0532178, 30.3958302],
                           [-84.0529944, 30.3958531],
                           [-84.0528337, 30.3958933],
                           [-84.0527173, 30.3959067],
                           [-84.0526138, 30.3959125],
                           [-84.0522826, 30.3959273],
                           [-84.0516390, 30.3959774],
                           [-84.0513622, 30.3960059],
                           [-84.0511209, 30.3960773],
                           [-84.0509929, 30.3961194],
                           [-84.0508588, 30.3961772],
                           [-84.0506820, 30.3963034],
                           [-84.0504564, 30.3965353],
                           [-84.0501811, 30.3967620],
                           [-84.0497305, 30.3970858],
                           [-84.0494802, 30.3972693],
                           [-84.0492299, 30.3974529],
                           [-84.0488544, 30.3977227],
                           [-84.0485415, 30.3979818],
                           [-84.0482286, 30.3982085],
                           [-84.0479032, 30.3982949],
                           [-84.0475402, 30.3982517],
                           [-84.0470897, 30.3982409],
                           [-84.0465139, 30.3981546],
                           [-84.0459382, 30.3979926],
                           [-84.0452373, 30.3978199],
                           [-84.0448744, 30.3977335],
                           [-84.0445865, 30.3976364],
                           [-84.0442861, 30.3975608],
                           [-84.0441003, 30.3974854],
                           [-84.0435352, 30.3973341],
                           [-84.0433871, 30.3973487]
                        ]
                     ]
                  }
               }
            ]
         },

         {
            type: "Feature",
            properties: {
               name: "Site of Burnt Mill",
               title: "Site of Mill Burned by Indians",
               markerHtml: '∴ Site of Mill Burned by Indians',
            },
            geometry: {
               type: "Point",
               coordinates: [-84.072455, 30.4044472],
            },
         },

         {
            type: "Feature",
            properties: {
               name: "Negro Cemetery",
               title: "Cemetery for slaves of El Destino Plantation",
               markerHtml: '⛼ Mt. Zion Cemetery (slave cemetery)',
               popupContent: "<b>Negro Cemetery</b><br/>" +
                  "Cemetery for slaves of El Destino Plantation. Now known as Mt. Zion " +
                  'Cemetery.  See <a href="https://ecbpublishing.com/a-hidden-historical-treasure-old-mt-zion-cemetery-offers-the-black-community-a-connection-to-their-past/">article in ' +
                  "<i>Monticello News.</i>",
            },
            geometry: {
               type: "Point",
               coordinates: [-84.053894, 30.423504],
            },
         },

         {
            type: "Feature",
            properties: {
               name: "Wacissa Reset",
               title: "Wacissa Reset",
               markerHtml: '▵ Aspalaga Reset',
               popupContent: "<b>Wacissa Reset</b><br/>" +
                  "USGS benchmark on top of hill near SR 59<br/>30.39825°N 84.01702°W",
            },
            geometry: {
               type: "Point",
               coordinates: [-84.01702, 30.39825],
            },
         },

         {
            type: "FeatureCollection",
            name: "Features associated with Aspalaga",
            crs: {
               type: "name",
               properties: {
                  name: "urn:ogc:def:crs:OGC:1.3:CRS84"
               }
            },
            features: [
               {
                  type: "Feature",
                  properties: {
                     id: 1,
                     name: "Mission Trail",
                     notes: "Nearby road that may indicate a nearby mission",
                     style: roadOfInterest,
                  },
                  geometry: {
                     type: "MultiLineString",
                     coordinates: [
                        [
                           [-84.0135840, 30.3931659],
                           [-84.0171842, 30.3930746]
                        ]
                     ]
                  }
               },
               {
                  type: "Feature",
                  properties: {
                     name: "Mission Trail label",
                     title: "Mission Trail",
                     markerHtml: ' Mission Trail',
                     popupContent: "<b>Mission Trail</b><br/>" +
                     "Road near El Destino whose name may offer a clue.",
                  },
                  geometry: {
                     type: "Point",
                     coordinates: [-84.0125840, 30.3935659],
                  },
               },
               {
                  type: "Feature",
                  properties: {
                     id: 2,
                     name: "Aspalaga Road (Jefferson County)",
                     notes: "Forest road which may lead to old mission site",
                     style: roadOfInterest,
                  },
                  geometry: {
                     type: "MultiLineString",
                     coordinates: [
                        [
                           [-84.0116780, 30.3901975],
                           [-84.0124765, 30.3889924],
                           [-84.0126904, 30.3884714],
                           [-84.0128428, 30.3882337],
                           [-84.0130679, 30.3878310],
                           [-84.0132819, 30.3875053],
                           [-84.0134580, 30.3871905],
                           [-84.0135587, 30.3870060],
                           [-84.0136634, 30.3865896],
                           [-84.0138223, 30.3860872],
                           [-84.0140340, 30.3853336],
                           [-84.0142508, 30.3850087],
                           [-84.0144899, 30.3847916],
                           [-84.0147488, 30.3846714],
                           [-84.0155164, 30.3845116],
                           [-84.0164165, 30.3843517]
                        ]
                     ]
                  }
               },
               {
                  type: "Feature",
                  properties: {
                     name: "Aspalaga Road (Jefferson County) label",
                     title: "Aspalaga Road",
                     markerHtml: ' Aspalaga Road',
                     popupContent: "<b>Mission Trail</b><br/>" +
                     "Road near El Destino whose name may offer a clue.",
                  },
                  geometry: {
                     type: "Point",
                     coordinates: [-84.0106780, 30.3908575],
                  },
               },
               {
                  type: "Feature",
                  properties: {
                     id: 3,
                     name: "Aspalaga Road",
                     notes: "Road in Liberty and Gadsden Counties near the Apalacacola",
                     style: roadOfInterest,
                  },
                  geometry: {
                     type: "MultiLineString",
                     coordinates: [
                        [
                           [-84.8949058, 30.5819952],
                           [-84.8949436, 30.5825151],
                           [-84.8950191, 30.5830350],
                           [-84.8951197, 30.5835657],
                           [-84.8952329, 30.5839231],
                           [-84.8952959, 30.5842697],
                           [-84.8953839, 30.5848762],
                           [-84.8954468, 30.5853852],
                           [-84.8954594, 30.5856614],
                           [-84.8955978, 30.5862138],
                           [-84.8956230, 30.5865387],
                           [-84.8956733, 30.5868203],
                           [-84.8957614, 30.5870261],
                           [-84.8960004, 30.5874160],
                           [-84.8964659, 30.5880875],
                           [-84.8969188, 30.5886615],
                           [-84.8972585, 30.5891542],
                           [-84.8975982, 30.5895766],
                           [-84.8978750, 30.5899557],
                           [-84.8980637, 30.5902264],
                           [-84.8981895, 30.5904105],
                           [-84.8982776, 30.5906055],
                           [-84.8982776, 30.5909087],
                           [-84.8982021, 30.5912336],
                           [-84.8981518, 30.5915369],
                           [-84.8980511, 30.5918509],
                           [-84.8979253, 30.5921325],
                           [-84.8978750, 30.5923708],
                           [-84.8978498, 30.5926740],
                           [-84.8978372, 30.5928446],
                           [-84.8979001, 30.5932886],
                           [-84.8979630, 30.5938518],
                           [-84.8980511, 30.5943608],
                           [-84.8981392, 30.5949564],
                           [-84.8982398, 30.5956928],
                           [-84.8982650, 30.5962045],
                           [-84.8983279, 30.5968001],
                           [-84.8983908, 30.5974390],
                           [-84.8984914, 30.5981538],
                           [-84.8985921, 30.5988902],
                           [-84.8986802, 30.5995399],
                           [-84.8987179, 30.5999135],
                           [-84.8988060, 30.6004658],
                           [-84.8988815, 30.6010831],
                           [-84.8989569, 30.6016353],
                           [-84.8990450, 30.6021984],
                           [-84.8990702, 30.6027507],
                           [-84.8990953, 30.6030052],
                           [-84.8991331, 30.6035791],
                           [-84.8991331, 30.6044346],
                           [-84.8990828, 30.6051817],
                           [-84.8990828, 30.6056690],
                           [-84.8990953, 30.6064703],
                           [-84.8990828, 30.6069197],
                           [-84.8990828, 30.6073853],
                           [-84.8990828, 30.6077101],
                           [-84.8991205, 30.6080458],
                           [-84.8991708, 30.6083382],
                           [-84.8992463, 30.6086089],
                           [-84.8993344, 30.6089445],
                           [-84.8994224, 30.6091828],
                           [-84.8996174, 30.6094480],
                           [-84.8998187, 30.6096321],
                           [-84.8999949, 30.6097621],
                           [-84.9002717, 30.6099570],
                           [-84.9003723, 30.6101086],
                           [-84.9005359, 30.6105200],
                           [-84.9005736, 30.6109098],
                           [-84.9005610, 30.6111805],
                           [-84.9004478, 30.6114729],
                           [-84.9003975, 30.6117436],
                           [-84.9002842, 30.6120792],
                           [-84.9001584, 30.6124040],
                           [-84.9000326, 30.6128047],
                           [-84.8999949, 30.6131512],
                           [-84.8998691, 30.6135518],
                           [-84.8997684, 30.6139578],
                           [-84.8997810, 30.6143043],
                           [-84.8998187, 30.6146183],
                           [-84.8999571, 30.6149756],
                           [-84.9000955, 30.6153545],
                           [-84.9001836, 30.6156685],
                           [-84.9002591, 30.6160691],
                           [-84.9002968, 30.6164589],
                           [-84.9003094, 30.6168704],
                           [-84.9002968, 30.6171898],
                           [-84.9002213, 30.6175795],
                           [-84.9001584, 30.6178935],
                           [-84.9000829, 30.6181750],
                           [-84.9000704, 30.6185107],
                           [-84.9000452, 30.6188138],
                           [-84.9000578, 30.6193227],
                           [-84.9000578, 30.6195879],
                           [-84.9000578, 30.6201293],
                           [-84.9000704, 30.6204757],
                           [-84.9001584, 30.6208547],
                           [-84.9001459, 30.6210820],
                           [-84.9002088, 30.6213852],
                           [-84.9001333, 30.6215909],
                           [-84.9000075, 30.6218616],
                           [-84.8998062, 30.6221430],
                           [-84.8995797, 30.6226844],
                           [-84.8994036, 30.6231066],
                           [-84.8993407, 30.6233719],
                           [-84.8992652, 30.6236425],
                           [-84.8992400, 30.6238590],
                           [-84.8992400, 30.6240323],
                           [-84.8992526, 30.6241514],
                           [-84.8993029, 30.6243138],
                           [-84.8993910, 30.6245195],
                           [-84.8995294, 30.6247793],
                           [-84.8997055, 30.6250608],
                           [-84.8998187, 30.6252340],
                           [-84.8998942, 30.6253422],
                           [-84.9000452, 30.6257212],
                           [-84.9002213, 30.6260351],
                           [-84.9003975, 30.6264573],
                           [-84.9005107, 30.6266630],
                           [-84.9005233, 30.6268796],
                           [-84.9004730, 30.6270203],
                           [-84.9003723, 30.6271935],
                           [-84.9001333, 30.6274588],
                           [-84.8997810, 30.6277727],
                           [-84.8995545, 30.6279784],
                           [-84.8994036, 30.6282707],
                           [-84.8993029, 30.6286280],
                           [-84.8992903, 30.6289527],
                           [-84.8993407, 30.6294615],
                           [-84.8993658, 30.6296266],
                           [-84.8993658, 30.6300272],
                           [-84.8993784, 30.6304061],
                           [-84.8993658, 30.6309365]
                        ]
                     ]
                  }
               },
               {
                  type: "Feature",
                  properties: {
                     name: "Aspalaga Road (Jefferson County) label",
                     title: "Aspalaga Road",
                     markerHtml: '  Aspalaga Road',
                     popupContent: "<b>Mission Trail</b><br/>" +
                     "Road near El Destino whose name may offer a clue.",
                  },
                  geometry: {
                     type: "Point",
                     coordinates: [-84.8990828, 30.6051817],
                  },
               },
               {
                  type: "Feature",
                  properties: {
                     name: "Aspalaga Landing",
                     title: "Aspalaga Landing",
                     markerHtml: '• Aspalaga Landing',
                  },
                  geometry: {
                     type: "Point",
                     coordinates: [-84.907805, 30.618170],
                  },
               },
               {
                  type: "Feature",
                  properties: {
                     id: 4,
                     name: "Aspalaga Street",
                     notes: "Residential street near Decatur, GA",
                     style: roadOfInterest,
                  },
                  geometry: {
                     type: "MultiLineString",
                     coordinates: [
                        [
                           [-84.8515406, 30.7415817],
                           [-84.8491894, 30.7415616]
                        ]
                     ]
                  }
               }
            ]
         },

         {
            type: "FeatureCollection",
            name: "Published location of Pine Tuft Site",
            features: [
               {
                  type: "Feature",
                  properties: {
                     name: "Coarse location of Pine Tuft Site as declared in NRHP database",
                     popupContent: '<b>Coarse location of Pine Tuft Site</b><br/>' +
                        'The NRHP gives the 1676 location of the San Juan de Aspalaga mission ' +
                        '(Aspalaga II) as 30.36°N 83.99°W, which could be anywhere in this box.',
                     style: indefiniteAreaStyle,
                  },
                  geometry: {
                     type: "Polygon",
                     coordinates: [
                        [
                           [-84.00, 30.37], [-83.985, 30.37],
                           [-83.985, 30.355], [-84.00, 30.355]
                        ]
                     ]
                  }
               },

               {
                  type: "Feature",
                  properties: {
                     name: "Pine Tuft Site marker",
                     title: "Pine Tuft Site",
                     markerHtml: '▵ 30.36°N 83.99°W',
                  },
                  geometry: {
                     type: "Point",
                     coordinates: [-83.99, 30.36],
                  },
               },
            ],
         },

         {
            type: "FeatureCollection",
            name: "Alternate location of Pine Tuft Site",
            features: [
               {
                  type: "Feature",
                  properties: {
                     name: "Coarse location of other Pine Tuft Site candidate",
                     popupContent: '<b>Alternate location of Pine Tuft Site</b><br/>' +
                        'The nearby Wacissa Reset benchmark and the name "Aspalaga Road" ' +
                        'raise the possibility that the Pine Tuft Site is actually here. ' +
                        'This location is closer to El Camino Real and is at a higher ' +
                        'altitude than the area near 30.36°N 83.99°W.',
                     style: indefiniteAreaStyle,
                  },
                  geometry: {
                     type: "Polygon",
                     coordinates: [
                        [
                           [-84.0244, 30.386], [-84.0145, 30.386],
                           [-84.0145, 30.376], [-84.0244, 30.376]
                        ]
                     ]
                  }
               },

               {
                  type: "Feature",
                  properties: {
                     name: "Alternate Pine Tuft Site marker",
                     title: "Pine Tuft Site",
                     markerHtml: '▵ Alternate Pine Tuft Site',
                  },
                  geometry: {
                     type: "Point",
                     coordinates: [-84.019396, 30.381140],
                  },
               },
            ],
         },
      ]
   };
   L.geoJson(layerdata, {
      onEachFeature: onEachFeature,
      style: styler,
      pointToLayer: pointer,
      attribution: 'Main app © 2023, Michael Thompson',
   }).addTo(map);

   L.control.scale().addTo(map);



   function onEachFeature(feature, layer) {
      if (feature.properties && feature.properties.popupContent) {
         layer.bindPopup(feature.properties.popupContent);
      }
   }

   function styler(feature) {
      return feature.properties.style || {}
   }

   function pointer(feature, latlong) {
      var icon;
      if (feature.properties.markerHtml) {
         icon = L.divIcon({
            className: 'marker-text-icon',
            html: feature.properties.markerHtml,
         });
      }
      else {
         icon = new L.Icon.Default;
      }
      return L.marker(latlong, {
         icon: icon,
      })
   }
})();

