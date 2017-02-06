#' A Cat Function
#'
#' This function allows you to express your love of cats.
#' @param love Do you love cats? Defaults to TRUE.
#' @keywords cats
#' @export
#' @examples
#' func2()
 
func2 <- function(love=TRUE){
    if(love==TRUE){
        print("I love cats!")
    }
    else {
        print("I am not a cool person.")
    }
}
