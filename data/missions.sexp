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

         (point StAugustineCityGate
                29.897862 -81.313614
         )

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
                          29.715324 -82.421993
                          (radius 150)
                  )
         )

         (feature SantaFeDeTolocoI
                  ;Next to the Robinson Sinks less than a mile from the Santa Fe River
                  ;The river (and hence many other places in the area) were named for the mission
                  ;Site was some distance from El Camino Real
                  ;Mission and village were moved after the 1656 rebellion
                  ;The Utina of Arapaja moved to the site in 1657
                  (circle wpSantaFeDeTolocoI
                    (popup "<b>Santa Fé de Toloco I (1616 - 1656)</b><br/>"
                           "Mission and people moved south to the safety of El Camino"
                           " after the rebellion of 1656")
                    (style indefiniteAreaStyle)
                    29.930768 -82.525659
                    (radius 250)
                  )
         )

         (feature SantaFeDeTolocoII
                  ;PRESUMPTIVE!  In area of lakes and sinks a short way north of Alachua
                  ;The river (and hence many other places in the area) were named for the mission
                  ;Site was some distance from El Camino Real
                  ;Mission and village were moved after the 1656 rebellion
                  ;The Utina of Arapaja moved to the site in 1657
;                  (circle wpTolocoII
;                          (popup "<b>Santa Fé de Toloco II (1657 - 1702)</b><br/>"
;                                 "Proposed site of the relocated Santa Fé mission to a point"
;                                 " along El Camino Real. Destroyed by an English raiding party"
;                                 " at the time of the siege of St. Augustine.")
;                          (style indefiniteAreaStyle)
;                          29.809683 -82.486574
;                          (radius 250)
;                  )
                  (point wpTolocoII 29.809683 -82.486574)
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
                  ;Mission is halfway between San Martín de Ayaocuto in the east and
                  ; Santa Cruz de Tarihica I in the west.
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
                          30.165861 -83.229920
                          (radius 150)
                  )
         )

         (feature SantaCruzDeTarihicaI
                  ;The 1655 list gave the distance of 54 leagues from St. Augustine
                  ;Also shown as the same distance from Guacara I as is San Martín de
                  ; Ayaocuto: 27.75 miles
                  ;Milanich states that it is well north of El Camino Real
                  ;Hypothesis: mission is at Blue Springs, a first-magnitude spring on the
                  ; Withlacoochee
                  (circle TarihicaI
                          (popup "<b>Santa Cruz de Tarihica (1612 - 1655?)</b><br/>"
                                 "Mission was originally to the west of Guacara I evidently"
                                 " at some distance removed from El Camino Real. There is"
                                 " no better information about its true location. Mission"
                                 " moved to the banks of the Suwannee.")
                          (style indefiniteAreaStyle)
                          30.477008 -83.244863
                          (radius 200)
                  )
                  (point wpSpurTarihicaBlueSprings 30.264295 -83.283215)
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
                          (popup "<b>San Pedro y San Pablo de Potohiriba I (1630)</b><br/>"
                                 "Important mission whose name comes down to us today in"
                                 " places like \"Lake Sampala\" and \"San Pedro Bay.\"<br/>"
                                 "Was one of the last missions to fall.")
                          30.36860 -83.49288
                          (radius 500)
                  )
                  (point wpPotohiriba1_Bellamy 30.362658 -83.488995)
         )

         (feature MachabaIMission
                  ;Variously stated as 1.5 or 2 miles from Potohiriba
                  (circle MachabaI
                          (style indefiniteAreaStyle)
                          (popup "<b>Santa Elena de Machaba (1655)</b><br/>"
                                 "Reported as 1.5 to 2 leagues from Potohiriba.<br/>"
                                 "No mission site has been found")
                          30.361282 -83.568119
                          (radius 300)
                  )
         )

         (feature TolapatafiMission
                  ;San Mateo de Tolapatafi
                  ;Variously stated as 3.5 or 4 leagues from Machaba
                  (circle Tolapatafi
                          (style indefiniteAreaStyle)
                          (popup "<b>San Mateo de Tolapatafi (1656)</b><br/>"
                                 "Listed as 3.5 or 4 leagues from Machaba.")
                          30.368506 -83.715390
                          (radius 200)
                  )
         )

         (feature SanMiguelDeAsile
                  ;San Miguel de Asile
                  ;Westernmost Yustaga mission, therefore the westernmost Timucua mission
                  ;Variously stated as 2 or 2.5 leagues from San Mateo de Tolapatafi
                  (circle AsileMission
                          (style indefiniteAreaStyle)
                          (popup "<b>San Miguel de Asile</b><br/>"
                                 "Westernmost Timucuan mission; is on west side of the"
                                 " Aucilla River. Reported as 2 or 2.5 leagues from San"
                                 " Mateo de Tolapatafi")
                          30.371040 -83.807334
                          (radius 200)
                  )
         )


         (feature SanPedroYSanPabloDePataleI
                  ;San Pedro y San Pablo de Patale
                  ;Unearthed mission site
                  (circle PataleIMission
                          (style indefiniteAreaStyle)
                          (popup "<b>San Pedro y San Pablo de Patale I</b><br/>"
                                 "Archeological site added to National Register of"
                                 " Historic Places in 1972. Presumably this was the"
                                 " earliest site of this mission, not the one visited"
                                 " by Bp. Calderón in 1675, which was likely nearer"
                                 " St. Marks River, perhaps along the route that"
                                 " became Bellamy Road. That site would seem to be"
                                 " the site of the terrible massacre of 1704.")
                          30.467222 -84.150222
                          (radius 200)
                  )
         )

         (feature SanLuisDeTalimaliII
                  ;San Luís de Talimali
                  ;Continually attested since its founding
                  (circle TalimaliII
                          (style indefiniteAreaStyle)
                          (popup "<b>San Luís de Talimali</b> (1656-1704)<br/>"
                                 "Capital of the Apalachee Province.  Unique among"
                                 " the Spanish missions in the interior of Florida"
                                 " in that the site was never lost to living memory."
                                 " The mission moved here from an unknown place to"
                                 " the east, perhaps near Myers Park.<br/>"
                                 "Despite its strong fortifications, the site was"
                                 " abandoned in 1704 in before it could be fully"
                                 " besieged by the English.")
                          30.449088 -84.319905
                          (radius 250)
                  )
         )
)
