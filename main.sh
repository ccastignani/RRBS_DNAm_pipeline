#!/usr/bin/env bash
ml Nextflow
ml Singularity
NXF_VER=20.12.0-edge nextflow run ./main.nf -profile crick -queue-size 500 -resume
