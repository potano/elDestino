;SPDX-License-Identifier: GPL-2.0-or-later

(feature missionRoutes

         ;San Francisco de Potano
         (route Potano_TolocoII
                (style roadOfInterest)
                (attestation guess)
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
                (lengthRange 11.5 12.5 leagues)
                (routeSegments bellamyRoad wpTolocoII wpSantaCatalinaDeAjohica)
         )


         ;San Martín de Ayaocuto
         ;Known with high certainty to be at Fig Spring in Ichetucknee State Park
         ;Mission perished in Timuquan revolt of 1656 without having moved
         ;The 1655 listing placed Ayaocuto 8 leagues from Guacara I; measured as 28.23 miles
         ;This gives a league of 3.53 miles.
         (route Ayaocuto_GuacaraI
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
         ;Alternatively, use the 3-league mile and set Guacara I at Royal Spring (22.8 miles)
         (route Ayaocuto_GuacaraIAlternate
                (segments AyaocutoI_Bellamy)
                (routeSegments bellamyRoad wpAyaocutoI_Bellamy wpGuacaraIAlternate)
         )



         ;Alternate San Juan de Guacara I at Royal Spring instead of Baptizing Spring
         (route GuacaraIAlternate_Tarihica
                ;Apalachee's Lieutenant (1675) placed Tarihica 8 leagues from Guacara
                (lengthRange 7.5 8.5 leagues)
                ;Trial route to test assertion that Guacara I is at Royal Spring rather than
                ;Baptizing Spring
                (routeSegments bellamyRoad wpGuacaraIAlternate wpTarihicaBellamy)
                (segments Tarihica_Bellamy)
         )



         ;San Juan de Guacara I at Baptizing Spring
         (route GuacaraI_Tarihica
                ;Test assertion of equistance between Guacara I and Tarihica
                (routeSegments bellamyRoad wpSanJuanDeGuacaraI wpTarihicaBellamy)
                (segments Tarihica_Bellamy)
         )


         ;San Juan de Guacara II
         ;Well-attested location was at Charles Spring on the Suwannee
         ;Unfortunately, no distance from St. Augustine was noted
         (segment SanJuanDeGuacaraII_Bellamy
           ;Apalachee's lieutenant in 1675 placed it 9 leages from Potohiriba and 8 from Tarihica
           ;Bp. Calderón the same year gave the distances as 10 and 7 leagues
           ;Measured length: 28.04 miles.  Lieutenant league: 3.12 miles  Calderón league: 4 to 2.8
           (style roadOfInterest)
           (path
                 30.16658 -83.23013
                 30.166155 -83.230063
           )
           (point wpBellamyGuacaraII 30.166155 -83.230063)
         )
         (route GuacaraII_BaptizingSpring
                ;Milanich placed Guacara at Charles Spring, six miles from Baptizing Spring
                (lengthRange 5.5 6.5 miles)
                (routeSegments bellamyRoad wpSanJuanDeGuacaraI wpBellamyGuacaraII)
                (segments SanJuanDeGuacaraII_Bellamy)
         )
         (route SanJuanDeGuacaraII_Potohiriba
                ;In 1675, Apalachee's Lieutenant gave Guacara-San Pedro distance as 9 leagues
                ; and Bp. Calderón said distance was 10 leagues
                (segments SanJuanDeGuacaraII_Bellamy)
                (routeSegments bellamyRoad wpBellamyGuacaraII wpPotohiriba1_Bellamy)
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

