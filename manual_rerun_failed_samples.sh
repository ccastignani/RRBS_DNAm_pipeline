#!/bin/bash
#SBATCH -e /camp/project/proj-vanloo/analyses/ccastignani/DNAm_pipeline_scratch/c0/3b7a6e976d3d319a0166b92e2611bc/slurm-%A-%a.err
#SBATCH -o /camp/project/proj-vanloo/analyses/ccastignani/DNAm_pipeline_scratch/c0/3b7a6e976d3d319a0166b92e2611bc/slurm-%A-%a.out
#SBATCH --job-name=Bismark
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=150GB
#SBATCH --time=48:00:00

module load SAMtools/1.10-foss-2018b

work_dir="/camp/project/proj-vanloo/analyses/ccastignani/DNAm_pipeline_scratch/c0/3b7a6e976d3d319a0166b92e2611bc"
cd $work_dir
read_2="/camp/home/castigc/proj-swanton-vanloo/working/tracerx/merged_fastqs/M-LTX0028-DNA-N/M_LTX028_N_merged_R2_001.fastq.gz"
  
sorted_sam="/camp/project/proj-vanloo/analyses/ccastignani/DNAm_pipeline_scratch/c0/3b7a6e976d3d319a0166b92e2611bc/M_LTX028_N_merged_R1_001_bismark_sorted.sam"
sampleId="M_LTX028_N_merged_R1_001"
sample_id_reformat="M-LTX0028-DNA-SU-N"
#gunzip -c $read_2 > index_reads.fq
python /camp/home/castigc/working/ccastignani/projects/RRBS_preprocessing/DNAm_pipeline/bin/removeN6duplicates.py -i $sorted_sam -b index_reads.fq -o "$sampleId".sorted.dedup.sam -l "$sampleId".sorted.dedup.log    
samtools view -bS "$sampleId".sorted.dedup.sam > "$sampleId".sorted.dedup.bam
samtools index -b "$sampleId".sorted.dedup.bam

dedup_bam="$sampleId".sorted.dedup.bam
##meth excraction
methylation_extractor="/camp/home/castigc/working/ccastignani/bismark/bin/Bismark-0.23.0/bismark_methylation_extractor"
GENOMEFOLDER="/camp/home/castigc/working/ccastignani/bismark/hg19"

module load SAMtools/1.10-foss-2018b
$methylation_extractor $dedup_bam -s --no_overlap \
--gzip \
--bedGraph --buffer_size 90% \
--genome_folder $GENOMEFOLDER \
--parallel 12 

##manually move alignment report