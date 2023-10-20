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
                                 "First mission west of the St. Johns River<br/>"
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
                    (popup "<b>Santa Fé de Toloco I (1616 - 1656)</b><br/>"
                           "Mission and people moved south to the safety of El<br/>"
                           "Camino after the rebellion of 1656")
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
                          (popup "<b>Santa Fé de Toloco II (1657 - 1702)</b><br/>"
                                 "Proposed site of the relocated Santa Fé mission<br/>"
                                 "to a point along El Camino Real. Destroyed by an<br/>"
                                 "English raiding party at the time of the siege of<br/>"
                                 "St. Augustine.")
                          (style indefiniteAreaStyle)
                          29.809683 -82.486574
                          (radius 250)
                  )
         )

         (feature SanMartinDeAyaocuto
                  ;Milanich places this mission at Ichetucknee; Hann specifically at Fig Spring
                  ;Fr. López placed the mission 10 leagues from the land of the Potano
                  ;de la Calle placed the mission 34 leagues from St. Augustine
                  ;Mission ended in 1656; Bp. Calderón does not mention it
                  (circle
                    (popup "<b>San Martín de Ayaocuto (1610 - 1656)</b><br/>"
                           "Likely home of the <i>holata</i> (chieftain) of the Northern<br/>"
                           "Utina. Mission died in the revolt of 1656.")
                    (style indefiniteAreaStyle)
                    29.967353 -82.759394
                    (radius 200)
                  )
         )

         (feature SantaCatalinaDeAjohica
                  ;No one seems ready to pin a location for this mission Bp. Calderón named in 1675
                  ;Several authors indicate it was by the Suwannee but fail to locate it
                  ;Gannon places it on the Santa Fe
                  ;Bp. Calderón wrote that the mission was 12 leagues from Santa Fé
                  ;It is not possible to satisfy Bp. Calderón's account of distances between
                  ; Santa Fé, Santa Catalina, Ajohica, Tarihica, ahd Guacara while placing all of
                  ; them on a reasonably direct path for the Camino.  It is generally accepted
                  ; that at least one or two of these missions was at some distance from the
                  ; Camino.  My proposed solution places Santa Catalina about 5 miles north of
                  ; the Camino at the bluffs of Little River near Mt. Pisgah church.  This fits
                  ; well with Bp. Calderón's distance of 12 leagues from Santa Fé.
                  (circle wpSantaCatalinaDeAjohica
                          (popup "<b>Santa Catalina de Ajohica II (1655 - 1685)</b><br/>"
                                 "Mission was recorded to have moved; neither location"
                                 " is known. Proposed here is the second location of the"
                                 " mission based on Bp. Calderón's reports and the"
                                 " characteristics of this area.  Mission was destroyed"
                                 " in Yamassee raids; inhabitants were killed or enslaved.")
                          (style indefiniteAreaStyle)
                          30.099841 -82.903212
                          (radius 200)
                  )
                  (point wpBellamy_SantaCatalinaSpur 30.005308 -82.854712)
         )

         (feature Ajohica
                  ;Town on Bp. Calderón's itinerary
                  ;My proposal places Ajohica at Shingle Spring on the Suwannee south of Branford
                  (circle wpAjohica
                          (popup "<b>Ajohica</b><br/>"
                                 "Proposed location of town Bp. Calderón reported as 3 leagues"
                                 " from Santa Catalina and 2 from Tarihica. Location near"
                                 " Shingle Spring makes it a candidate for a settlement.")
                          (style indefiniteAreaStyle)
                          29.934952 -82.920701
                          (radius 200)
                  )
                  (point wpSantaCatalina_Ajohica_TarihicaSpur 29.945254 -82.918297)
         )

         (feature SantaCruzDeTarihicaII
                  ;Town on Bp. Calderón's itinerary
                  ;My proposal places Tarihica II at Little River Springs on the Suwannee
                  (circle wpTarihica
                          (popup "<b>Santa Cruz de Tarihica II (after 1655 - ca. 1690)</b><br/>"
                                 "Mission moved after 1655 revolt; neither location is known."
                                 " Proposed here is the second location based on Bp. Calderón's"
                                 " report of a 7-league distance from Guacara and this site of"
                                 " springs along the Suwannee.")
                          (style indefiniteAreaStyle)
                          29.997177 -82.965900
                          (radius 200)
                  )
                  (point jctTarihicaSplit_CR349 30.043317 -83.020503)
         )

         (feature SanJuanDeGuacaraI
                  ;Milanich places the first site at Baptizing Spring
                  ;Archeological evidence supports a Baptizing Spring site, but not the records
                  (circle wpSanJuanDeGuacaraI
                          (style indefiniteAreaStyle)
                          (popup "<b>San Juan de Guacara I (1612 - 1655?)</b></br/>"
                                 "Archeological evidence places the first site of the mission"
                                 " here. The name <i>Baptizing Spring</i> stands as a good"
                                 " clue. The early founding of this mission gives weight to"
                                 " the theory that El Camino Real passed through here.")
                          30.136050 -83.134124
                          (radius 200)
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
                  (circle GuacaraII
                          (popup "<b>San Juan De Guacara II (by 1675 - 1689)</b></br/>"
                                 "Second location of the mission to the site of the Suwannee"
                                 " River crossing. Mission was destroyed by the Yamassee.")
                          (style indefiniteAreaStyle)
                          30.166944 -83.230278
                          (radius 150)
                  )
         )

         (feature SantaCruzDeTarihicaI
                  ;The 1655 list gave the distance of 54 leagues from St. Augustine
                  ;No better clues given; distances place it tentatively at Patterson Sink
                  (circle TarihicaAtPattersonSink
                          (popup "<b>Santa Cruz de Tarihica (1612-before 1675)</b>")
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
