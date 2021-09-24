process MERGE_SUMMARY {
  publishDir "${params.outdir}", pattern: '*_report.tsv', mode: 'copy'
  label 'md'

  input:
    file( '*')

  output:
  path ( "summary_report.tsv" )

  script:

  """
  if [[ -e summary_report.tsv ]]
    then 
      rm summary_report.tsv
    fi 


  printf "total_reads\treads_with_adapters\treads_written\tquality-trimmed\ttotal_written\t" >> summary_report.tsv
  printf "total_sequences\tunique_best_hit\tno_alignments\tnot_map_uniquely\t" >> summary_report.tsv
  printf "total_C\tC_in_CpG_context\tC_in_CHG_context\tC_in_CHH_context\t" >> summary_report.tsv
  printf "unaligned_reads\talignments_processed\tduplicates\tdup_rate\tduplicates_no_barcode\tdup_rate_no_barcode\n" >> summary_report.tsv

  cat *LTX*_report.tsv >> summary_report.tsv
  """

}
