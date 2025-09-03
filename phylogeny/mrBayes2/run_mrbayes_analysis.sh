#!/bin/bash
# dependencies: mpirun (openmpi), mrbayes compiled for mpi support AND beagle
# hardware: a machine with at least 16 processors. Modify the .mb script in order to use less that that amount
Rscript beginExec.R
time mpirun -n 16 /bioprograms/MrBayes/Mr*/mr*/src/./mb-parallel-beagle *.mb
Rscript finishExec.R
