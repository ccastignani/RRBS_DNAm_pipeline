#  TRACERx NUGEN RRBS DNAm Pipeline

## Table of Contents:
- Repository structure
- Pipeline Overview
- Description
- Usage

## Repository structure:

- ``/bin``: Contains executables and "primary" scripts. Eg: removeN6duplicates.py from Nugen
- ``/conf``: Nextflow configuration files. These are used to specify settings for local, debug, and HPC environments.
- ``/inventory``: contains an example of the inventory used as input for the pipeline
- ``/modules``: Nextflow modules. These follow the naming convention <name>.module.nf, and may be nested within a directory with additional required scripts and files.
- ``/subworkflows``: Contains nested subworkflows (eg. FASTQ_preprocess, BISMARK_alignment, NUGEN_deduplication or SUMMARY)
- ``/workflows``: Contains the DNAm_nf pipeline
  
## Pipeline Overview:
![nextflow_pipeline](https://github.com/ccastignani/RRBS_DNAm_pipeline/assets/44896853/0285b6e7-bbc6-4856-876d-7b2b3c41a530)

## Description:
This pipeline performs the alignment and methylation extraction for RRBS Nugen sequencing. 

### Input

The initial input of this pipeline is a CSV file containing the inventory of samples to run (each row corresponding to an independent sample). See ``inventory/inventory.csv`` for an example. 

### DNAm (WORKFLOW)

This workflow has the following subworkflows:
- FASTQ_preprocess (Subworkflow): Performs Trimming using trimgalore
- BISMARK_alignment (Subworkflow): Performs Bismark alignment and sorts 
- NUGEN_deduplication (Subworkflow): Performs Deduplication step using Nugen Custom py script (See manual: https://www.nugen.com/sites/default/files/M01394_v6_User_Guide%3A_Ovation_RRBS_Methyl-Seq_System_5912.pdf) and cleanup 
- SUMMARY (Subworkflow): Aggregates QC reports of all previous processes into a single summary report

### Output

The pipeline will output a nested directory in the defined output directory with the following structure:
- ``/bam``: Contains bams and bam.ai files
- ``/methylation_extraction``: Contains output for Bismark Methylation Extraction (each sample in a subfolder)
- ``/qc``: Contains reports for each process (deduplication, Bismark alignment, Bismark methylation extraction, and trimming)
  - ``/dedup``
  - ``/mapping``
  - ``/methylation_extraction``
  - ``/trimming``

Additionally, it will output an updated inventory with a new column corresponding to the absolute path to the bam file (``sample_merged2.txt``) and a summary report (``summary_report.tsv``) containing some metrics used for QC (eg. aligned reads, mapping efficiency, duplication rate, etc). 



## Usage:
**1. Clone the repo**

``git clone https://github.com/ccastignani/RRBS_DNAm_pipeline``

**2. Installation and edit config file**

Before you start running the pipeline, you should make sure all required software is installed and the config file is set up accordingly (``conf/crick.conf``). You should make sure the ``params`` section contains the paths to the input and output directories as well as the executables (Trimgalore, Bismark, Bowtie and Samtools).

**3. Execution wrappers and launch Pipeline**

The pipeline can be called from a bash wrapper script as follows which can be launched via `` sbatch submit.sh ``:

```
#!/usr/bin/env bash
ml Nextflow
ml Singularity
NXF_VER=20.12.0-edge nextflow run ./main.nf -profile crick -queue-size 500 -resume
```


## Acknowledgments:
Special thanks to Mark S. Hill for troubleshooting and nf guidelines and Elizabeth Larose Cadieux for the Nugen RRBS pipeline conceptualization

