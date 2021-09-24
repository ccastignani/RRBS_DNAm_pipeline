////////////////////////////////////
/* --        ALIGNMENT        -- */
///////////////////////////////////collect all output before running this part
include { SUMMARY } from '../modules/summary_report.nf'
include { MERGE_SUMMARY } from '../modules/merge_summary.nf'

workflow ALIGNMENT_report {

  take:
    trimming_report
    alignment_report
    dedup_log

  main:
    SUMMARY ( trimming_report, alignment_report, dedup_log )
    SUMMARY.out.summary_report.collect() | MERGE_SUMMARY

  
}