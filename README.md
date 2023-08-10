#  TRACERx NUGEN RRBS DNAm Pipeline

## Table of Contents:
- Pipeline Overview
- Description
- Repository structure
- Usage
  
## Pipeline Overview:
![nextflow_pipeline](https://github.com/ccastignani/RRBS_DNAm_pipeline/assets/44896853/0285b6e7-bbc6-4856-876d-7b2b3c41a530)

## Description:
This pipeline performs the alignment and methylation extraction for RRBS Nugen sequencing. 

### Input
DNAm (WORKFLOW)
- FASTQ_preprocess (Subworkflow)
    - Trimgalore (Modules)

- BISMARK_alignment 
    - Bismark alignment + Sort sam

- NUGEN_deduplication
    - RRBS deduplication(python)
    - Cleanup

- SUMMARY

### Output

## Repository structure:

- ``/bin``: Contains executables and "primary" scripts. Eg: removeN6duplicates.py from Nugen
- ``/conf``: Nextflow configuration files. These are used to specify settings for local, debug, and HPC environments.
- ``/inventory``: contains an example of the inventory used as input for the pipeline
- ``/modules``: Nextflow modules. These follow the naming convention <name>.module.nf, and may be nested within a directory with additional required scripts and files.
- ``/subworkflows``: Contains nested subworkflows (eg. FASTQ_preprocess, BISMARK_alignment, NUGEN_deduplication or SUMMARY)
- ``/workflows``: Contains the DNAm_nf pipeline

## Usage:
**1. Clone the repo**

``git clone https://github.com/ccastignani/RRBS_DNAm_pipeline``

**2. Installation and edit config file**

Before you start running the pipeline, you should make sure all required software is installed and the config file is set up accordingly (``conf/crick.conf``). You should make sure the ``params`` section contains the paths to the input and output directories as well as the executables (Trimgalore, Bismark, Bowtie and Samtools).

**3. Execution wrappers and launch Pipeline**

The pipeline can be called from a bash wrapper script as follows which can be launched via `` sbatch submit.sh ``:

'' #!/usr/bin/env bash
ml Nextflow
ml Singularity
NXF_VER=20.12.0-edge nextflow run ./main.nf -profile crick -queue-size 500 -resume''


## Acknowledgments:
Special thanks to Mark S. Hill for troubleshooting and nf guidelines and Elizabeth Larose Cadieux for the Nugen RRBS pipeline conceptualization

