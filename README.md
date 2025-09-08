# wareSincelejoFossilFishes

Code and data for the paper "Fossil Freshwater Fishes from the Pliocene of northern Colombia and the Palaeogeography of northern South America" by Ballen et al.

## Structure of this repository

```
├── faunal_clustering
│   ├── dagosta2017
│   │   ├── modern_incidence_nomissing.tab
│   │   └── modern_incidence.tab
│   ├── fossil_occs.tsv
│   ├── palaeoLocs.kml
│   └── clustering.R
├── phylogeny
│   ├── jmodeltest
│   │   ├── 12S_gblocks_nom.fasta
│   │   ├── 12S_gblocks_nom.fasta21.55_29_08_2018.out
│   │   ├── cytb_lund_algGINSI_ed_nom.fasta
│   │   ├── cytb_lund_algGINSI_ed_nom.fasta22.03_29_08_2018.out
│   │   ├── jmodeltest_script.sh
│   │   ├── rag1_lund_algLINSI_ed_nom.fas
│   │   ├── rag1_lund_algLINSI_ed_nom.fasta
│   │   ├── rag1_lund_algLINSI_ed_nom.fasta22.10_29_08_2018.out
│   │   ├── rag2_lund_algGINSI_ed_nom.fasta
│   │   └── rag2_lund_algGINSI_ed_nom.fasta22.16_29_08_2018.out
│   ├── mrBayes2
│   │   ├── all_markers_ed_nom.fasta
│   │   ├── all_markers_ed_nom.nex
│   │   ├── all_markers_ed_nom.nex.ckp
│   │   ├── all_markers_ed_nom.nex.con.tre
│   │   ├── all_markers_ed_nom.nex.lstat
│   │   ├── all_markers_ed_nom.nex.mcmc
│   │   ├── all_markers_ed_nom.nex.parts
│   │   ├── all_markers_ed_nom.nex.pstat
│   │   ├── all_markers_ed_nom.nex.run1.p
│   │   ├── all_markers_ed_nom.nex.run1.t
│   │   ├── all_markers_ed_nom.nex.run2.p
│   │   ├── all_markers_ed_nom.nex.run2.t
│   │   ├── all_markers_ed_nom.nex.trprobs
│   │   ├── all_markers_ed_nom.nex.tstat
│   │   ├── all_markers_ed_nom.nex.vstat
│   │   ├── phylogeny_mrbayes.log
│   │   ├── phylogeny_mrbayes.mb
│   │   └── run_mrbayes_analysis.sh
│   └── new_alignments
│       ├── 12S_algGINSI_gblocks_nom.fasta
│       ├── 12S_lund_algGINSI.fasta
│       ├── all_markers_ed_nom.fasta
│       ├── all_markers.fasta
│       ├── cytb_lund_algGINSI_ed_nom.fasta
│       ├── cytb_lund_algGINSI.fasta
│       ├── partitions.txt
│       ├── rag1_lund_algLINSI_ed_nom.fas
│       ├── rag1_lund_algLINSI.fasta
│       ├── rag1+rag2_ed_nom.fasta
│       ├── rag2_lund_algGINSI_ed_nom.fasta
│       └── rag2_lund_algGINSI.fasta
```

Each directory has an analytical step. Below we describe each directory and its contents.

### `faunal_clustering`: Faunal hierarchical cluster analysis

There is a tab-separated-value file with the fossil occurrences (`fossil_occs.tsv`) and a directory with the recent fish communities per basin (`dagosta2017`). Both datasets are used by the script `clustering.R`, which carries out the calculation of faunal clustering. It also uses the `palaeoLocs.kml` file with coordinates of the representative point coordinate for each fossil assemblage. During preparation of the project this analysis was informally referred to as similarity or dissimilarity both in the code and manuscript. However, it is a cluster analysis which uses a distance, which is the result we are interested in here. It requires `R` and the package `pvclust`.

### `phylogeny`: Bayesian inference of the Pimelodidae including the specimen from the Sincelejo Formation.

The total-evidence Bayesian phylogenetic inference was carried out combining DNA markers and a morphological partition. See the supplementary material for details.

#### `new_alignments`: Aligned and trimmed sequences

This step contains the aligned sequences using `MAFFT` that were later on trimmed with `GBlocks` on the command line.

#### `jmodeltest`: Choosing the best substitution model for each partition

Once the partitions were aligned and trimmed, we chose the best DNA substitution model using `jModelTest2`, running on a Linux server with 22 threads, and using the Bayesian Information Criterion (BIC) as the selection criterion. The `Bash` script with all the arguments is found in `jmodeltest_script.sh`.

#### `mrBayes2`: Total-evidence Bayesian inference 

Once the partitions were aligned and we had the best substitution model for each, we assembled a total-evidence partition combining each molecular partition and a morphological one in a single analysis using MrBayes. Each partition had its own substitution model and parameter set, but they were all linked to the same tree. The Mk model was used for the morphological partition. The data matrix in nexus format is in the file `all_markers_ed_nom.nex`. The script containing all the Bayesian model specification including partitioning, substitution models, MCMC settings, and summarisation is in the file `phylogeny_mrbayes.mb`. The `Bash` script `run_mrbayes_analysis.sh` runs `MrBayes` in parallel. The analysis generates a log file `phylogeny_mrbayes.log` as well as a number of output files all starting with `all_markers_ed_nom.nex.` that contain multiple details bout the MCMC sampling. Please see the documentation of MrBayes for full details on their contents.


## Citation

Please cite our article if you use all of part of the present code.

Ballen, G. A., Montes, C., Carrillo-Briceño, J. D., Bogan, S., Reinales, S., de Pinna, M. C., & Jaramillo, C. (2024). Fossil Freshwater Fishes from the Pliocene of northern Colombia and the Palaeogeography of northern South America. bioRxiv, 2024-12.

If you use bibtex, here is a suggested entry:

```
@article{ballen2024fossil,
  title={{Fossil Freshwater Fishes from the Pliocene of northern Colombia and the Palaeogeography of northern South America}},
  author={Ballen, Gustavo A and Montes, Camilo and Carrillo-Brice{\~n}o, Jorge D and Bogan, Sergio and Reinales, Sandra and de Pinna, Mario CC and Jaramillo, Carlos},
  journal={bioRxiv},
  pages={2024--12},
  year={2024}
}

```
