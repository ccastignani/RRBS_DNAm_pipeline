# DNAm_pipeline
TRACERx DNAm pipeline


Pipeline Structure:

DNAm (WORKFLOW)
- FASTQ_preprocess (Subworkflow)
    - Trimgalore (Modules)

- BISMARK_alignment 
    - Bismark alignment + Sort sam

- NUGEN_deduplication
    - RRBS deduplication(python)
    - Cleanup

- SUMMARY
