////////////////////////////////////
/* --    METH_extraction   -- */
///////////////////////////////////
include { METHYLATION_EXTRACTION } from '../modules/meth_extraction.nf'

workflow METH_extraction {

  take:
  dedup_bam

  main:

  dedup_bam | METHYLATION_EXTRACTION

  
  emit:
  cpg_counts = METHYLATION_EXTRACTION.out
                            .cpg_counts
  
  bismark_cov = METHYLATION_EXTRACTION.out
                            .bismark_cov

  meth_extraction_report = METHYLATION_EXTRACTION.out
                            .meth_extraction_report                          


  
}