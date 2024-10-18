#!/bin/bash

for j in 0j 1j 2j 3j 4j 01234j; do
	for backend in FORTRAN CPP CUDA; do
		cp -r DY012j_LO_5f_${backend} DY${j}_LO_5f_${backend}
		cd DY${j}_LO_5f_${backend}
		mv DY012j_LO_5f_${backend}_proc_card.dat DY${j}_LO_5f_${backend}_proc_card.dat
		mv DY012j_LO_5f_${backend}_run_card.dat DY${j}_LO_5f_${backend}_run_card.dat
		mv DY012j_LO_5f_${backend}_customizecards.dat DY${j}_LO_5f_${backend}_customizecards.dat
		cd -
	done
done
