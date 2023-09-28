;SPDX-License-Identifier: GPL-2.0-or-later


(feature PotohiribaIMission
        (marker SiteOfSanPedro
                (html "◆ historical marker: Site of San Pedro")
                30.365367 -83.484617
        )

        (marker PotohiribaI
                (popup "San Pedro y San Pablo de Potohiriba I (1630)")
                30.36860 -83.49288
        )

        (route Potohiriba1SantaElena
               ; In 1675: 1.5 to 2 leagues from Santa Elena de Machaba
               (segment
                 (paths PotohiribaI Potohiriba1CR14 wpPotohiriba1CR14 wpPotohiriba1CR14_CR14CR360S)
               )
               (segments cr360_SanPedroEbb)
        )

        (path Potohiriba1CR14
              (attestation guess)
              30.36860 -83.49288
              30.362658 -83.488995
        )

        (point wpPotohiriba1CR14
               30.362658 -83.488995
        )

        (marker MachabaLow
                30.356308 -83.547956
        )
        (marker MachabaHigh
                30.359697 -83.571973
        )
)

