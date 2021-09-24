process CAMDAC {
  conda '/camp/home/castigc/.conda/envs/RNA'
  tag { "${row.sample_id}" }
  label 'sm'

  input:
	tuple val( row ), \
         path( 'dedup_bam' )


	script:

  """
  Rscript ../../../bin/run_CAMDAC.R --bam_file ${dedup_bam} \
                                      --patient_id_dir ${row.tracerx_id} \
                                      --patient_id ${row.patient_id} \
                                      --sample_id ${row.region_complete} \
                                      --sex ${row.sex} \
                                      --normal_infiltrates_proxy_id ${row.mni} \
                                      --normal_origin_proxy_id ${row.mno} \
                                      --ref "hg19" \
                                      --path_to_CAMDAC '/camp/lab/vanloop/working/ccastignani/CAMDAC/CAMDAC-master' \
                                      --wdir ${params.outdir} \
                                      --nc '12'
                                    
  """
}
