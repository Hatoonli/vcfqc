#' Plot MappingQualityRankSumTest (MQRankSum)
#' @description
#' This is the u-based z-approximation from the Rank Sum Test for mapping qualities. It compares the mapping qualities of the reads supporting the reference allele and the alternate allele. A positive value means the mapping qualities of the reads supporting the alternate allele are higher than those supporting the reference allele; a negative value indicates the mapping qualities of the reference allele are higher than those supporting the alternate allele. A value close to zero is best and indicates little difference between the mapping qualities.
#' @param f VCF input file
#' @param n Threshold value (optional), default is the recommended GATK value.
#' @returns
#' A plot of MQRankSum score and frequency
#' with table summary
#' and number of variants falling outside the threshold
#' @export
#' @example
#' MQRankSum(system.file("extdata", "HG001_GRCh38.table", package = "vcfqc"))
MQRankSum <- function(f, n){
  vcf <- data.table::fread(f, fill=TRUE)
  if(sum(is.na(vcf$MQRankSum)) > 0) {
    message(sum(is.na(vcf$MQRankSum)), " variants are not annotated with MQRankSum score")
  } else {
    message("All variants are annotated with MQRankSum score")
  }
  cat("\n")
  print(summary(vcf$MQRankSum))
  plt <- ggplot2::ggplot(vcf, ggplot2::aes(MQRankSum)) + ggplot2::geom_density()
  if(missing(n)) {
    n <- -12.5
  } else {
    n
  }
  cat("\n", "Number of variants with a MQRankSum score lower than ", n, ": ", sum(vcf$MQRankSum < n, na.rm = TRUE), sep="", "\n")
  cat(crayon::bold("\nExpected plot:"), "\n__________________________________________________________")
  cat("\nThe values range from approximately -10.5 to 6.5. GATK hard filter threshold is -12.5.\n")
  return(plt)
}
