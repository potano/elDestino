;SPDX-License-Identifier: GPL-2.0-or-later


;Yardstick along El Camino Real: leagues from St. Augustine
;  25  San Francisco de Potano (1655)
;  30  Santa Fé de Toloco
;  34  San Martín de Ayaocuto (1655)
;   ?  San Juan de Guacara I
;   ?  San Juan de Guacara II (@ Charles Spring)
;  54  Santa Cruz de Tarihica
;  60  San Pedro y San Pablo de Potohiriba
;  64  Santa Elena de Machaba
;  75  San Miguel de Asile (1655)
;  75  San Lorenzo de Ivitachuco
;  77  Concepcíon de Ayubale
;  77  San Francisco de Oconi
;  84  San Joseph de Ocuia (1655)
;  86  San Juan de Aspalaga (1655)
;  87  San Pedro y San Pablo de Patale (1655)
;  87  San Martín de Tomole (1655)
;  88  San Luís de Talimali (1655)
;  90  San Cosmé y San Damián de Escambé (1655)

(feature SanMartinDeAyaocutoI
         ;Milanich places this mission at Ichetucknee
         ;The 1655 listing placed Ayaocuto 8 leagues from Guacara I; measured as 28.23 miles
         ;This gives a league of 3.53 miles.
         (route AyaocutoI_GuacaraI
                (circle
                  (popup "San Martín de Ayaocuto I (1610)")
                  (style indefiniteAreaStyle)
                  29.97609 -82.75746
                  (radius 200)
                )
                (segment AyaocutoI_Bellamy
                         (style roadOfInterest)
                         (path
                           29.97609 -82.75746
                           29.978972 -82.751931
                         )
                         (point wpAyaocutoI_Bellamy 29.978972 -82.751931)
                )
                (routeSegments bellamyRoad wpAyaocutoI_Bellamy wpSanJuanDeGuacaraI)
         )
)


(feature SanJuanDeGuacaraI
         ;Milanich places the first site at Baptizing Spring
         (circle wpSanJuanDeGuacaraI
                 (style indefiniteAreaStyle)
                 (popup "San Juan de Guacara I")
                 30.134163 -83.131733
                 (radius 150)
         )
)


(feature SanJuanDeGuacaraII
         ;Well-attested location was at Charles Spring on the Suwannee
         ;Unfortunately, no distance from St. Augustine was noted
         ;Milanich places the mission at Charles Spring, six miles from Baptising Spring
         ;Apalachee's lieutenant in 1675 placed it 9 leages from Potohiriba and 8 from Tarihica
         ;Bp. Calderón the same year gave the distances as 10 and 7 leagues
         ;Measured length: 28.04 miles.  Lieutenant league: 3.12 mi.  Calderón league: 4 to 2.8 mi.
         (circle 30.16658 -83.23013
                 (popup "San Juan De Guacara II")
                 (style indefiniteAreaStyle)
                 (radius 100)
         )
         (segment SanJuanDeGuacaraII_Bellamy
           (style roadOfInterest)
           (path
                 30.16658 -83.23013
                 30.166155 -83.230063
           )
           (point wpBellamyGuacaraII 30.166155 -83.230063)
         )
         (route SanJuanDeGuacaraII_Potohiriba
                (segments SanJuanDeGuacaraII_Bellamy)
                (routeSegments bellamyRoad wpBellamyGuacaraII wpPotohiriba1_Bellamy)
                (segments PotohiribaI_Bellamy)
         )
)


(feature PotohiribaIMission
        (marker SiteOfSanPedro
                (html "◆ historical marker: Site of San Pedro")
                30.365367 -83.484617
        )

        (route Potohiriba1_Machaba
               ; In 1675: 1.5 to 2 leagues from Santa Elena de Machaba
               (lengthRange 1.5 2 leagues)

               (segment PotohiribaI_Bellamy
                   (style roadOfInterest)
                   (circle PotohiribaI
                           (style indefiniteAreaStyle)
                           (popup "San Pedro y San Pablo de Potohiriba I (1630)")
                           30.36860 -83.49288
                           (radius 500)
                   )
                   (path Potohiriba1CR14
                         (attestation guess)
                         30.36860 -83.49288
                         30.362658 -83.488995
                   )
                   (point wpPotohiriba1_Bellamy 30.362658 -83.488995)
               )
               (routeSegments bellamyRoad wpPotohiriba1_Bellamy wpMachabaI_BellamyEast)
        )

        (marker MachabaHigh
                30.359697 -83.571973
        )

        (route Potohiriba_Asile         ;prelimiinary route definition to calibrate distances
               ;rough calculation: Potohiriba-Machaba 1.5-2 leagues, Machaba-Tolpatafi 3.5-4,
               ; Tolpatafi-Asile 2-2.5 leagues.  Range 7 to 8.5 leagues
               ;Given calculated length of 22.48 miles, this yields a league of 2.64 to 3.21
               ; miles.  More calibrations will be necessary.  For now we'll use a standard
               ; league of 3 miles
               (lengthRange 7 8.5 leagues)
               (segment
                   (style roadOfInterest)
                   (paths Potohiriba1CR14 wpPotohiriba1_Bellamy)
               )
               (segment
                   (style invisiblePath)
                   (paths wpPotohiriba1_Bellamy Bellamy_CR14
                          cr360_SanPedroEbb BellamyInterpolationEbb federalRoadEbbUS27
                          us27federalLamont
                   )
               )
               (segment
                   (style roadOfInterest)
                   (path
                         (attestation guess)
                         30.373066 -83.809215
                         30.37223  -83.81122
                   )
                   (circle Asile
                           (style indefiniteAreaStyle)
                           (popup "San Miguel de Asile")
                           30.37223  -83.81122
                           (radius 800)
                   )
               )
        )
)


(feature MachabaIMission
         (circle MachabaI
                 (style indefiniteAreaStyle)
                 (popup "Santa Elena de Machaba (1655)")
                 30.36349 -83.55167
                 (radius 550)
         )
         (segment MachabaI_BellamyEast
                  (paths MachabaI)
                  (path
                    (attestation guess)
                    30.36349 -83.55167
                    30.36267 -83.55021
                    30.36164 -83.54922
                    30.35979 -83.54875
                    30.35927 -83.54772
                    30.35819 -83.54635
                    30.35742 -83.54497
                    30.35679 -83.54437
                    30.356345 -83.544089
                  )
                  (point wpMachabaI_BellamyEast 30.356345 -83.544089)
         )
)

