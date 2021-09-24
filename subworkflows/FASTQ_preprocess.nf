////////////////////////////////////////////
/* --        Pre-alignment prep        -- */
///////////////////////////////////////////
include { TRIM_READS } from '../modules/read_trimming.nf'

workflow FASTQ_preprocess {

  take:
  inventory

  main:

  inventory_out = inventory.map { row -> if(!file(row.read1).exists()) { throw new Exception ("FASTQ not found ${row.read1}") };
                                  [row, file(row.read1) ] }


  inventory_out | TRIM_READS


  emit:
  trimmed_reads = TRIM_READS.out
                            .fq_trimmed
  trimming_report = TRIM_READS.out
                            .trimming_report
                            

}