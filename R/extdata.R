#' Dataset HG001_GRCh38
#'
#' A dataset containing GATK quality annotations for a VCF file
#' generated using GATK Germline short variant discovery pipeline on
#' HG001 reference sample from genome in a bottle project.
#' This dataset is used as an example to display this package's functions
#' @name extdata/HG001_GRCh38.table
#' @section HG001_GRCh38.table
#' @format A data frame with 4786095 rows and 12 variables:
#' \describe{
#'   \item{CHROM}{Chromosome}
#'   \item{POS}{Position}
#'   \item{REF}{Referenece}
#'   \item{ALT}{Alternative}
#'   \item{FILTER}{VQSR pass}
#'   \item{QUAL}{Quality}
#'   \item{QD}{QualByDepth}
#'   \item{FS}{FisherStrand}
#'   \item{SOR}{StrandOddsRatio}
#'   \item{MQ}{RMSMappingQuality}
#'   \item{MQRankSum}{MappingQualityRankSumTest}
#'   \item{ReadPosRankSum}{ReadPosRankSumTest}
#' }
#' @source \url{https://www.nist.gov/programs-projects/genome-bottle}
NULL
