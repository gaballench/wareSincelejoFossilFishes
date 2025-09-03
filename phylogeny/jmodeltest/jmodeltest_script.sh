#!/usr/bin/bash

for i in $(ls .fasta)
do
    echo "Running jModelTest2 on $i\n"
    java -jar /bioprograms/jmodeltest2/dist/jModelTest.jar -BIC -d $i -f -i -g -s 11 -t ML -tr 22 -o $i`date +"%H.%M_%d_%m_%Y"`'.out'
done
