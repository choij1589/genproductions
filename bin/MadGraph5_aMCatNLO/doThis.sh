#!/bin/bash
PROCESS_ARR=("DY0j_LO_5f" "DY1j_LO_5f" "DY2j_LO_5f" "DY3j_LO_5f"
             "W0j_LO_5f" "W1j_LO_5f" "W2j_LO_5f" "W3j_LO_5f")

for PROCESS in "${PROCESS_ARR[@]}"; do
    shifter --image=docker:cmssw/el9:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_UPSTREAM cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_UPSTREAM

    shifter --image=docker:cmssw/el9:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_LEGACY cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_LEGACY

    shifter --image=docker:cmssw/el9:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_FORTRAN cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_FORTRAN

    shifter --image=docker:cmssw/el9:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_CPPNONE cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_CPPNONE

    shifter --image=docker:cmssw/el9:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_CPPAVX2 cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_CPPAVX2
done
