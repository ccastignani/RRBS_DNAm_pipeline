@Grab('com.xlson.groovycsv:groovycsv:1.1')
import groovy.json.JsonOutput
import groovy.json.*
import static com.xlson.groovycsv.CsvParser.parseCsv

///////////////////////////////////////////////
/* --        INCLUDE SUBWORKFLOWS        -- */
//////////////////////////////////////////////
include { FASTQ_preprocess } from '../subworkflows/FASTQ_preprocess.nf'
include { BISMARK_alignment } from '../subworkflows/BISMARK_alignment.nf'
include { METH_extraction } from '../subworkflows/METH_extraction.nf'
include { ALIGNMENT_report } from '../subworkflows/ALIGNMENT_report.nf'

include { CAMDAC_run } from '../subworkflows/CAMDAC_run.nf' 

///////////////////////////////////////////////
/* --        PARSE INVENTORY        -- */
//////////////////////////////////////////////
input_file = file( "${params.input}" ).exists() ? "${params.input}" : params.input

KEYS = [ "sampleId", \
          "sample_id", \
          "read1", \
          "read2", \
          "patient_id", \
          "region_id", \
          "sex", \
          "mni", \
          "mno", \
          "tracerx_id", \
          "TRACERxID", \
          "PEACE", \
          "tx421" , \
          'region_complete' ]
inventory = Channel.fromPath( input_file, checkIfExists: true )
                   .ifEmpty { exit 1, "Input file not found" }
                   .splitCsv( header:true, sep: "," )
                   .map { it.subMap( KEYS ) }


/////////////////////////////////////////////
/* --         Run DNAm workflow        -- */
////////////////////////////////////////////

workflow DNAm_pipeline {

  FASTQ_preprocess( inventory )

  FASTQ_preprocess.out.trimmed_reads | BISMARK_alignment 
 
  BISMARK_alignment.out.dedup_bam | METH_extraction

  ALIGNMENT_report ( FASTQ_preprocess.out.trimming_report, \
                    BISMARK_alignment.out.alignment_report, \
                    BISMARK_alignment.out.dedup_log )

  BISMARK_alignment.out.dedup_bam_path.map{ row, dedup_bam_path ->
  def sampleId = row.sampleId
  def sample_id = row.sample_id
  def patient_id = row.patient_id
  def region_id = row.region_id
  def sex = row.sex
  def mni = row.mni
  def mno = row.mno
  def tracerx_id = row.tracerx_id
  def TRACERxID = row.TRACERxID
  def PEACE = row.PEACE
  def tx421 = row.tx421
  def region_complete = row.region_complete
  def bam_path = dedup_bam_path

  [sampleId, sample_id, patient_id, region_id,sex,mni,mno, tracerx_id, TRACERxID, PEACE, tx421, region_complete, bam_path]
  }.set{ new_channel }


  new_channel.collectFile( name:'sample.txt', storeDir:"${params.outdir}", {sampleId, sample_id, patient_id,region_id,sex,mni,mno,tracerx_id,TRACERxID,PEACE,tx421,region_complete, bam_path -> "$sampleId,$sample_id,$patient_id,$region_id,$sex,$mni,$mno,$tracerx_id,$TRACERxID,$PEACE,$tx421,$region_complete,$bam_path\n" })
  .set{ csv_file_ch }
  csv_file_ch.view()


  // summary- collect all output first, then run subworkflow
  // BISMARK_alignment.out.dedup_bam | CAMDAC_run

}