#!/bin/bash
PROCESS_NAMEs=("TT2j_LO_5f")

for PROCESS in "${PROCESS_NAMEs[@]}"; do
    shifter --image=docker:cmssw/el8:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_UPSTREAM cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_UPSTREAM > ${PROCESS}_UPSTREAM.every.log 2>&1

    shifter --image=docker:cmssw/el8:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_LEGACY cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_LEGACY > ${PROCESS}_LEGACY.every.log 2>&1

    shifter --image=docker:cmssw/el8:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_FORTRAN cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_FORTRAN > ${PROCESS}_FORTRAN.every.log 2>&1

    shifter --image=docker:cmssw/el8:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_CPPNONE cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_CPPNONE > ${PROCESS}_CPPNONE.every.log 2>&1 

    shifter --image=docker:cmssw/el8:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_CPPAVX2 cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_CPPAVX2 > ${PROCESS}_CPPAVX2.every.log 2>&1
    
    shifter --image=docker:cmssw/el8:x86_64 --module=cvmfs,gpu \
    time ./gridpack_generation.sh ${PROCESS}_CUDA cards/13p6TeV/cms-madgraph4gpu-integration/${PROCESS}_CUDA > ${PROCESS}_CUDA.every.log 2>&1
done
