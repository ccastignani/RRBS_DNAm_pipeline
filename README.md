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


DNAm (WORKFLOW)
- FASTQ_preprocess (Subworkflow)
    - Trimgalore (Modules)

- BISMARK_alignment 
    - Bismark alignment + Sort sam

- NUGEN_deduplication
    - RRBS deduplication(python)
    - Cleanup

- SUMMARY


## Repository structure:

/bin
/conf
/inventory
/modules
/subworkflows
/workflows


## Usage:
1. Clone the repo

``git clone https://github.com/ccastignani/RRBS_DNAm_pipeline``

2. Execution wrappers

3. Edit config file

4. Launch Pipeline 

## Acknowledgments:
Special thanks to Mark S. Hill for troubleshooting and nf guidelines and Elizabeth Larose Cadieux for the Nugen RRBS pipeline conceptualization

