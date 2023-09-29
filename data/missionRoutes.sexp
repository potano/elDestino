;SPDX-License-Identifier: GPL-2.0-or-later


(feature PotohiribaIMission
        (marker SiteOfSanPedro
                (html "◆ historical marker: Site of San Pedro")
                30.365367 -83.484617
        )

        (route Potohiriba1SantaElena
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
                   (point wpPotohiriba1CR14
                          30.362658 -83.488995
                   )
                   (paths wpPotohiriba1CR14_CR14CR360S cr360_SanPedroEbb)
               )
        )


        (marker MachabaLow
                30.356308 -83.547956
        )
        (marker MachabaHigh
                30.359697 -83.571973
        )
)


