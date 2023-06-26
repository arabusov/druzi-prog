#!/bin/bash -e

INPUT=$1
if [[ ! -f $INPUT ]]; then
    echo "Usage: conv.sh INPUT_FILE"
    exit 1
fi
OUTPUT=${INPUT^^}
echo '{ DOSBox configuration. Type before running TPX:' > $OUTPUT
echo '      Z:\KEYB ru441 866' >> $OUTPUT
echo '}' >> $OUTPUT
iconv -f=utf-8 -t=CP866 $INPUT | unix2dos >> $OUTPUT
