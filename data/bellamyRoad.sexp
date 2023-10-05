;SPDX-License-Identifier: GPL-2.0-or-later
(route bellamyRoad
         (style bellamyRoadStyle)
         (popup "<b>Bellamy Road</b><br>Lake Sampala (San Pedro de Potohiriba) to the state capitol")
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

