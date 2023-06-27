#!/bin/bash
INPUT=$1
if [[ ! -f $INPUT ]]; then
    echo "Usage: conv.sh INPUT_FILE"
    exit 1
fi
OUTPUT=${INPUT%.avi}.gif
ffmpeg -i $INPUT -vf "fps=10,scale=640:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse"     -loop 0 $OUTPUT
