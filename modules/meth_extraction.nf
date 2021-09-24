process METHYLATION_EXTRACTION {

  tag { "${row.sample_id}" }
  publishDir "${params.outdir}/methylation_extraction/${row.sample_id}", pattern: 'CpG_OB_*_txt.txt.gz', mode: 'copy', saveAs: { filename -> "CpG_OB_${row.sample_id}.txt.gz" }
  publishDir "${params.outdir}/methylation_extraction/${row.sample_id}", pattern: 'CpG_OT_*_txt.txt.gz', mode: 'copy', saveAs: { filename -> "CpG_OT_${row.sample_id}.txt.gz" }
  publishDir "${params.outdir}/methylation_extraction/${row.sample_id}", pattern: '*bismark.cov.gz', mode: 'copy', saveAs: { filename -> "${row.sample_id}_bismark.cov.gz" }
  publishDir "${params.outdir}/methylation_extraction/${row.sample_id}", pattern: '*M-bias.txt', mode: 'copy', saveAs: { filename -> "${row.sample_id}_M-bias.txt" }
  publishDir "${params.outdir}/methylation_extraction/${row.sample_id}", pattern: 'CHG_OB_*.gz', mode: 'copy', saveAs: { filename -> "CHG_OB_${row.sample_id}.txt.gz" }
  publishDir "${params.outdir}/methylation_extraction/${row.sample_id}", pattern: 'CHG_OT_*.gz', mode: 'copy', saveAs: { filename -> "CHG_OT_${row.sample_id}.txt.gz" }
  publishDir "${params.outdir}/methylation_extraction/${row.sample_id}", pattern: 'CHH_OB_*.gz', mode: 'copy', saveAs: { filename -> "CHH_OB_${row.sample_id}.txt.gz" }
  publishDir "${params.outdir}/methylation_extraction/${row.sample_id}", pattern: 'CHH_OT_*.gz', mode: 'copy', saveAs: { filename -> "CHH_OT_${row.sample_id}.txt.gz" }
  
  publishDir "${params.outdir}/qc/methylation_extraction", pattern: '*_splitting_report.txt', mode: 'copy', saveAs: { filename -> "${row.sample_id}_splitting_report.txt" }

 label 'lg'

  input:
	tuple val( row ), \
         path( 'dedup_bam' )

	output:
	 tuple val( row ), \
        path( "CpG_OB_dedup_txt.txt.gz" ),\
        path( "CpG_OT_dedup_txt.txt.gz" ), emit: cpg_counts

  	tuple val( row ), \
        path( "dedup_bismark.cov.gz" ), emit: bismark_cov

    tuple val( row ), \
        path( "dedup_bam_splitting_report.txt" ), emit: meth_extraction_report

    tuple val( row ), \
        path( "dedup_M-bias.txt" ), \
        path( "CHG_OB_dedup_txt.txt.gz" ), \
        path( "CHG_OT_dedup_txt.txt.gz" ), \
        path( "CHH_OB_dedup_txt.txt.gz" ),\
        path( "CHH_OT_dedup_txt.txt.gz" ) , emit: other


	script:

  """

  module load SAMtools/1.10-foss-2018b
  ${params.methylation_extractor} ${dedup_bam} -s --no_overlap \
          --gzip \
          --bedGraph --buffer_size 90% \
          --genome_folder ${params.GENOMEFOLDER} \
          --parallel 12 

  """
}
