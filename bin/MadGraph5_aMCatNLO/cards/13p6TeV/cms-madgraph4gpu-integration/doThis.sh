#!/bin/bash

#PROCESS_ARR=("DY0j_LO_5f" "DY1j_LO_5f" "DY2j_LO_5f" "DY3j_LO_5f" "DY4j_LO_5f" "DY01234j_LO_5f"
#             "W0j_LO_5f" "W1j_LO_5f" "W2j_LO_5f" "W3j_LO_5f" "W4j_LO_5f" "W01234j_LO_5f")

PROCESS_ARR=("DY3j_LO_5f" "DY4j_LO_5f" "W3j_LO_5f" "W4j_LO_5f")

BACKEND_ARR=("LEGACY" "UPSTREAM" "FORTRAN" "CPPNONE" "CPPAVX2")

for PROCESS in "${PROCESS_ARR[@]}"; do
    for BACKEND in "${BACKEND_ARR[@]}"; do
        echo "Processing $PROCESS with $BACKEND"
        ./generate_cards.sh $PROCESS $BACKEND 256
    done
done
