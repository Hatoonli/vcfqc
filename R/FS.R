#' Plot FisherStrand (FS)
#' @description
#' This is the Phred-scaled probability that there is strand bias at the site. Strand Bias tells us whether the alternate allele was seen more or less often on the forward or reverse strand than the reference allele. When there little to no strand bias at the site, the FS value will be close to 0
#' @param f VCF input file
#' @param n Threshold value (optional), default is the recommended GATK value.
#' @export
#' @returns
#' A plot of QD score and frequency
#' with table summary
#' and number of variants falling outside the threshold
#' @example
#'  FS(system.file("extdata", "HG001_GRCh38.table", package = "vcfqc"))
FS <- function(f, n){
  vcf <- data.table::fread(f, fill=TRUE)
  if(sum(is.na(vcf$FS)) > 0) {
    message(sum(is.na(vcf$FS)), " variants are not annotated with FS score")
  } else {
    message("All variants are annotated with FS score")
  }
  cat("\n")
  print(summary(vcf$FS))
  plt <- ggplot2::ggplot(vcf, ggplot2::aes(FS)) + ggplot2::geom_density()
  if(missing(n)) {
    n <- 60
  } else {
    n
  }
  cat("\n", "Number of variants with an FS score higher than ", n, ": ", sum(vcf$FS > n, na.rm = TRUE), sep="", "\n")
  cat(crayon::bold("\nExpected plot:"), "\n__________________________________________________________")
  cat("\nThe FS values have a very wide range, most variants have an FS value less than 10, and almost all variants have an FS value less than 100. \nMost of the variants that fail have an FS value greater than 55. Our hard filtering recommendations tell us to fail variants with an FS value greater than 60.\n")
  return(plt)
}
