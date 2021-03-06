% Generated by roxygen2 (4.0.2): do not edit by hand
\name{arb_plots}
\alias{arb_plots}
\title{Visualize triangular arbitrage opportunities}
\usage{
arb_plots(rp)
}
\arguments{
\item{pt}{An object of the class `TriArbProfitTable` returned by 'profit_table' function}
}
\value{
Two plots, showing arbitrage opportunities for each of two possible roundtrips
}
\description{
This function plots a bar chart of arbitrage opportunities found in a currencies triple.
}
\examples{
data(AUDCAD, AUDCHF, CADCHF)
AUDCAD <- clean_quotes(AUDCAD)
AUDCHF <- clean_quotes(AUDCHF)
CADCHF <- clean_quotes(CADCHF)
x <- align_quotes(list(AUDCAD, AUDCHF, CADCHF))
pt <- profit_table(x, c("AUDCAD", "AUDCHF", "CADCHF"))
arb_plots(pt)
}
\seealso{
\code{\link{rate_prod}}
}

