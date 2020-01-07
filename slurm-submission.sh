#!/bin/bash
#SBATCH --job-name=osca-builder
#SBATCH --nodes=1
#SBATCH --mem=24G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=1-0:0
#SBATCH --output=/g/huber/users/msmith/OrchestratingSingleCellAnalysis/logs/osca-builder.log

PROJ_ROOT=/g/huber/users/msmith/OrchestratingSingleCellAnalysis/
R_LIB=/g/huber/users/msmith/R-lib/R-4.0_BioC-3.11_OSCA/

cd $PROJ_ROOT

srun singularity exec -B $R_LIB:/usr/local/lib/R/host-site-library/ -B /scratch $PROJ_ROOT/osca-singularity.simg R -e 'BiocManager::install(update = TRUE, ask = FALSE)'
srun singularity exec -B $R_LIB:/usr/local/lib/R/host-site-library/ -B /scratch $PROJ_ROOT/osca-singularity.simg R -e 'OSCAUtils::spawnBook("/scratch/msmith/test2"); OSCAUtils::compileWorkflows("/scratch/msmith/test2", fresh=FALSE)'
srun singularity exec -B $R_LIB:/usr/local/lib/R/host-site-library/ -B /scratch $PROJ_ROOT/osca-singularity.simg R -e 'setwd("/scratch/msmith/test2"); bookdown::render_book("index.Rmd", "bookdown::gitbook", quiet = FALSE, output_dir = "docs", new_session = TRUE)'


