#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=gemma_run_spring
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=8G
#SBATCH --output=stdout.%j
#SBATCH --error=stderr.%j
#SBATCH --mail-type=ALL
#SBATCH --mail-user=edegreef@ucdavis.edu 

cd /scratch/user/edegreef/gemma/spring
file=spring_rank_87
cov=cov5.sex.col.year.age.pc1.txt  #optional covariate file

#making relatedness matrix
/general/home/edegreef/gemma-0.98.1-linux-static -bfile $file -gk 1 -miss 1 -maf 0 -notsnp -o relatedness_matrix

#running LMM with covariate file
/general/home/edegreef/gemma-0.98.1-linux-static -bfile $file -k output/relatedness_matrix.cXX.txt -miss 1 -maf 0 -notsnp -lmm 4 -c $cov -o $file.lmm

echo "LMM completed"
