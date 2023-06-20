#!/bin/bash

for PAS in *.pas; do
    EXE=${PAS%.pas}
    if [[ -f ${EXE} ]]; then
        echo "*** ${EXE} ***"
        ./${EXE}
        echo
    else
        echo "No executable found for program $PAS"
        exit 1
    fi
done
