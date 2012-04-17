\name{emCDF}
\alias{emCDF}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Function to plot the empirical cumulative density functions (ecdf)
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Plots the ecdf for different thresholding strategies as discussed in Forcheh et al. (2012).
}
\usage{
emCDF(iccResults, iccQuant = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{iccResults}{
%%     ~~Describe \code{iccResults} here~~
A list containing a number of components obtained from  applying the iccFun function. It contaning the ICCs to be used for plotting.
}
  \item{iccQuant}{
%%     ~~Describe \code{iccQuant} here~~
Refers to the number summary described in Forcheh et al. (2012). It can be a vector of quantiles or a single value. For example, iccQuant = 
 c(0,0.25,0.5,0.75,1) means that the ecdf be plotted for the minimum ICC, 0.25, 0.5, 0.75 for the 25, 50, and 75 quantiles 
 and the maximum ICC respectively, while iccQuant = 1 means that the ecdf be plotted only for one number summary of interest.
}
}
%%\details{
%%  ~~ If necessary, more details than the description above ~~
%%}
%%\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
%%}
\references{
%% ~put references to the literature/web site here ~
 Neuwirth, E. RColorBrewer: ColorBrewer palettes. R package   version 1.0-2., 2007.
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
exampleSummaryDatalog2 <- channel(exampleSummaryData, "G")
exampleSummaryDataNorm <- normaliseIllumina(exampleSummaryDatalog2, 
method = "quantile", transform = "none")
aaa<-na.omit(data.frame(I(rownames(exprs(exampleSummaryDataNorm))),
exprs(exampleSummaryDataNorm)))[200:300,]
ProbeID <- aaa[,1]
eSet <- na.omit(exprs(exampleSummaryDataNorm))[200:300,]
stddev <- na.omit(se.exprs(exampleSummaryDataNorm))[200:300,]
nSet <- na.omit(attributes(exampleSummaryDataNorm)$assayData$nObservations)[200:300,]
 seSet<-stddev/sqrt(nSet)
 iccResults<-iccFun(eSet,seSet,nSet,ProbeID =ProbeID ,iccQuant=c(0,0.25,0.5,1),
 diffIcc=TRUE,keepData=TRUE)
emCDF(iccResults, iccQuant= c(0,0.25,0.5,1))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ecdf }
\keyword{ Plot }% __ONLY ONE__ keyword per line
