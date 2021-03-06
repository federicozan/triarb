#' Visualize triangular arbitrage opportunities
#' 
#' This function plots a bar chart of arbitrage opportunities found in a currencies triple. 
#' @param pt An object of the class `TriArbProfitTable` returned by 'profit_table' function
#' @export
#'
#'
#'@seealso \code{\link{rate_prod}}
#' @return Two plots, showing arbitrage opportunities for each of two possible roundtrips
#' @examples
#' data(AUDCAD, AUDCHF, CADCHF)
#' AUDCAD <- clean_quotes(AUDCAD)
#' AUDCHF <- clean_quotes(AUDCHF)
#' CADCHF <- clean_quotes(CADCHF)
#' x <- align_quotes(list(AUDCAD, AUDCHF, CADCHF))
#' pt <- profit_table(x, c("AUDCAD", "AUDCHF", "CADCHF")) 
#' arb_plots(pt)
#' 
arb_plots <- function(rp) {
    par(mfrow=c(2, 2))
	pips_mult <- 10000L # multiplier to obtain pips from currency rate
    # add extra column, duration
    rp$duration <- c(diff(rp$timestamp), NA) * 1000
    # remove last row, because no duration is available for it
    rp <- rp[-nrow(rp), ]

	x_axis_lab <- "Arbitrage opportunities (sorted by magnitude)"
	y_axis_lab <- "Profit in pips"
    
	# arbitrage opportunities for the first roundtrip
    arb1 <- rp[rp[, 2] > 1, c(1, 2, 4)]
	names(arb1) <- c("timestamp", "profit", "duration")
	arb1$profit <- (arb1$profit - 1) * pips_mult

	# build plot title
	n <- nrow(arb1)
	roundtrip <- names(rp)[2]
	title <- (paste(n, " arbitrage opportunities in ", roundtrip, " roundtrip")) 
	
    barplot(sort(arb1$profit, decreasing=TRUE), xlab=x_axis_lab, ylab=y_axis_lab, main=title)
    plot(arb1$duration, arb1$profit, xlab="Duration in milliseconds", ylab="Profit in pips", main=title)
 
	# arbitrage opportunities for the second roundtrip
    arb2 <- rp[rp[, 3] > 1, c(1, 3, 4)]
	names(arb2) <- c("timestamp", "profit", "duration")
	arb2$profit <- (arb2$profit - 1) * pips_mult


	# build plot title
	n <- nrow(arb2)
	roundtrip <- names(rp)[3]
	title <- (paste(n, " arbitrage opportunities in ", roundtrip, " roundtrip")) 
	
    barplot(sort(arb2$profit, decreasing=TRUE), xlab=x_axis_lab, ylab=y_axis_lab, main=title)

    # arb opp vs duration
    plot(arb2$duration, arb2$profit, xlab="Duration in milliseconds", ylab="Profit in pips", main=title)
    
}
