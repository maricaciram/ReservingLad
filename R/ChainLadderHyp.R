#' Verify chain ladder hypothes
#'
#' \code{ChainLadderHype} verifies that there is no inflation by ploting the residuals by calendar year.
#'
#' @param triangle Undevelopped triangle as a matrix
#' @param weight Boolean matrix with 1 row and 1 column less than the triangle to tell if the link ratio is to be considered: 1 for yes, 0 for no
#' @return a plot to confirm the hypothesis
#'
#' @import ggplot2
#' @import viridis
#'
#' @examples ChainLadderHyp(triangleExampleEngland)
#'
#' @export
ChainLadderHyp <- function(triangle, weight = NA){
  x <- y <- label <- devYear <- NULL

  # Validity checks for the triangle
  if(!(is.matrix(triangle) & is.numeric(triangle))){stop("The triangle is not a numeric matrix.")}
  if(nrow(triangle) != ncol(triangle)){stop("Number of rows different of number of columns in the triangle.")}
  n <- nrow(triangle)
  if(!all(!is.na(diag(triangle[n:1,])))){stop("Diagonal contains NA values.")}

  # Naming the columns
  if(is.null(rownames(triangle))){
    rownames(triangle) <- 1:nrow(triangle)
  }

  if(is.null(colnames(triangle))){
    colnames(triangle) <- 1:ncol(triangle)
  }


  # Application of Chain Ladder
  outputCL <- ChainLadder(triangle, weight = NA)

  # Construction of the table
  n <- ncol(triangle)
  dataPlot <- data.frame()
  for(i in 2:(n-1)){
    res <- (triangle[,i] - triangle[,i-1] * outputCL$lambda[i-1]) / sqrt(triangle[,i])
    temp <- data.frame(x = 1:n -1 + i, y = res / sqrt(mean(res^2, na.rm = TRUE)) , devYear = colnames(triangle)[i], label = rownames(triangle))
    dataPlot <- rbind(dataPlot, temp)
  }

  dataPlot <- dataPlot[!is.na(dataPlot$y),]

  # Plot of the table
  ggplot(data = dataPlot, aes(x = x, y = y)) +
    #geom_point() +
    #geom_line() +
    geom_smooth(color = rgb(99/255, 24/255, 66/255)) +
    geom_label(aes(label = label, group = devYear, color = devYear), size = 3)+
    theme_minimal()+
    scale_color_viridis(discrete = TRUE)+
    ylab("Residuals for calendar year \n (Labels correspond to accident year)")+
    xlab("Calendar Year")
}
