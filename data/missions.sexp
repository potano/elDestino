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

;Op Cit
;Calderón, Gabriel Díaz. letter Mariana, Queen of Spain describing the Indians and Indian missions
;   of Florida. (1675)  Tr. Lucy L. Wenhold in Smithsonian miscellaneous collections vol 95, no 16,
;   pub 3398 (Washington, 1936)
;de la Calle, Díaz. *Nota de las Misiones de la provincia de la Florida, etc.* (1655) in Serreno y
;   Saenz, *Documentos Historicos de la Florida y la Luisiana, Siglox XVI al XVIII (Madrid 1912)
;Hann, John. "Summary Guide to Spanish Florida missions and visitas: with churches in the sixteenth
;   and seventeenth centuries", *The Americas*, vol 56, no 4 (Cambridge, 1999)
;Johnson, Kennith W. "Mission Santa Fé de Toloca" in Bonnie G. McEwan, *The Spanish Missions of la
;   Florida*  University Press of Florida (Gainesville, 1993)
;Milanich, Jerald. *Laboring in the Fields of the Lord: Spanish missions and southeastern Indians*
;   University Press of Florida (Gainesville, 2006)


(feature missions

         (feature SanFranciscoDePotano
                  ;First mission west of the St. John's (1607)
                  ;Archeologists confirmed the Fox Pond site as the mission site
                  ;Population of Potano moved here from Orange Lake after de Soto came through
                  ;Site is relatively remote; it is off the Camino Real
                  (circle sanFranciscoDePotanoMission
                          (popup "<b>San Francisco de Potano (1607)</b><br/>"
                                 "First mission west of the St. John's<br/>"
                                 "Last mission in the interior of Florida to fall"
                          )
                          (style indefiniteAreaStyle)
                          29.716790 -82.420331
                          (radius 120)
                  )
         )

         (feature SantaFeDeTolocoI
                  ;Next to the Robinson Sinks less than a mile from the Santa Fe River
                  ;The river (and hence many other places in the area) were named for the mission
                  ;Site was some distance from El Camino Real
                  ;Mission and village were moved after the 1656 rebellion
                  ;The Utina of Arapaja moved to the site in 1657
                  (circle
                    (popup "<b>Santa Fé de Toloco I (1616)</b><br/>"
                           "Mission and people moved after the rebellion<br/>"
                           "of 1656.")
                    (style indefiniteAreaStyle)
                    29.93128 -82.51977
                    (radius 250)
                  )
         )

         (feature SantaFeDeTolocoII
                  ;PRESUMPTIVE!  In area of lakes and sinks a short way north of Alachua
                  ;The river (and hence many other places in the area) were named for the mission
                  ;Site was some distance from El Camino Real
                  ;Mission and village were moved after the 1656 rebellion
                  ;The Utina of Arapaja moved to the site in 1657
                  (circle wpTolocoII
                          (popup "<b>Santa Fé de Toloco II (1657)</b><br/>"
                                 "Possible new site")
                          (style indefiniteAreaStyle)
                          29.809683 -82.486574
                          (radius 250)
                  )
         )

         (feature SanMartinDeAyaocuto
                  ;Milanich places this mission at Ichetucknee; Hann specifically at Fig Spring
                  ;Fr. López placed the mission 10 leages from the land of the Potano
                  ;de la Calle placed the mission 34 leagues from St. Augustine
                  ;Mission ended in 1656; Bp. Calderón does not mention it
                  (circle
                    (popup "<b>San Martín de Ayaocuto (1610-1656)</b><br/>"
                           "Likely the home of the holata of the Northern Utina")
                    (style indefiniteAreaStyle)
                    29.97609 -82.75746
                    (radius 200)
                  )
         )

         (feature SantaCatalinaDeAjohica
                  ;No one seems ready to pin a location for this mission Bp. Calderón named in 1675
                  ;Several authors indicate it was by the Suwannee but fail to locate it
                  ;Bp. Calderón wrote that the mission was 12 leagues from Santa Fé
                  ;This location amid two springs is  miles from my hypothesized Toloco II
                  (circle wpSantaCatalinaDeAjohica
                          (style indefiniteAreaStyle)
                          30.103971 -83.113840
                          (radius 100)
                  )
         )

         (feature SanJuanDeGuacaraIAlternate
                  ;Candidate for location of Guacara I based on distance from Ayaocuto
                  ;Is at Royal Spring on the Santa Fe along El Camino Real
                  ;Apalachee's Lieutenant (1675) placed mission on the bank of a large river
                  ;This alternate location is on the Santa Fe rather than the Suwannee
                  (circle wpGuacaraIAlternate
                          (style indefiniteAreaStyle)
                          30.087111 -83.073491
                          (radius 30)
                  )
         )

         (feature SanJuanDeGuacaraI
                  ;Milanich places the first site at Baptizing Spring
                  ;Archeological evidence supports a Baptizing Spring site, but not the records
                  (circle wpSanJuanDeGuacaraI
                          (style indefiniteAreaStyle)
                          (popup "San Juan de Guacara I")
                          30.134163 -83.131733
                          (radius 150)
                  )
         )

         (feature SanJuanDeGuacaraII
                  ;Well-attested location at Charles Spring on the Suwannee
                  ;In no epoch was a distance to St. Augustine recorded
                  ;In 1614 Fr. de Oré placed Guarcara as 8 leagues from both San Martín de
                  ; Ayaocuto and and Santa Cruz de Tarihica.  This may militate for the
                  ; alternate Guacara I
                  ;In 1675 Apalachee's Lieutenant place Guacara 9 leagues from San Pedro and
                  ; 8 from Tarihica
                  ;Bp. Calderón the same year gave the distances as 10 and 7 leagues
                  (circle 30.16658 -83.23013
                          (popup "San Juan De Guacara II (1675-1689)")
                          (style indefiniteAreaStyle)
                          (radius 100)
                  )
         )

         (feature SantaCruzDeTarihica
                  ;The 1655 list gave the distance of 54 leagues from St. Augustine
                  ;In 1675 the bishop and the lieutenant gave the same distance of 5 leagues
                  ; from Santa Catalina
                  ;No better clues given; distances place it tentatively at Patterson Sink
                  (circle TarihicaAtPattersonSink
                          (popup "<b>Santa Cruz de Tarihica (1612-ca. 1690)</b>")
                          (style indefiniteAreaStyle)
                          30.35555 -83.34542
                          (radius 50)
                  )
         )

         (feature PotohiribaIMission
                  ;Mission and village seem to have been in three locations in the vicinity
                  ;This location seems good for now as a proxy for all three
                  ;The historical marker acknoledges only one location
                  (marker SiteOfSanPedro
                          (html "◆ historical marker: Site of San Pedro")
                          30.365367 -83.484617
                  )
                  (circle PotohiribaI
                          (style indefiniteAreaStyle)
                          (popup "San Pedro y San Pablo de Potohiriba I (1630)")
                          30.36860 -83.49288
                          (radius 500)
                  )
         )

         (feature MachabaIMission
                  (circle MachabaI
                          (style indefiniteAreaStyle)
                          (popup "Placeholder for Santa Elena de Machaba (1655)")
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

)
