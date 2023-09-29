(config

  (lengthUnit league 3 miles)
  (lengthUnit leagues 1 league)

  (baseStyle elDestinoStyle
             "color=#1f78b4"
             "opacity=0.9"
             "fill=true"
             "fillColor=#1f78b4"
             "fillOpacity=0.1"
  )
  (baseStyle indefiniteAreaStyle
             "color=#b47820"
             "opacity=0.8"
             "fill=true"
             "fillColor=#b47820"
             "fillOpacity=0.1"
  )
  (baseStyle bellamyRoadStyle
             "color=#33AA33"
  )
  (baseStyle roadOfInterest
             "color=#AA3333"
             "opacity=0.6"
             "width=5"
  )
  (baseStyle invisiblePath
             "hidePath=true"
  )
  (baseStyle railroad
             "color=#000000"
             "opacity=0.9"
             "width=1"
             "dashArray=3 5"
  )

  (attestationType authority weighted
           (attSym old_map   "weight=2") ; traced from labelled route on old map
           (attSym witness   "weight=2") ; described in a account by a contemporaneous witness
           (attSym marker    "weight=2") ; described on a historical marker
           (attSym scholarly "weight=2") ; described in a latter-day scholarly work
           (attSym published "weight=1") ; published in a non-scholarly latter-day work
           (attSym folktale  "weight=1") ; part of the oral folklore of a place
           (modStyle "opacity=0.8" "width=3")
           (modStyle "opacity=0.8" "width=2")
           (modStyle "opacity=0.7" "width=2")
           (modStyle "opacity=0.7" "width=1")
  )
  (attestationType modernity limit1
           (attSym modern_name)		; modern route with name indicative of historic use
           (attSym modern_path		; modern route without name hinting of history
		 (modStyle "dashArray=4 4"))
           (attSym excursion		; mapped paths away from straightend highways
		 (modStyle "dashArray=4 8"))
           (attSym guess		; connects better-attested points
		 (modStyle "dashArray=2 8"))
  )
  (attestationType confidence limit1
	   (attSym highest )		; highest confidence
           (attSym high    )		; high confidence
           (attSym medium  )    	; medium confidence (default)
           (attSym low			; low confidence
		 (modStyle "width=2"))
           (attSym lowest		; lowest confidence
		 (modStyle "width=1"))
  )
)

