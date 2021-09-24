process SUMMARY {

label 'md'

  input:
    tuple val( row ), path( 'trimming_report' )
    
    tuple val( row ), path( 'alignment_report' )
    
    tuple val( row ), path( 'dedup_log' )

  
  output: 
  path( "${row.sample_id}_summary_report.tsv" ), emit: summary_report
	
  script:

  """ 
  C2="\$(grep "Total reads" trimming_report | sed 's/[^0-9]*//g')"
  C3="\$(grep "Reads with adapters" trimming_report | awk '{ print \$4 }')"
  C4="\$(grep "Reads written" trimming_report | awk '{ print \$5 }')"
  C5="\$(grep "Quality-trimmed" trimming_report | awk '{ print \$4 }' | sed 's/[^0-9.]*//g')"
  C6="\$(grep "Total written" trimming_report | awk '{ print \$6 }' | sed 's/[^0-9.]*//g')"

  C7="\$(grep "Sequences analysed in total" alignment_report | sed 's/[^0-9]*//g')"
  C8="\$(grep "with a unique best hit" alignment_report | sed 's/[^0-9]*//g')"
  C9="\$(grep "with no alignments" alignment_report| sed 's/[^0-9]*//g')"
  C10="\$(grep "not map uniquely" alignment_report | sed 's/[^0-9]*//g')"

  C11="\$(grep "Total number of C" alignment_report | sed 's/[^0-9]*//g')"
  C12="\$(grep "C methylated in CpG context" alignment_report | sed 's/[^0-9.]*//g')"
  C13="\$(grep "C methylated in CHG context" alignment_report | sed 's/[^0-9.]*//g')"
  C14="\$(grep "C methylated in CHH context" alignment_report | sed 's/[^0-9.]*//g')"

  C15="\$(awk '{print \$4}' dedup_log)"
  C16="\$(awk '{print \$7}' dedup_log)"
  C17="\$(awk '{print \$11}' dedup_log)"
  C18="\$(awk '{print \$16}' dedup_log | sed 's/).//')"
  C19="\$(awk '{print \$24}' dedup_log)"
  C20="\$(awk '{print \$29}' dedup_log | sed 's/)//')"

  printf "${row.sample_id}\t\${C2}\t\${C3}\t\${C4}\t\${C5}\t\${C6}\t" >> ${row.sample_id}_summary_report.tsv
  printf "\${C7}\t\${C8}\t\${C9}\t\${C10}\t" >> ${row.sample_id}_summary_report.tsv
  printf "\${C11}\t\${C12}\t\${C13}\t\${C14}\t" >> ${row.sample_id}_summary_report.tsv
  printf "\${C15}\t\${C16}\t\${C17}\t\${C18}\t\${C19}\t\${C20}\n" >> ${row.sample_id}_summary_report.tsv
  """

}
