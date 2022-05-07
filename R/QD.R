#' Plot Quality by Depth (QD)
#' @description
#' This is the variant confidence (from the QUAL field) divided by the unfiltered depth of non-hom-ref samples. This annotation is intended to normalize the variant quality in order to avoid inflation caused when there is deep coverage. For filtering purposes it is better to use QD than either QUAL or DP directly. The generic filtering recommendation for QD is to filter out variants with QD below 2.
#' @param f VCF input file
#' @param n Threshold value (optional), default is the recommended GATK value.
#' @returns
#' A plot of QD score and frequency
#' with table summary
#' and number of variants falling outside the threshold
#' @export
#' @example
#' QD(system.file("extdata", "HG001_GRCh38.table", package = "vcfqc"))
QD <- function(f, n) {
  vcf <- data.table::fread(f, fill=TRUE)
  if(sum(is.na(vcf$QD)) > 0) {
    message(sum(is.na(vcf$QD)), " variants are not annotated with QD score")
  } else {
    message("All variants are annotated with QD score")
  }
  cat("\n")
  print(summary(vcf$QD))
  plt <- ggplot2::ggplot(vcf, ggplot2::aes(QD)) + ggplot2::geom_density()
  if(missing(n)) {
    n <- 2
  } else {
    n
  }
  cat("\n", "Number of variants with a QD score lower than ", n, ": ", sum(vcf$QD < n, na.rm = TRUE), sep="", "\n")
  cat(crayon::bold("\nExpected plot:"), "\n__________________________________________________________")
  cat("\nThere are two peaks where the majority of variants are (around QD = 12 and QD = 32). \nThese two peaks correspond to variants that are mostly observed in heterozygous (het) versus mostly homozygous-variant (hom-var) states, respectively, in the called samples. \nThis is because hom-var samples contribute twice as many reads supporting the variant than do het variants. \nWe also see, to the left of the distribution, a 'shoulder' of variants with QD hovering between 0 and 5.\n", fill = 60)
  return(plt)
}
