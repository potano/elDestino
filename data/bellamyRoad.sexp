;SPDX-License-Identifier: GPL-2.0-or-later
(route bellamyRoad
         (style bellamyRoadStyle)
         (popup "<b>Bellamy Road</b><br>Newnansville to the state capitol")

         (segment
           ;Data digitized in QGIS with trace from topographic map
           ;Trace around Newnansville conforms with old maps of the town
           ;Data transferred via .geojson file
           (attestation old_map marker high)
           (paths Bellamy_Newnansville)
         )

         (segment
           ;Data digitized in QGIS with trace from topographic map
           ;Data transferred via .geojson file
           (attestation old_map)
           (paths Bellamy_WofNewnansville_AlligatorRoad Alligator_EofBellamy
                  Bellamy_Alligator Bellamy_I75 Bellamy_Traxler_OLeno
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

