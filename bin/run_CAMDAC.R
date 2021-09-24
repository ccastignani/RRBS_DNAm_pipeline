### run CAMDAC 27/8/21 ... Integrated within Nextflow pipeline

x <- c("optparse","stringr","GenomicRanges","Rsamtools","ASCAT","scales","ggplot2","gridExtra","data.table","readr","stringr", "fst","dplyr","parallel","doParallel")
# library(pryr) # only needed if mem_used() is used to determine object RAM.
invisible(lapply(x, function(y) suppressWarnings(suppressMessages(library(y, character.only = TRUE,quietly=TRUE,warn.conflicts = FALSE)))))
rm(x)

# parse options
option_list = list(
  make_option(c("--bam_file"), type="character", default=NULL,
              help="Character string with full bam file name and path. \n
                    [example : -bam =\'/home/user/project_id/patient_id/bams/bam_file_sample1.bam\'] \n
                    Bam file must be sorted and indexed. \n
                    Index file must have the same file name and path with added .bai extension."),
  make_option(c("--patient_id"), type="character", default=NULL,
              help="Character string with patient id. [example : -patient_id = \'PX1\']"),
  make_option(c("--patient_id_dir"), type="character", default=NULL,
              help="Character string with patient id. [example : -patient_id = \'PX1\']"),
  make_option(c("--sample_id"), type="character", default=NULL,
              help="Character string with sample id. This must be filled in for both multi-region and single sample datasets. [example : -sample_id = \'T1\']"),
  make_option(c("--sex"), type="character", default="XY",
              help="Sex of the patient expressed as \'XX\' for female or \'XY\' for male [default  \"%default\"]."),
  make_option(c("--normal_infiltrates_proxy_id"), type="character", default=NULL,
              help="Input the patient-matched tumour-adjacent sample id as a string."),
  make_option(c("--normal_origin_proxy_id"), type="character", default=NULL,
              help="Input tissue-matched control sample id as a string for differential methylation analysis."),
  make_option(c("--ref"), type="character", default=NULL,
              help="Reference genome build. Either \'hg19\', \'GRCH37\',  \'hg38\' or  \'GRCH38\'. \n
                    The reference build MUST be one of these four options, but you may set build = NULL \n
                    if you are unsure which of these 4 builds your data is aligned to and let CAMDAC will detect the build for you."),
  make_option(c("--path_to_CAMDAC"), type="character", default=NULL,
              help="Character string containting the path to the CAMDAC library \n
                  [example : -ptc =\'/home/user/libs/CAMDAC/\']"),
  make_option(c("--wdir"), type="character", default="./",
              help="Path to to working directory [example : -wd =\'/home/user/project_id/\']"),
  make_option(c("--nc"), type="integer", default=1,
              help="Number of cores for parrallel processing [default %default].\n
                    We recommend running on 8-12 cores.")
); opt = parse_args(OptionParser(option_list=option_list))



# Store variables
patient_id = ifelse(is.null(opt$patient_id), error("You must input a patient id"), opt$patient_id)
patient_id_dir = ifelse(is.null(opt$patient_id_dir), error("You must input a patient id"), opt$patient_id_dir)
sample_id = ifelse(is.null(opt$sample_id), error("You must input a sample id"), opt$sample_id)
sex = ifelse(is.null(opt$sex) , error(paste("You must input sex as \'XX\' for females or",
                                            "\'XY\' for males.", sep= " ")), opt$sex)
build = ifelse(is.null(opt$ref), error("You must input either \'hg19\', \'GRCH37\',  \'hg38\' or  \'GRCH38\'"),
               opt$ref)
path_to_CAMDAC=ifelse(is.null(opt$path_to_CAMDAC), error(paste("You must input the path to the CAMDAC library such as",
                                                               "\'/home/user/libraries/CAMDAC/\'", sep=" ")), opt$path_to_CAMDAC)
path = ifelse(is.null(opt$wdir),  warning(paste("You must input a path to the working directory where the tumour and",
                                                "control sample outputs will be stored such as",
                                                "\'/home/user/project_id/CAMDAC_results/\'", sep="\n")), opt$wdir)
# path/to/patient/dir (example: $HOME/project_id/)
n_cores = as.numeric(opt$nc)

# Process normal sample flags 
normal_infiltrates_proxy_id = ifelse(is.null(opt$normal_infiltrates_proxy_id), 
                                     error("You must provide a proxy for the normal tumour-infiltrating cells."), 
                                     opt$normal_infiltrates_proxy_id)
normal_origin_proxy_id = ifelse(is.null(opt$normal_origin_proxy_id) , 
                                error("You must provide a proxy for the normal cell of origin."), 
                                opt$normal_origin_proxy_id)


print(paste(patient_id,sample_id,sex,build,path_to_CAMDAC, path,normal_infiltrates_proxy_id, normal_origin_proxy_id))


source(paste0(path_to_CAMDAC,"/R/format_output.R"))
source(paste0(path_to_CAMDAC,"/R/get_differential_methylation.R"))
source(paste0(path_to_CAMDAC,"/R/get_allele_counts.R"))
source(paste0(path_to_CAMDAC,"/R/get_pure_tumour_methylation.R"))
source(paste0(path_to_CAMDAC,"/R/run_ASCAT.m.R"))
source(paste0(path_to_CAMDAC,"/R/run_methylation_data_processing.R"))



# # Set additional internal normal flags
# is_normal = ifelse(sample_id %in% c(normal_infiltrates_proxy_id, normal_origin_proxy_id, patient_matched_normal_id), TRUE, FALSE)
# is_patient_matched_normal = ifelse(sample_id == patient_matched_normal_id, TRUE, FALSE)
# 
# # Check that control sample has been run already
# f_control1 <- file.path(path, patient_id, "Allelecounts", normal_infiltrates_proxy_id, paste(patient_id, normal_infiltrates_proxy_id,
#                                                                                              "SNPs.CpGs.all.sorted.RData", sep="."))
# f_control2 <- file.path(path, patient_id, "Allelecounts", normal_origin_proxy_id, paste(patient_id,  normal_origin_proxy_id,
#                                                                                         "SNPs.CpGs.all.sorted.RData", sep="."))
# if(is_normal == FALSE & (!file.exists(f_control1) | !file.exists(f_control2))) {
#   stop(paste0("You must run CAMDAC on your normal sample(s) first.",
#               "Do not change output directory structure and file names."))
# }
# rm(f_control1, f_control2)
