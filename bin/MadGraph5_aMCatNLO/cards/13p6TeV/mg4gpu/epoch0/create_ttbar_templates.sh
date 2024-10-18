#!/bin/bash

for j in 0j 1j 2j 3j 0123j; do
  for backend in FORTRAN CPP; do
	cp -r TT${j}_CKM_LO_5f_CUDA TT${j}_CKM_LO_5f_${backend}
	cd TT${j}_CKM_LO_5f_${backend}
	mv TT${j}_CKM_LO_5f_CUDA_proc_card.dat TT${j}_CKM_LO_5f_${backend}_proc_card.dat
	mv TT${j}_CKM_LO_5f_CUDA_run_card.dat TT${j}_CKM_LO_5f_${backend}_run_card.dat
	mv TT${j}_CKM_LO_5f_CUDA_customizecards.dat TT${j}_CKM_LO_5f_${backend}_customizecards.dat
	sed -i "s/CUDA/${backend}/g" TT${j}_CKM_LO_5f_${backend}_proc_card.dat
	sed -i "s/set cudacpp_backend CUDA/set cudacpp_backend ${backend}/" TT${j}_CKM_LO_5f_${backend}_customizecards.dat
	cd -
  done
done
