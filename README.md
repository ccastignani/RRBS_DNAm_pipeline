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

- ``/bin``: Contains executables and "primary" scripts. Primary scripts are generally R scripts which are run almost exclusively within a single process.
- ``/conf``: Nextflow configuration files. These are used to specify settings for local, debug, and CAMP environments.
- ``/inventory``: contains an example of the inventory used as input for the pipeline
- ``/modules``: Nextflow modules. These follow the naming convention <name>.module.nf, and may be nested within a directory with additional required scripts and files.
- ``/subworkflows``: Nextflow modules. These follow the naming convention <name>.module.nf, and may be nested within a directory with additional required scripts and files.
- ``/workflows``: Contains the DNAm_nf pipeline

## Before running the pipeline

Before you start running the pipeline, you should make sure all required software are downloaded and the config file is set up accordingly ([link])https://github.com/ccastignani/RRBS_DNAm_pipeline/blob/main/conf/crick.conf). 

## Usage:
1. Clone the repo

``git clone https://github.com/ccastignani/RRBS_DNAm_pipeline``

2. Execution wrappers

3. Edit config file

4. Launch Pipeline 

## Acknowledgments:
Special thanks to Mark S. Hill for troubleshooting and nf guidelines and Elizabeth Larose Cadieux for the Nugen RRBS pipeline conceptualization

