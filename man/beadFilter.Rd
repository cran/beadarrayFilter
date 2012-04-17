\name{beadFilter}
\alias{beadFilter}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Filter Illumina bead arrays
%%  ~~function to do ... ~~
}
\description{
This is a wrapper function for the iccFun function and it implements the filtering method of Forcheh et al. (2012). 
It takes a normalized ExpressionSetIllumina object or a normalized data.frame and returns  the names of the informative bead types. 
Optionally, the filtered ExpressionSetIllumina object or the filtered data.frame can also be returned.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
beadFilter(beadsum, Quantile = 1, keepData = TRUE, delta = 0.5)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{beadsum}{
%%     ~~Describe \code{beadsum} here~~
A normalized data object, which can be an ExpressionSetIllumina or a normalized data.frame. 
}
  \item{Quantile}{
%%     ~~Describe \code{Quantile} here~~
It refers to the number summary described in Forcheh et al. (2012). It is the quantile at which summarization of the ICC is done. For example, iccQuant = 
 0 means that summarization of the ICCs be done at  the minimum ICC, 0.75 means summarization be done at the 75 quantile.  
 Note that filtering will also be done at this specified quantile. For example, iccQuant = 1 means that the ICCs be summarized only using 
 the maximum ICC and that beads be filtered using the maximum ICC.
}
  \item{keepData}{
%%     ~~Describe \code{keepData} here~~
If TRUE, then, the filtered object (i.e., filtered ExpressionSetIllumina object or filtered data.frame) and the identification names of the informative bead
types  are returned. If FALSE, only the  identification names of the informative bead types  will be returned.
}
  \item{delta}{
%%     ~~Describe \code{delta} here~~
The proposed cutoff point at which a bead type should be declared informative or non-informative. The default is 0.5.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
Bead filtering aims at removing non-informative bead types prior to the  downstream analysis.

This function is a wrapper of the iccFun function and it performs bead filtering. It takes a normalized ExpressionSetIllumina object 
or a normalized data.frame as input and so, the user should do 
the appropriate data normalization prior to submitting the ExpressionSetIllumina object  or data.frame  to the function. Refer to the ``beadarray" package documentation
for more on how to obtain a normalized ExpressionSetIllumina object. If a data.frame  is used, make sure that the column names are similarly to the ones from BeadStudio:
column names for bead averages should end with "Signal", standard errors should end with  "STDERR" and number of beads used for the data sumarization
should end with "NBEADS". 

%It takes  a normalized ExpressionSetIllumina object or a normalized data.frame and returns filtered data.
%%filtering model of Forcheh et al. (2012), derives the ICCs and declares the informative bead types by thresholding the ICC at a specified number summary
%%at the cutoff threshold, delta.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
\item{InformProbeNames}{Names of the Informative bead types}
\item{informData}{The filtered ExpressionSetIllumina object or filtered data.frame}
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
data(exampleSummaryData)
exampleSummaryDataNorm <- normaliseIllumina(channel(exampleSummaryData, "G"),
method = "quantile", transform = "none")
exampleSumDataNorm <- exampleSummaryDataNorm[200:300,]
iccResults<-beadFilter(exampleSumDataNorm ,Quantile=1,keepData=TRUE,delta=0.5)
head(iccResults$InformProbeNames)
%%head(fData(iccResults$informData))
dim(exprs(iccResults$informData)) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Filter }
\keyword{ Beads }% __ONLY ONE__ keyword per line
