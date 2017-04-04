#!/bin/bash

# Das Skript durchsucht das aktuelle Verzeichnis und alle darin enthaltene Unterverzeichnisse
# nach TES-Dateien und wandelt diese in GPX-Dateien um, sofern diese nicht schon vorhanden sind.

GPSBABEL=/usr/bin/gpsbabel


for INFILE in `find . -type f -iname "*.TES"`; do
	OUTFILE=${INFILE%.*}.gpx
	if [[ ! -f $OUTFILE ]]; then
		echo Converting $INFILE to $OUTFILE ...
		$GPSBABEL -i wintec_tes -o gpx $INFILE $OUTFILE
	fi
done

