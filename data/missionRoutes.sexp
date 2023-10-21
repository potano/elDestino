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
         ;The 1655 listing placed Ayaocuto 8 leagues from Guacara I; measured as 27.75 miles
         ;This gives a league of 3.46 miles.
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
         (route Ayaocuto_GuacaraII
                ;Ayaocuto is attested to be 34 leagues from St. Augustine
                ;Use this route to establish St. Augustine-to-Charles Spring distance
                ;34.18 miles = 11.4 leagues therefore GuacaraII is at 45.4 leagues
                (style missionRoute)
                (segments AyaocutoI_Bellamy)
                (routeSegments bellamyRoad wpAyaocutoI_Bellamy GuacaraII)
         )
         (route Ayaocuto_TarihicaI
                ;57.86 miles (19 3-mile leagues, 16.2 fat leagues)
                (style missionRoute)
                (segments AyaocutoI_Bellamy)
                (routeSegments bellamyRoad wpAyaocutoI_Bellamy wpSpurTarihicaBlueSprings)
                (segment Bellamy_TarihicaBlueSprings
                  (paths spurTarihicaBlueSprings)
                )
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
         (route GuacaraI_TarihicaI
                (style missionRoute)
                ;Test assertion of equistance between Guacara I and Tarihica
                (routeSegments bellamyRoad wpSanJuanDeGuacaraI wpSpurTarihicaBlueSprings)
                (segments Bellamy_TarihicaBlueSprings)
         )


         ;San Juan de Guacara II at Charles Spring
         ;Well-attested location was at Charles Spring on the Suwannee
         ;Unfortunately, no distance from St. Augustine was noted
         (route SanJuanDeGuacaraII_Potohiriba
                ;In 1675, Apalachee's Lieutenant gave Guacara-San Pedro distance as 9 leagues
                ; and Bp. Calderón said distance was 10 leagues
                (style missionRoute)
                (routeSegments bellamyRoad GuacaraII wpPotohiriba1_Bellamy)
                (segment PotohiribaI_Bellamy
                         (attestation guess)
                         (style roadOfInterest)
                         (path Potohiriba1CR14
                               30.36860 -83.49288
                               30.362658 -83.488995
                         )
                )
         )


         ;Santa Cruz de Tarihica I
         ;Is at known distance from Ayaocuto and Guacara
         ;No waypoints further along; not enough constraints to fix position


         ;San Pedro y San Pablo de Potohiriba
         (route Potohiriba1_Machaba
                ; In 1675: 1.5 to 2 leagues from Santa Elena de Machaba
                (lengthRange 1.25 2.5 leagues)
                (style missionRoute)
                (routeSegments bellamyRoad wpPotohiriba1_Bellamy MachabaI)
         )


         ;Santa Elena de Machaba
        (route Machaba_Tolapatafi
               (lengthRange 3.25 4.5 leagues)
               (style missionRoute)
               (routeSegments bellamyRoad MachabaI Tolapatafi)
        )


        ;San Mateo de Tolapatafi
        (route Tolapatafi_Asile
               (lengthRange 1.75 3 leagues)
               (style missionRoute)
               (routeSegments bellamyRoad Tolapatafi AsileMission)
        )

)

