#' Plot ReadPosRankSumTest (ReadPosRankSum)
#' @description
#' This is the u-based z-approximation from the Rank Sum Test for site position within reads. It compares whether the positions of the reference and alternate alleles are different within the reads. Seeing an allele only near the ends of reads is indicative of error, because that is where sequencers tend to make the most errors. A negative value indicates that the alternate allele is found at the ends of reads more often than the reference allele; a positive value indicates that the reference allele is found at the ends of reads more often than the alternate allele. A value close to zero is best because it indicates there is little difference between the positions of the reference and alternate alleles in the reads.
#' @param f VCF input file
#' @param n Threshold value (optional), default is the recommended GATK value.
#' @returns
#' A plot of ReadPosRankSum score and frequency
#' with table summary
#' and number of variants falling outside the threshold
#' @export
#' @example
#' ReadPosRankSum(system.file("extdata", "HG001_GRCh38.table", package = "vcfqc"))
ReadPosRankSum <- function(f, n){
  vcf <- data.table::fread(f, fill=TRUE)
  if(sum(is.na(vcf$ReadPosRankSum)) > 0) {
    message(sum(is.na(vcf$ReadPosRankSum)), " variants are not annotated with ReadPosRankSum score")
  } else {
    message("All variants are annotated with ReadPosRankSum score")
  }
  cat("\n")
  print(summary(vcf$ReadPosRankSum))
  plt <- ggplot2::ggplot(vcf, ggplot2::aes(ReadPosRankSum)) + ggplot2::geom_density()
  if(missing(n)) {
    n <- -8.0
  } else {
    n
  }
  cat("\n", "Number of variants with a ReadPosRankSum score lower than ", n, ": ", sum(vcf$ReadPosRankSum < n, na.rm = TRUE), sep="", "\n")
  cat(crayon::bold("\nExpected plot:"), "\n__________________________________________________________")
  cat("\nThe values for unfiltered variants fall mostly between -4 and 4. GATK hard filtering threshold removes any variant with a ReadPosRankSum value less than -8.0.\n")
  return(plt)
}
