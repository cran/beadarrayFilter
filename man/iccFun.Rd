\name{iccFun}
\alias{iccFun}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Intra-cluster correlations (ICC)  for Illumina bead arrays
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Fits the filtering model of Forcheh et al. (2012) and derives the ICC that can be used for filtering.
Fitting is done using a modified version  of the ``MLM.beadarray" function of Kim and Lin (2011).
}
\usage{
iccFun(eSet, seSet, nSet, ProbeID, iccQuant, diffIcc = TRUE, keepData = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{eSet}{
%%     ~~Describe \code{eSet} here~~
The summarized and normalized average intensities
}
  \item{seSet}{
%%     ~~Describe \code{seSet} here~~
The standard errors of the average intensities
}
  \item{nSet}{
%%     ~~Describe \code{nSet} here~~
 The number of beads used for summarization
}
  \item{ProbeID}{
%%     ~~Describe \code{ProbeID} here~~
The bead types idenficiation variable e.g, ProbeID
}
  \item{iccQuant}{
%%     ~~Describe \code{iccQuant} here~~
It refers to the number summary described in Forcheh et al. (2012). It can be a vector of quantiles or a single value (scalar). For example, iccQuant = 
 c(0, 0.25 ,0.5, 0.75, 1) means that summarization of the ICCs be done at  the minimum ICC, 0.25, 0.5, 0.75 for the 25, 50, and 75 quantiles 
 and the maximum ICC respectively. iccQuant = 1 means that the ICCs be summarized only using the maximum ICC. 
}
  \item{diffIcc}{
%%     ~~Describe \code{diffIcc} here~~
If TRUE, then iccQuant must be a vector, if FALSE, iccQuant must be a single value. The default is TRUE.
}
  \item{keepData}{
%%     ~~Describe \code{keepData} here~~
If TRUE, then, the ICC at the number summary, the within array variances, the between array variances as well as all the ICCs 
will be returned. If FALSE, only the ICCs at the number summary will be returned.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
Bead filtering aims at removing non-informative bead types prior to the  downstream analysis.
This function  takes as input the summarized and normalized average intensities (eSet), their standard errors (seSet) and the number of beads used for summarization (nSet). It
fits the filtering model of Forcheh et al. (2012) and derives the ICCs. The obtained ICC can then be used for filtering bead types or to assess the filtering strategies.
 See examples for more on this.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
\item{icc}{The summarized ICCs at the number summary }
\item{withinvar }{The within array variances}
\item{betweenvar }{The between array variances}
\item{iccAll }{All the ICCs, i.e., one ICC per bead type per array}
}
\references{
%% ~put references to the literature/web site here ~

Dunning, M.J., Smith, M.L., Ritchie, M.E., Tavare, S. (2007). beadarray: R
  classes and methods for Illumina bead-based data, Bioinformatics.
  23(16):2183-2184.
  
  Dunning, M.J. (2011). beadarrayExampleData: Example data for the
  beadarray package. R package version 1.0.4.

 Forcheh, A.C,  Verbeke, G.,  Kasim, A.,  Lin, D.,  Shkedy, Z., Talloen, W.,  Gohlmann, H.W.H,  Clement, L. (2012).
Gene Filtering in the Analysis of Illumina Microarray Experiments,
Statistical Applications in Genetics and Molecular Biology, Berkeley Electronic Press, vol. 11(2), Article 3.

Kim, R.S. and Lin, J. (2011). Multi-level mixed effects models for bead
    arrays. Bioinformatics, 27(5):633-640.
}
\author{
%%  ~~who you are~~
Anyiawung Chiara Forcheh, Geert Verbeke, Adetayo Kasim, Dan Lin, Ziv Shkedy, Willem Talloen, Hinrich WH Gohlmann, Lieven Clement.
}
%%\note{
%%  ~~further notes~~
%%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%%}
\examples{
require(beadarrayExampleData)
data(exampleSummaryData)
exampleSummaryDatalog2 <- channel(exampleSummaryData, "G")[1:40,]
exampleSummaryDataNorm <- normaliseIllumina(exampleSummaryDatalog2, 
method = "quantile", transform = "none")[1:40,]
aaa<-na.omit(data.frame(I(rownames(exprs(exampleSummaryDataNorm))),exprs(exampleSummaryDataNorm)))[1:40,]
ProbeID <- aaa[,1][1:40]
    eSet <- na.omit(exprs(exampleSummaryDataNorm))[1:40,]
    stddev <- na.omit(se.exprs(exampleSummaryDataNorm))[1:40,]
    nSet <- na.omit(attributes(exampleSummaryDataNorm)$assayData$nObservations)[1:40,]
    seSet<-stddev/sqrt(nSet)
    iccResults<-iccFun(eSet,seSet,nSet,ProbeID =ProbeID ,iccQuant=1,
    diffIcc=FALSE,keepData=TRUE)
    %%str(iccResults)
    %%head(iccResults$icc)
    informProbeNames<- subset(iccResults$icc, iccResults$icc[,2]>=0.5)[,1]
filterDataNorm<-exampleSummaryDataNorm[informProbeNames,]
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%%\keyword{ ~kwd1 }
\keyword{ ICC }% __ONLY ONE__ keyword per line
