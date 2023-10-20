;SPDX-License-Identifier: GPL-2.0-or-later

(feature missionRoutes

         ;San Francisco de Potano
         (route Potano_TolocoII
                (style missionRoute)
                (attestation guess)
                (lengthRange 2.5 3.5 leagues)  ;Bp. Calderón states 3 leagues
                (segment
                  (paths sanFranciscoDePotanoMission
                         Potano_TolocoII_West
                         wpTolocoII
                  )
                )
         )


         ;Santa Fé de Toloco I
         ;(connecting path not yet worked out)


         ;Santa Fé de Toloco II
         (route TolocoII_SantaCatalina
                ;Bp. Calderón placed Santa Catalina 12 leagues from Santa Fé
                ;This tests a distance to the hypothesized Santa Catalina from the hypothesized
                ; Toloco II
                (style missionRoute)
                (lengthRange 11.5 12.5 leagues)
                (routeSegments bellamyRoad wpTolocoII wpBellamy_SantaCatalinaSpur)
                (segment
                  (paths Bellamy_SantaCatalinaSpur)
                )
         )
         (route TolocoII_GuacaraII
                (style missionRoute)
                (routeSegments bellamyRoad wpTolocoII GuacaraII)
         )
         (route TolocoII_Ayaocuto
                (style missionRoute)
                (routeSegments bellamyRoad wpTolocoII wpAyaocutoI_Bellamy)
         )


         ;San Martín de Ayaocuto
         ;Known with high certainty to be at Fig Spring in Ichetucknee State Park
         ;Mission perished in Timuquan revolt of 1656 without having moved
         ;The 1655 listing placed Ayaocuto 8 leagues from Guacara I; measured as 28.23 miles
         ;This gives a league of 3.53 miles.
         (route Ayaocuto_GuacaraI
                (style missionRoute)
                (segment AyaocutoI_Bellamy
                         (path
                           29.967353 -82.759394
                           29.969594 -82.757719
                           29.969894 -82.757646
                           29.970283 -82.757616
                           29.970723 -82.757446
                           29.972936 -82.755125
                           29.973220 -82.755009
                           29.974120 -82.753967
                           29.974420 -82.753838
                           29.974547 -82.753769
                           29.975623 -82.753316
                           29.976451 -82.752837
                           29.976911 -82.752364
                           29.977837 -82.751210
                         )
                         (point wpAyaocutoI_Bellamy 29.977837 -82.751210)
                )
                (routeSegments bellamyRoad wpAyaocutoI_Bellamy wpSanJuanDeGuacaraI)
         )


         ;Santa Catalina de Ajohica II
         ;Route from Santa Catalina de Ajohica to Ajohica
         (route SantaCatalina_Ajohica
                (style missionRoute)
                (lengthRange 2.5 3.5 leagues)    ;Bp. Calderón states 3 leagues
                (segment
                  (paths pathSantaCatalina_Ajohica)
                )
         )


         ;Ajohica
         (route Ajohica_tarihica
                (style missionRoute)
                (lengthRange 1.5 2.5 leagues)    ;Bp. Calderón states 2 leagues
                (segment
                  (paths wpAjohica pathSantaCatalina_Ajohica wpSantaCatalina_Ajohica_TarihicaSpur
                         ajohica_tarihica)
                )
         )


         ;Santa Cruz de Tarihica
         (route SantaCruzDeTarihica_GuacaraII
                (style missionRoute)
                (lengthRange 6.5 7.5 leagues)    ;Bp. Calderón states 7 leagues
                (segment
                  (paths tarihica_jctCR349 jctTarihicaSplit_CR349)
                )
                (routeSegments bellamyRoad jctTarihicaSplit_CR349 GuacaraII)
         )


         ;San Juan de Guacara I at Baptizing Spring
         (route GuacaraI_GuacaraII
                ;Milanich indicates a six-mile move from Baptizing Spring to Charles Spring
                (style missionRoute)
                (lengthRange 5.5 6.5 miles)
                (routeSegments bellamyRoad wpSanJuanDeGuacaraI GuacaraII)
         )
         (route GuacaraI_Tarihica
                (style missionRoute)
                ;Test assertion of equistance between Guacara I and Tarihica
                (routeSegments bellamyRoad wpSanJuanDeGuacaraI wpTarihicaBellamy)
                (segments Tarihica_Bellamy)
         )


         ;San Juan de Guacara II at Charles Spring
         ;Well-attested location was at Charles Spring on the Suwannee
         ;Unfortunately, no distance from St. Augustine was noted
         (route SanJuanDeGuacaraII_Potohiriba
                ;In 1675, Apalachee's Lieutenant gave Guacara-San Pedro distance as 9 leagues
                ; and Bp. Calderón said distance was 10 leagues
                (style missionRoute)
                (routeSegments bellamyRoad GuacaraII wpPotohiriba1_Bellamy)
                (segments PotohiribaI_Bellamy)
         )


         ;Santa Cruz de Tarihica
         (segment Tarihica_Bellamy
                  (path
                    30.35555 -83.34542
                    30.355696 -83.340674
                  )
                  (point wpTarihicaBellamy 30.355696 -83.340674)
         )


         ;San Pedro y San Pablo de Potohiriba
        (route Potohiriba1_Machaba
               ; In 1675: 1.5 to 2 leagues from Santa Elena de Machaba
               (lengthRange 1.5 2 leagues)
                (style missionRoute)

               (segment PotohiribaI_Bellamy
                   (style roadOfInterest)
                   (path Potohiriba1CR14
                         (attestation guess)
                         30.36860 -83.49288
                         30.362658 -83.488995
                   )
                   (point wpPotohiriba1_Bellamy 30.362658 -83.488995)
               )
               (routeSegments bellamyRoad wpPotohiriba1_Bellamy wpMachabaI_BellamyEast)
        )

        (route Potohiriba_Asile         ;prelimiinary route definition to calibrate distances
               ;rough calculation: Potohiriba-Machaba 1.5-2 leagues, Machaba-Tolpatafi 3.5-4,
               ; Tolpatafi-Asile 2-2.5 leagues.  Range 7 to 8.5 leagues
               ;Given calculated length of 22.48 miles, this yields a league of 2.64 to 3.21
               ; miles.  More calibrations will be necessary.  For now we'll use a standard
               ; league of 3 miles
               (lengthRange 7 8.5 leagues)
               (style missionRoute)
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

