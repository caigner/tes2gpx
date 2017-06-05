#!/bin/bash

# ------------------------------------------------------------------------------------------------
#
# Das Skript durchsucht das aktuelle Verzeichnis und alle darin enthaltene Unterverzeichnisse
# nach TES-Dateien und wandelt diese in GPX-Dateien um, sofern diese nicht schon vorhanden sind.
#
# ------------------------------------------------------------------------------------------------
#
# This script searches recursivly for Wintecs TES-files and converts them to gpx, using gpsbabel
#
# ------------------------------------------------------------------------------------------------

if [[ ("$1" == "-h") || ("$1" == "--help") ]]; then
    echo "Convert TES-files to gpx-files"
    echo "no Paraneter = search for TES files and convert them all"
    echo "-d = delete TES file after conversion "
fi

DELETE_TES="$1"

GPSBABEL=/usr/bin/gpsbabel

for INFILE in `find . -type f -iname "*.TES"`; do
   OUTFILE=${INFILE%.*}.gpx
   if [[ ! -f $OUTFILE ]]; then
        echo "Converting $INFILE to $OUTFILE ..."
        $GPSBABEL -i wintec_tes -o gpx "$INFILE" "$OUTFILE"
        if [[ "$DELETE_TES" == "-d"  ]]; then       
            if [[ ($? -eq 0) && (-f "$OUTFILE") ]]; then
                rm "$INFILE"
            fi
        fi
    fi
done

