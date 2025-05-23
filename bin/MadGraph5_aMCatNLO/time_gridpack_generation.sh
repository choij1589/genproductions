#!/bin/bash

# Wrapper script to run the profile_gridpack_generation.sh with timing
# This allows profiling of the overall script execution time

echo "=== PROFILING: Starting overall gridpack generation process ==="
start_time=$(date +%s)

# Run the gridpack generation script with all arguments passed to this script
time ./profile_gridpack_generation.sh "$@"

end_time=$(date +%s)
duration=$((end_time - start_time))
hours=$((duration / 3600))
minutes=$(( (duration % 3600) / 60 ))
seconds=$((duration % 60))
echo "=== PROFILING: Overall gridpack generation completed in ${hours}h ${minutes}m ${seconds}s ===" 