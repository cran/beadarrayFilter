\name{MLM.beadarray}
\alias{MLM.beadarray}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Multi-level Mixed model
%%  ~~function to do ... ~~
}
\description{
Function for differential expression analysis of bead array data using the Multi-level Mixed model of Kim and Lin (2011).
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
MLM.beadarray(sig, stderr, nbeads, groups, var.equal = FALSE, max.iteration = 20,
epsilon = 1e-06, method = "REML")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sig}{
  The summarized and normalized average intensities
%%     ~~Describe \code{sig} here~~
}
  \item{stderr}{
  The standard errors of the means
%%     ~~Describe \code{stderr} here~~
}
  \item{nbeads}{
  The number of beads used for summarization
%%     ~~Describe \code{nbeads} here~~
}
  \item{groups}{
  This refers to the groups to be compared. For filtering, group refers to the number of cloumns of sig. However, for the differential expression
  analysis, the user should define the group variable as appropriate for his/her data. 
%%     ~~Describe \code{groups} here~~
}
  \item{var.equal}{
  i.e assuming equal variance for the variance of the array random effects
%%     ~~Describe \code{var.equal} here~~
}
  \item{max.iteration}{
  The maximum number of iteration to perform
%%     ~~Describe \code{max.iteration} here~~
}
  \item{epsilon}{
  control limit for convergence
%%     ~~Describe \code{epsilon} here~~
}
  \item{method}{
  Allows one to choose between restricted maximum likelihood (REML) or maximum likelihood (ML) estimations
%%     ~~Describe \code{method} here~~
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
Kim, R.S. and Lin, J. (2011). Multi-level mixed effects models for bead
    arrays. Bioinformatics, 27(5):633-640.
%% ~put references to the literature/web site here ~
}
\author{
Ryung S. Kim and Juan Lin
%%  ~~who you are~~
}
%%\note{
%%  ~~further notes~~
%%Note that this function fits a random intercept model with one factor as a fixed effect
%%}
%%\note{
%%  ~~further notes~~
%%}
%% ~Make other sections like Warning with \section{Warning }{....} ~

%%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%%For more on the model formulation and use of this function, refer to 
%%Kim, R. and Lin, J. (2011). Multi-level mixed effects models for bead arrays. Bionformatics, vol. 27, number 5, pages: 633-640.
%%}
\examples{
require(beadarrayExampleData)
data(exampleSummaryData)
exampleSummaryDatalog2 <- channel(exampleSummaryData, "G")[1:40,]

exampleSummaryDataNorm <- normaliseIllumina(exampleSummaryDatalog2, 
method = "quantile", transform = "none")[1:40,]

    eSet <- na.omit(exprs(exampleSummaryDataNorm))[1:40,]
    
    seSet <- na.omit(se.exprs(exampleSummaryDataNorm))[1:40,]
    
    nSet <- na.omit(attributes(exampleSummaryDataNorm)$assayData$nObservations)[1:40,]
    
     stderrs<-seSet/sqrt(nSet)

##define group variable as appropriate for your data
group1 <- c(1:6)
group2 <- c(7:12)
 fit1 <- MLM.beadarray(eSet, stderrs, nSet, list(group1,group2), var.equal = TRUE,
 max.iteration = 20, method = "ML")
   
df<-length(group1)+length(group2)-2
fit1$pvalue<-2*(1-pt(abs(fit1$t.statistics),df))
fit1$PvalADjust<-p.adjust(fit1$pvalue, method ="fdr", n = length(fit1$pvalue))
length(which(fit1$PvalADjust<0.05)) 
%%hist(which(fit1$PvalADjust<0.05)) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ differential }
\keyword{ expression }% __ONLY ONE__ keyword per line
