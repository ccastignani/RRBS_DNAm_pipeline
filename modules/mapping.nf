process MAPPING {
  publishDir "${params.outdir}/qc/mapping", pattern: '*_SE_report.txt', mode: 'copy', saveAs: { filename -> "${row.sample_id_reformat}_SE_report.txt" }

  tag { "${row.sample_name}-${row.sample_id}" }
  label 'max'

  input:
	tuple val( row ), \
         path( 'fq_trimmed' )

	output:
	 tuple val( row ), \
         path( "${row.sampleId}_bismark_sorted.sam" ), emit: sorted_sam

  	 tuple val( row ), \
         path( "${row.sampleId}_SE_report.txt" ), emit: alignment_report

	script:



  """
  module load SAMtools/1.10-foss-2018b
  
  ${params.BISMARK} -q --bowtie2 --path_to_bowtie2 ${params.BOWTIE} --sam --basename "${row.sampleId}" ${params.GENOMEFOLDER} "${fq_trimmed}"


  ${params.SAMTOOLS} sort ${row.sampleId}.sam -@14 -O SAM -o ${row.sampleId}_bismark_sorted.sam

  """
}
