#!/bin/bash

for j in 0j 1j 2j 3j 4j; do
	for backend in FORTRAN CPP CUDA; do
		file_path="DY${j}_LO_5f_${backend}/DY${j}_LO_5f_${backend}_run_card.dat"
		echo "modifying $file_path"
		cat $file_path | grep "minimum pt for the charged leptons"
		sed -i 's/ 0\.0	= ptl ! minimum pt for the charged leptons/ 10\.0	= ptl ! minimum pt for the charged leptons/' "$file_path"
		cat $file_path | grep "minimum pt for the charged leptons"
	done
done
