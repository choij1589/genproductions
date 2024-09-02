#!/bin/bash
#SBATCH --account=m2612
#SBATCH --qos=shared
#SBATCH --constraint=cpu
#SBATCH --time=168:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=256
#SBATCH -o job.%j.out

PROCESS_NAME=$1
DOCKER_IMAGE="choij1589/el8:latest"
WORKDIR="/root/test/MG4GPU/genproductions/bin/MadGraph5_aMCatNLO"
CPU_SET=$(taskset -pc $$ | awk '{print $NF}')
COMMAND="cd $WORKDIR; time ./gridpack_generation.sh $PROCESS_NAME cards/13p6TeV/mg4gpu/$PROCESS_NAME"

podman-hpc run --rm --cvmfs \
       --user root --workdir /root/test \
       --cpuset-cpus=$CPU_SET \
       -v ~/test:/root/test \
       $DOCKER_IMAGE bash -c "$COMMAND"
