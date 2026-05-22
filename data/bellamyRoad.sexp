;SPDX-License-Identifier: GPL-2.0-or-later
(route bellamyRoad
         (style bellamyRoadStyle)
         (popup "<b>Bellamy Road</b><br>St. John's River to the state capitol")

         (segment Bellamy_Clay_County
           ;Data digitized in QGIS from topographic map plus Open Street Map
           ;Data transferred via .geojson file
           (paths Bellamy_Bayard_WMA
                  Bellamy_CR2095_FEC
                  Bellamy_FEC_CR226
                  Bellamy_CR226_to_LittleRuthRoad
                  Bellamy_LittleRuthRoad
                  Bellamy_between_LittleRuthRoad_US17
                  Bellamy_west_from_US17
                  Bellamy_dirt_to_ScrewWormRoad
                  Bellamy_ScrewWormRoad
                  Bellamy_ScrewWorm_to_Moody
                  Bellamy_Moody_to_Mine
                  Bellamy_through_Strip_Mine
                  Bellamy_topo_East_of_Mine
                  Bellamy_north_of_SunGardenRoad)
         )

         (segment Bellamy_Clay_Putnam_county_line
           ;Data digitized in QGIS from topographic map plus Open Street Map
           ;Data transferred via .geojson file
           (paths Bellamy_Belmore
                  Bellamy_parallel_CR315C
                  Bellamy_county_line_near_SR100
                  Bellamy_Clay_County_Takeover
                  Bellamy_Swan_Lake
                  Bellamy_CR2_county_line)
         )

         (segment Bellamy_Putnam_County
           ;Data digitized in QGIS from topographic map plus Open Street Map
           ;Data transferred via .geojson file
           (paths Bellamy_CR2_Putnam
                  Bellamy_cut_CR2_SR26_corner
                  Bellamy_in_Melrose_Putnam)
         )

         (segment
           ;Data digitized in QGIS with trace from Alachua County Property Appraiser GIS
           ;Trace around Newnansville conforms with old maps of the town
           ;Data transferred via .geojson file
           (attestation old_map marker high)
           (paths Bellamy_in_Melrose_Alachua)
         )

         (segment
           ;Data digitized from topographic map with course guided by old maps
           ;Crucial binding point in center of route: Bellamy Station of the Gainesville & Gulf RR
           (attestation old_map medium)
           (paths Bellamy_Melrose_Newnansville)
         )

         (segment
           ;Data digitized in QGIS with trace from topographic map
           ;Data transferred via .geojson file
           (attestation old_map)
           (paths Bellamy_Alligator Bellamy_I75 Bellamy_Traxler_OLeno
                  Bellamy_Alachua_OLeno_Gap Bellamy_OLeno_inAlachua
                  Bellamy_inColumbia)
         )

         (segment
           ;Data digitized in QGIS with trace from topographic map
           (attestation old_map medium)
           (paths Bellamy_to_CR238atSR47 Bellamy_ElamChurchRoad CR238_in_Ichetucknee
                  BellamyRoad_SpanishRoad BellamyRoad_SpanishRoad_to_CR349 Bellamy_CR349
                  Bellamy_E_of_RoyalSpring Bellamy_198trl_198terr Bellamy_western_Suwannee_springs
           )
         )

         (segment
           ;Data digitized with tablet using OSMAnd
           ;Data transferred via .gpx file
           (attestation old_map marker medium)
           (paths Bellamy_CharlesSpring_CR53 Bellamy_CR53Madison 
                  Bellamy_OldStAugustineMadisonInterpolation Bellamy_OldStAugustineMadison
                  Bellamy_Hopewell_CR14 Bellamy_CR14
                  cr360_SanPedroEbb BellamyInterpolationEbb federalRoadEbbUS27 us27federalLamont
                  bellamyLamont interpolationUS27BarberHill us27BarberHillAvalon
                  interpolationEasternAvalonSideUS27 easternAvalonSideMain
                  interpolationEastAvalonSideWestAvalonSide westernAvalonSide
                  interpolationWesternAvalonSideUS27 us27CappsInterpolationWaukeenah)
         )

         (segment
           ;Data digitized with tablet using OSMAnd
           ;Data transferred via .gpx file
           (attestation old_map high)
           (popup "<b>Bellamy Road</b><br>San Pedro de Potohiriba to Lamont")
           (paths StAugustineRoadWaukennahElDestino)
         )

         (segment
           ;Data digitized in QGIS with trace from Genealogy Trails map
           ;Data transferred via .geojson file
           (attestation old_map high)
           (paths StAugustineRoadElDestinoTopo StAugustineRoadElDestinoGenealogyTrails)
         )

         (segment
           ;Data digitized in QGIS with trace from topgraphic map
           ;Data transferred via .geojson file
           (attestation old_map medium)
           (paths likelyBellamyRoadElDestinoChairesCrossing)
         )

         (segment
           ;Straight line connecting the two known endpoints
           ;(ignored Data from .gpx file)
           (attestation old_map medium)
           (paths interpolationStAugustineRoadChairesCrossing)
         )

         (segment
           ;Data digitized with tablet using OSMAnd
           ;Data transferred via .gpx file
           (attestation old_map high)
           (paths StAugustineRoadChairesCrossingTallahassee)
         )

         (segment
           ;Data digitized with tablet using OSMAnd
           ;Data transferred via .gpx file
           (attestation old_map low)
           (paths LafayetteCapitol)
         )
)

