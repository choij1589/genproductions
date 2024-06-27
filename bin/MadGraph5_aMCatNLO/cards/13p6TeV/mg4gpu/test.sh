#!/bin/bash

for j in 0j 1j 2j 3j; do
	for backend in FORTRAN CPP CUDA; do
		file_path="DY${j}_LO_5f_${backend}/DY${j}_LO_5f_${backend}_proc_card.dat"
		echo $file_path
		cat $file_path

	done
done
