#' Plot StrandOddsRAtio (SOR)
#' @description
#' This is another way to estimate strand bias using a test similar to the symmetric odds ratio test. SOR was created because FS tends to penalize variants that occur at the ends of exons. Reads at the ends of exons tend to only be covered by reads in one direction and FS gives those variants a bad score. SOR will take into account the ratios of reads that cover both alleles.
#' @param f file
#' @param n threshold
#' @export
#' @returns
#' A plot of SOR score and frequency
#' with table summary
#' and number of variants falling outside the threshold
#' @example
#' SOR(system.file("extdata", "HG001_GRCh38.table", package = "vcfqc"))
SOR <- function(f, n){
  vcf <- data.table::fread(f, fill=TRUE)
  if(sum(is.na(vcf$SOR)) > 0) {
    message(sum(is.na(vcf$SOR)), " variants are not annotated with SOR score")
  } else {
    message("All variants are annotated with SOR score")
  }
  cat("\n")
  print(summary(vcf$SOR))
  plt <- ggplot2::ggplot(vcf, ggplot2::aes(SOR)) + ggplot2::geom_density()
  if(missing(n)) {
    n <- 2
  } else {
    n
  }
  cat("\n", "Number of variants with an SOR score lower than ", n, ": ", sum(vcf$SOR < n, na.rm = TRUE), sep="", "\n")
  cat(crayon::bold("\nExpected plot:"), "\n__________________________________________________________")
  cat("\nThe SOR values range from 0 to greater than 9. Most variants have an SOR value less than 3, and almost all variants have an SOR value less than 9. However, there is a long tail of variants with a value greater than 9. \nGATK Hard filtering recommendation is to fail variants with an SOR value greater than 3.\n")
  return(plt)
}
