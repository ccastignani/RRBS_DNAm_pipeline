#  TRACERx NUGEN RRBS DNAm Pipeline

#h2 Table of Contents:

#h2 Pipeline Overview:
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

#h2 Description:

Input:

Output:



#h2 Repository structure:

#h2 Usage:
1. Clone the repo

2. Execution wrappers

3. Edit config file

4. Launch Pipeline 

#h2 Acknowledgments:
Special thanks to Mark S. Hill for troubleshooting and nf guidelines and Elizabeth Larose Cadieux for the Nugen RRBS pipeline conceptualization

