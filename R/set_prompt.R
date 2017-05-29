
#' Set the dynamic prompt
#' 
#' @param fun whatever \code{\link[rlang]{as_function}} can turn into a function with no parameters
#' 
#' @examples
#' set_prompt( ~"R> " )
#' set_prompt( ~paste( format(Sys.time(), "%H:%M:%S"), " > " ) )
#' 
#' @importFrom rlang as_function
#' @export
set_prompt <- function( fun ){
  fun <- as_function(fun)
  invisible(addTaskCallback( function(expr, value, ok, visible){
    options( prompt = fun() )
    TRUE
  }, name = "prompt::prompt" ))
}

#' @export
#' @name set_prompt
reset_prompt <- function(){
  options( prompt = "> " )
  invisible( removeTaskCallback("prompt::prompt") )
}