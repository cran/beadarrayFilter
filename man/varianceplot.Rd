\name{varianceplot}
\alias{varianceplot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Observe between-array and within-array variances.
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
plots the between array and the within array variances.
}
\usage{
varianceplot(iccResults, q = 1, delta = 0.5)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{iccResults}{
%%     ~~Describe \code{iccResults} here~~
Output from the iccFun function.
}
  \item{q}{
%%     ~~Describe \code{q} here~~
The quantile use  for ICC at which one wants to declare bead types informative. If iccQuant is a vector, then q can take any value from 1 up to the length of iccQuant.
}
  \item{delta}{
%%     ~~Describe \code{delta} here~~
The proposed cutoff point at which a bead type should be declared informative or non-informative.
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
%%\references{
%% ~put references to the literature/web site here ~
%%}
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
    varianceplot(iccResults,q=1,delta=0.8)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Variances }
\keyword{ Plot }% __ONLY ONE__ keyword per line
