#!/usr/bin/env nextflow
nextflow.enable.dsl=2
/////////////////////////////////////////////////////////////////////////////
/* --                  TRACERx Single-cell DLP Pipeline                 -- */
/* --                       Authors: Mark S. Hill;                      -- */
/////////////////////////////////////////////////////////////////////////////
include { logo; helpMessage; outputSummary } from './lib/core_functions'
outputSummary()

///////////////////////////////////////////////////
/* --             RUN THE WORKFLOW            -- */
///////////////////////////////////////////////////
workflow {

include { DNAm_pipeline } from './workflows/DNAm_pipeline.nf'
DNAm_pipeline ()
  
}

////////////////////////////////////////////////////
/* --                  THE END                 -- */
////////////////////////////////////////////////////