////////////////////////////////////
/* --        ALIGNMENT        -- */
///////////////////////////////////
include { RRBS_deduplication } from '../modules/RRBS_deduplication.nf'
include { MAPPING } from '../modules/mapping.nf'


workflow BISMARK_alignment {

  take:
  trimmed_reads

  main:
  trimmed_reads | MAPPING
  MAPPING.out.sorted_sam | RRBS_deduplication

  emit:
  dedup_bam = RRBS_deduplication.out.dedup_bam
  alignment_report = MAPPING.out.alignment_report 
  dedup_log = RRBS_deduplication.out.dedup_log
  dedup_bam_path = RRBS_deduplication.out.dedup_bam_path
  
}