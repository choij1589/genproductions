#!/bin/bash

for j in 4j 01234j; do
  for backend in FORTRAN CPP CUDA; do
      cp -r DY${j}_LO_5f_${backend} DY${j}_LO_5f_NSimplified_${backend}
      cd DY${j}_LO_5f_NSimplified_${backend}
      mv DY${j}_LO_5f_${backend}_proc_card.dat DY${j}_LO_5f_NSimplified_${backend}_proc_card.dat
      mv DY${j}_LO_5f_${backend}_run_card.dat DY${j}_LO_5f_NSimplified_${backend}_run_card.dat
      mv DY${j}_LO_5f_${backend}_customizecards.dat DY${j}_LO_5f_NSimplified_${backend}_customizecards.dat
      mv DY${j}_LO_5f_${backend}_set_nb_core_*.patch DY${j}_LO_5f_NSimplified_${backend}_set_nb_core.patch
      cd -
    done
done
