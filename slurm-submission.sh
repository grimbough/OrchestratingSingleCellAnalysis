#!/bin/bash
#SBATCH --job-name=osca-builder
#SBATCH --mem=24G
#SBATCH --time=0-10:0
#SBATCH --output=osca-builder.log

singularity exec -B /g/huber/users/msmith/R-lib/R-4.0_BioC-3.11_OSCA/:/usr/local/lib/R/host-site-library/ osca-singularity.simg R make build

