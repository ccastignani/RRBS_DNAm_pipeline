////////////////////////////////////
/* --        CAMDAC RUN        -- */
///////////////////////////////////
include { CAMDAC } from '../modules/camdac.nf'

workflow CAMDAC_run {

  take:
  dedup_bam

  main:
  dedup_bam | CAMDAC 

//   emit:
//   dedup_bam = RRBS_deduplication.out.dedup_bam
//   alignment_report = MAPPING.out.alignment_report 
//   dedup_log = RRBS_deduplication.out.dedup_log
//   dedup_bam_path = RRBS_deduplication.out.dedup_bam_path
  
}