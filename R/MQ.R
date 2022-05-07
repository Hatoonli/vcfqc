#' Plot Mapping Quality (MQ)
#' @description
#' This is the root mean square mapping quality over all the reads at the site. Instead of the average mapping quality of the site, this annotation gives the square root of the average of the squares of the mapping qualities at the site. It is meant to include the standard deviation of the mapping qualities. Including the standard deviation allows us to include the variation in the dataset. A low standard deviation means the values are all close to the mean, whereas a high standard deviation means the values are all far from the mean.When the mapping qualities are good at a site, the MQ will be around 60.
#' @param f VCF input file
#' @param n Threshold value (optional), default is the recommended GATK value.
#' @returns
#' A plot of MQ score and frequency
#' with table summary
#' and number of variants falling outside the threshold
#' @export
#' @example
#' MQ(system.file("extdata", "HG001_GRCh38.table", package = "vcfqc"))
MQ <- function(f, n){
  vcf <- data.table::fread(f, fill=TRUE)
  if(sum(is.na(vcf$MQ)) > 0) {
    message(sum(is.na(vcf$MQ)), " variants are not annotated with MQ score")
  } else {
    message("All variants are annotated with MQ score")
  }
  cat("\n")
  print(summary(vcf$MQ))
  plt <- ggplot2::ggplot(vcf, ggplot2::aes(MQ)) + ggplot2::geom_density()
  if(missing(n)) {
    n <- 40
  } else {
    n
  }
  cat("\n", "Number of variants with a MQ score lower than ", n, ": ", sum(vcf$MQ < n, na.rm = TRUE), sep="", "\n")
  cat(crayon::bold("\nExpected plot:"), "\n__________________________________________________________")
  cat("\nThe graph shows a very large peak around MQ = 60. GATK recommendation is to fail any variant with an MQ value less than 40.0.\n")
  return(plt)
}
