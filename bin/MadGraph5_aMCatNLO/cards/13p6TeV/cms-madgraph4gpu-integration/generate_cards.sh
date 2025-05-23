#!/bin/bash
# Check if required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 PROCESS_NAME BACKEND NB_CORE"
    echo "Example: $0 DY2j_LO_5f CUDA 8"
    exit 1
fi

PROCESS_NAME=$1
BACKEND=$2 
NB_CORE=$3
# Extract process type (DY, TT, or W) from process name
if [[ $PROCESS_NAME =~ ^(DY|TT|W) ]]; then
    PROCESS_TYPE=${BASH_REMATCH[1]}
else
    echo "Error: Process name must start with DY, TT, or W"
    exit 1
fi

# Validate template exists
if [ ! -d "templates/${PROCESS_TYPE}" ]; then
    echo "Error: Template directory templates/${PROCESS_TYPE} not found"
    exit 1
fi

# Validate number of cores is positive integer
if ! [[ "$NB_CORE" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: NB_CORE must be a positive integer"
    exit 1
fi

echo "Processing $PROCESS_NAME with $BACKEND backend and $NB_CORE cores"
mkdir -p ${PROCESS_NAME}_${BACKEND}

# Determine plugin based on backend
PLUGIN=""
if [[ "$BACKEND" == "UPSTREAM" || "$BACKEND" == "LEGACY" ]]; then
    PLUGIN=""
elif [[ "$BACKEND" == "FORTRAN" ]]; then
    PLUGIN="madevent"
elif [[ "$BACKEND" == "CPP"* ]]; then
    PLUGIN="madevent_simd"
elif [[ "$BACKEND" == "CUDA" ]]; then
    PLUGIN="madevent_gpu"
else
    echo "Error: BACKEND must be FORTRAN, CUDA, or CPP*"
    exit 1
fi

# Define the process command
PROC_CARD_CONTENT=""

if [[ "$PROCESS_NAME" == "DY0j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define p = u d c s b u~ d~ c~ s~ b~ g
define j = p
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define nu = ve vm vt
define nubar = ve~ vm~ vt~
generate p p > ell+ ell- @0
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "DY1j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define p = u d c s b u~ d~ c~ s~ b~ g
define j = p
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define nu = ve vm vt
define nubar = ve~ vm~ vt~
generate p p > ell+ ell- j @0
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "DY2j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define p = u d c s b u~ d~ c~ s~ b~ g
define j = p
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define nu = ve vm vt
define nubar = ve~ vm~ vt~
generate p p > ell+ ell- j j @0
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "DY3j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define p = u d c s b u~ d~ c~ s~ b~ g
define j = p
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define nu = ve vm vt
define nubar = ve~ vm~ vt~
generate p p > ell+ ell- j j j @0
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "DY4j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define p = u d c s b u~ d~ c~ s~ b~ g
define j = p
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define nu = ve vm vt
define nubar = ve~ vm~ vt~
generate p p > ell+ ell- j j j j @0
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "DY012j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define p = u d c s b u~ d~ c~ s~ b~ g
define j = p
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define nu = ve vm vt
define nubar = ve~ vm~ vt~
generate p p > ell+ ell- @0
add process p p > ell+ ell- j @1
add process p p > ell+ ell- j j @2
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "DY01234j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define p = u d c s b u~ d~ c~ s~ b~ g
define j = p
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define nu = ve vm vt
define nubar = ve~ vm~ vt~
generate p p > ell+ ell- @0
add process p p > ell+ ell- j @1
add process p p > ell+ ell- j j @2
add process p p > ell+ ell- j j j @3
add process p p > ell+ ell- j j j j @4
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "W0j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~
generate p p > ell+ vl $ t t~ h @0
add process p p > ell- vl~ $ t t~ h @1
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "W1j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~
generate p p > ell+ vl j $ t t~ h @0
add process p p > ell- vl~ j $ t t~ h @1
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "W2j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~
generate p p > ell+ vl j j $ t t~ h @0
add process p p > ell- vl~ j j $ t t~ h @1
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "W3j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~
generate p p > ell+ vl j j j $ t t~ h @0
add process p p > ell- vl~ j j j $ t t~ h @1
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "W4j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~
generate p p > ell+ vl j j j j $ t t~ h @0
add process p p > ell- vl~ j j j j $ t t~ h @1
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "W01234j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-no_b_mass
define ell+ = e+ mu+ ta+
define ell- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~
generate p p > ell+ vl $ t t~ h @0
add process p p > ell- vl~ $ t t~ h @1
add process p p > ell+ vl j $ t t~ h @2
add process p p > ell- vl~ j $ t t~ h @3
add process p p > ell+ vl j j $ t t~ h @4
add process p p > ell- vl~ j j $ t t~ h @5
add process p p > ell+ vl j j j $ t t~ h @6
add process p p > ell- vl~ j j j $ t t~ h @7
add process p p > ell+ vl j j j j $ t t~ h @8
add process p p > ell- vl~ j j j j $ t t~ h @9
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
elif [[ "$PROCESS_NAME" == "TT2j_LO_5f" ]]; then
    PROC_CARD_CONTENT="import model sm-ckm_no_b_mass

generate p p > t t~ j j @0
output ${PLUGIN} ${PROCESS_NAME}_${BACKEND} --hel_recycling=False -nojpeg"
else
    echo "Error: proc_card.dat not defined for $PROCESS_NAME"
    exit 1
fi
# Create proc_card.dat
cat <<EOF > ${PROCESS_NAME}_${BACKEND}/${PROCESS_NAME}_${BACKEND}_proc_card.dat
$PROC_CARD_CONTENT
EOF

# Create run_card.dat by copying from template
cp templates/${PROCESS_TYPE}/run_card.dat ${PROCESS_NAME}_${BACKEND}/${PROCESS_NAME}_${BACKEND}_run_card.dat

# Create customize_card.dat by replacing [BACKEND] with $BACKEND
sed "s|\[BACKEND\]|$BACKEND|" templates/${PROCESS_TYPE}/customizecards.dat > ${PROCESS_NAME}_${BACKEND}/${PROCESS_NAME}_${BACKEND}_customizecards.dat

# Remove the unwanted line from customizecards.dat when backend is UPSTREAM or LEGACY
sed -i '/set run_card cudacpp_backend UPSTREAM/d' ${PROCESS_NAME}_${BACKEND}/${PROCESS_NAME}_${BACKEND}_customizecards.dat
sed -i '/set run_card cudacpp_backend LEGACY/d' ${PROCESS_NAME}_${BACKEND}/${PROCESS_NAME}_${BACKEND}_customizecards.dat

# Create madspin_card.dat for the TTbar process
if [[ "$PROCESS_NAME" == "TT"* ]]; then
    cp templates/${PROCESS_TYPE}/madspin_card.dat ${PROCESS_NAME}_${BACKEND}/${PROCESS_NAME}_${BACKEND}_madspin_card.dat
fi

# Create set_nb_core.patch by replacing [NB_CORE] with $NB_CORE
sed "s|\[NB_CORE\]|$NB_CORE|" templates/${PROCESS_TYPE}/set_nb_core.patch > ${PROCESS_NAME}_${BACKEND}/${PROCESS_NAME}_${BACKEND}_set_nb_core.patch

echo "Cards generated successfully."
ls -l ${PROCESS_NAME}_${BACKEND}
