process TRIM_READS {

 tag { "${row.sample_name}-${row.sample_id}" }
  publishDir "${params.outdir}/qc/trimming", pattern: "*_report.txt", mode: 'copy', saveAs: { filename -> "${row.sample_id}_trimming_report.txt" }


  label 'lg'

  input:
    tuple val( row ), \
          path( "read1" )

  output:
    tuple val( row ),\
     path ( "${row.sampleId}_trimmed_trimmed.fq" ), emit: fq_trimmed


    tuple val( row ),\
     path ( "${row.sampleId}.fastq.gz_trimming_report.txt" ), emit: trimming_report


 
    """
    ## trim only read 1
    echo ${row.sampleId}

    ${params.TRIMGALORE} --dont_gzip -a AGATCGGAAGAGC "${row.read1}" --path_to_cutadapt ~/.local/bin/cutadapt

    # trim diversity bases
    python /camp/home/castigc/working/ccastignani/projects/RRBS_preprocessing/DNAm_pipeline/bin/trimRRBSdiversityAdaptCustomers.py -1 "${row.sampleId}"_trimmed.fq

    """


}