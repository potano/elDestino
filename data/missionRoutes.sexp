;SPDX-License-Identifier: GPL-2.0-or-later


(feature PotohiribaIMission
        (marker SiteOfSanPedro
                (html "◆ historical marker: Site of San Pedro")
                30.365367 -83.484617
        )

        (route Potohiriba1_Machaba
               ; In 1675: 1.5 to 2 leagues from Santa Elena de Machaba

               (segment
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
               )
               (segment
                   (style invisiblePath)
                   (point wpPotohiriba1_Bellamy
                          30.362658 -83.488995
                   )
                   (paths Bellamy_CR14 cr360_SanPedroEbb)
               )
        )


        (marker MachabaLow
                30.356308 -83.547956
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

