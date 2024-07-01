# Copyright © 2023 Michael Thompson
# SPDX-License-Identifier: GPL-2.0-or-later

web: index.html data.js
.phony: web

index.html: index_template.html.sh app.js data.js local.css vendor/dommyAll.js vendor/leaflet/leaflet.js vendor/leaflet/leaflet.css
	./index_template.html.sh

data.js: data
	misiones -d data/ -g data.js

.phony: clean
clean:
	-rm -f index.html data.js tar.tar.gz
	-rm -rf tardir

.phony: tar
tar: index.html
	-rm -rf tardir
	mkdir tardir
	cp -p index.html app.js data.js local.css mapinfo.xml vendor/dommyAll.js tardir
	cp -pr vendor/leaflet/* tardir
	cd tardir; tar czf ../tar.tar.gz .
	rm -rf tardir

