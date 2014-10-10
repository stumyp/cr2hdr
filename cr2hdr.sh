#!/bin/bash

INPUT=$1
OUTPUT=$2
if [ -z "$INPUT" -o -z "$OUTPUT" ] ; then echo "Usage: $0 <input> <output>"; exit 0; fi
UFRAW=/usr/bin/ufraw-batch
ENFUSE=/usr/bin/enfuse
TMP=/tmp/
DARK=$TMP/$$_1.jpg
NORMAL=$TMP/$$_2.jpg
LIGHT=$TMP/$$_3.jpg
$UFRAW --out-type=jpg  --size 1920 --wb=camera --exposure=-1 --interpolation=ahd --output=$DARK   $INPUT
$UFRAW --out-type=jpg  --size 1920 --wb=camera --exposure=0  --interpolation=ahd --output=$NORMAL $INPUT
$UFRAW --out-type=jpg  --size 1920 --wb=camera --exposure=1  --interpolation=ahd --output=$LIGHT  $INPUT

$ENFUSE -v --compression=85  -o $OUTPUT $DARK $NORMAL $LIGHT

rm -fv $DARK $NORMAL $LIGHT
