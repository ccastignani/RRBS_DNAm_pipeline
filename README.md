#  TRACERx NUGEN RRBS DNAm Pipeline

##Table of Contents:

##Pipeline Overview:
 ##ADD photo

DNAm (WORKFLOW)
- FASTQ_preprocess (Subworkflow)
    - Trimgalore (Modules)

- BISMARK_alignment 
    - Bismark alignment + Sort sam

- NUGEN_deduplication
    - RRBS deduplication(python)
    - Cleanup

- SUMMARY

##Description:

Input:

Output:



##Repository structure:

##Usage:
1. Clone the repo

2. Execution wrappers

3. Edit config file

4. Launch Pipeline 

##Acknowledgments:
Special thanks to Mark S. Hill for troubleshooting and nf guidelines and Elizabeth Larose Cadieux for the Nugen RRBS pipeline conceptualization

