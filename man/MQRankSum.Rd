% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MQRankSum.R
\name{MQRankSum}
\alias{MQRankSum}
\title{Plot MappingQualityRankSumTest (MQRankSum)}
\usage{
MQRankSum(f, n)
}
\arguments{
\item{f}{VCF input file}

\item{n}{Threshold value (optional), default is the recommended GATK value.}
}
\value{
A plot of MQRankSum score and frequency
with table summary
and number of variants falling outside the threshold
}
\description{
This is the u-based z-approximation from the Rank Sum Test for mapping qualities. It compares the mapping qualities of the reads supporting the reference allele and the alternate allele. A positive value means the mapping qualities of the reads supporting the alternate allele are higher than those supporting the reference allele; a negative value indicates the mapping qualities of the reference allele are higher than those supporting the alternate allele. A value close to zero is best and indicates little difference between the mapping qualities.
}
