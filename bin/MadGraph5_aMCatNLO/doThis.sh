#!/bin/bash
shifter --image=docker:cmssw/el9:x86_64 --module=cvmfs,gpu \
time ./gridpack_generation.sh DY012j_LO_5f_FORTRAN cards/13p6TeV/cms-madgraph4gpu-integration/DY012j_LO_5f_FORTRAN

shifter --image=docker:cmssw/el9:x86_64 --module=cvmfs,gpu \
time ./gridpack_generation.sh DY012j_LO_5f_CPPNONE cards/13p6TeV/cms-madgraph4gpu-integration/DY012j_LO_5f_CPPNONE

shifter --image=docker:cmssw/el9:x86_64 --module=cvmfs,gpu \
time ./gridpack_generation.sh DY012j_LO_5f_CPPAVX2 cards/13p6TeV/cms-madgraph4gpu-integration/DY012j_LO_5f_CPPAVX2

shifter --image=docker:cmssw/el9:x86_64 --module=cvmfs,gpu \
time ./gridpack_generation.sh DY012j_LO_5f_CUDA cards/13p6TeV/cms-madgraph4gpu-integration/DY012j_LO_5f_CUDA
