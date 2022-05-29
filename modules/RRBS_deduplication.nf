process RRBS_deduplication {
  tag { "${row.sample_name}-${row.sample_id_reformat}" }
  publishDir "${params.outdir}/bam", pattern: '*.bam', mode: 'copy', saveAs: { filename -> "${row.sample_id_reformat}.sorted.dedup.bam" }
  publishDir "${params.outdir}/bam", pattern: '*.bai', mode: 'copy', saveAs: { filename -> "${row.sample_id_reformat}.sorted.dedup.bai" }
  publishDir "${params.outdir}/qc/dedup", pattern: '*.log', mode: 'copy', saveAs: { filename -> "${row.sample_id_reformat}.sorted.dedup.log" }

label 'lg'

  input:
    tuple val( row ), \
        path( 'sorted_sam' )

	output:
	 tuple val( row ), \
         path( "${row.sampleId}.sorted.dedup.bam" ), emit: dedup_bam

	 tuple val( row ), \
         path( "${row.sampleId}.sorted.dedup.bam.bai" ), emit: dedup_bai

    tuple val( row ), \
         path( "${row.sampleId}.sorted.dedup.log" ), emit: dedup_log

    tuple val( row ), val( "${params.outdir}/bam/${row.sample_id}.sorted.dedup.bam") , emit: dedup_bam_path


  script:

  """ 

  module load SAMtools/1.10-foss-2018b

  gunzip -c ${row.read2} > index_reads.fq
  python /camp/home/castigc/working/ccastignani/projects/RRBS_preprocessing/DNAm_pipeline/bin/removeN6duplicates.py -i ${sorted_sam} -b index_reads.fq -o ${row.sampleId}.sorted.dedup.sam -l ${row.sampleId}.sorted.dedup.log    
  samtools view -bS ${row.sampleId}.sorted.dedup.sam > ${row.sampleId}.sorted.dedup.bam
  samtools index -b ${row.sampleId}.sorted.dedup.bam


  """

}
