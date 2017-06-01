
#' Set the dynamic prompt
#' 
#' @param fun whatever \code{\link[rlang]{as_function}} can turn into 
#'   a function with no parameters
#' 
#' @examples
#' set_prompt( ~"R> " )
#' set_prompt( ~paste( format(Sys.time(), "%H:%M:%S"), " > " ) )
#' 
#' # example using glue
#' set_prompt( ~ "{getwd()} >" )
#' 
#' @importFrom purrr walk2
#' @importFrom rlang as_function
#' @importFrom glue glue
#' @importFrom whoami username gh_username
#' @importFrom pryr mem_used
#' @importFrom utils capture.output
#' @importFrom memoise memoise
#' @export
set_prompt <- function( fun ){
  removeTaskCallback("prompt::prompt")
  invisible(addTaskCallback( function(expr, value, ok, visible){
    options( prompt = expand_prompt(fun) )
    TRUE
  }, name = "prompt::prompt" ))
}

#' @export
#' @name set_prompt
reset_prompt <- function(){
  options( prompt = "> " )
  invisible( removeTaskCallback("prompt::prompt") )
}


#' @export
#' @name set_prompt
expand_prompt <- function( fun ){
  f <- if( is.character(fun) ) {
    function() fun
  } else {
    as_function(fun)
  }
  glue(f())
}

.gh_username <- memoise(function(){
  gh_username(fallback = "")
})
.username <- memoise(function(){
  username(fallback = "" )
})
bindings <- list(
  t = ~format( Sys.time(), "%H:%M:%S" ), 
  v = ~paste(version$major, version$minor, sep="."), 
  V = ~paste0(version$major, ".", version$minor, "~", version[["svn rev"]]), 
  u = ~.username(), 
  g = ~.gh_username(), 
  m = ~capture.output(print(mem_used())), 
  w = ~getwd()
)
here <- environment()
walk2( names(bindings), bindings, ~makeActiveBinding(.x, as_function(.y), here ))
