# Turn off double evaluation to make things faster
AUTO_DETECT_NEWVAR <- FALSE

match_call <- function(correct_call = NULL) {
  e <- get("e", parent.frame())
  # Trivial case
  if(is.null(correct_call)) return(TRUE)
  # Get full correct call
  full_correct_call <- expand_call(correct_call)  
  # Expand user's expression
  expr <- deparse(e$expr)
  full_user_expr <- expand_call(expr)
  # Compare function calls with full arg names
  identical(full_correct_call, full_user_expr)
}

# Utility function for match_call answer test
# Fills out a function call with full argument names
expand_call <- function(call_string) {
  # Quote expression
  qcall <- parse(text=call_string)[[1]]
  # If expression is not greater than length 1...
  if(length(qcall) <= 1) return(qcall)
  # See if it's an assignment
  is_assign <- is(qcall, "<-")
  # If assignment, process righthandside
  if(is_assign) {
    # Get righthand side
    rhs <- qcall[[3]]
    # If righthand side is not a call, can't use match.fun()
    if(!is.call(rhs)) return(qcall)
    # Get function from function name
    fun <- match.fun(rhs[[1]])
    # match.call() does not support primitive functions
    if(is.primitive(fun)) return(qcall)
    # Get expanded call
    full_rhs <- match.call(fun, rhs)
    # Full call
    qcall[[3]] <- full_rhs
  } else { # If not assignment, process whole thing
    # Get function from function name
    fun <- match.fun(qcall[[1]])
    # match.call() does not support primitive functions
    if(is.primitive(fun)) return(qcall)
    # Full call
    qcall <- match.call(fun, qcall)
  } 
  # Return expanded function call
  qcall
}

# Get the swirl state
getState <- function(){
  # Whenever swirl is running, its callback is at the top of its call stack.
  # Swirl's state, named e, is stored in the environment of the callback.
  environment(sys.function(1))$e
}

# Get the value which a user either entered directly or was computed
# by the command he or she entered.
getVal <- function(){
  getState()$val
}

# Get the last expression which the user entered at the R console.
getExpr <- function(){
  getState()$expr
}

notify <- function() {
  e <- get("e", parent.frame())
  if(tolower(e$val) != "sim" && tolower(e$val) != "s" ) return(TRUE)
  
  # Get info
  info = list()
  
  info$class <- toupper( readline_clean("Qual o código da sua turma? (exemplo FIAP-01IA)") )
  repeat{
    info$user <- toupper( readline_clean("Qual seu código de aluno?") )
    if( !is.na(as.numeric(info$user)) ){
      break
    }
    message('O código deve ser numérico.')
  }
  info$username <- readline_clean("Qual seu nome?")
  info$comment <- readline_clean("O que achou deste exercício?")
  
  
  # Get course and lesson names
  info$course <- attr(e$les, "course_name")
  info$lesson <- attr(e$les, "lesson_name")
  
  sucesso = FALSE
  tentativas = 1
  url = 'https://us-central1-emf-teacher.cloudfunctions.net/function-save-test'
  while (!sucesso & tentativas <= 10) {
    print(paste0("Tentando submeter ao professor, tentativa ", tentativas, " ... (max 10) ..."))
    sucesso = tryCatch(
      {
        #Sendo through http
        response = httr::GET(url, query = info)
        
        print ( rawToChar(response$content)  )
        
        if(response$status_code != 200 ){
          message(paste( "Error code: ", response$status_code ) )
        }
        
        hrule()
        message("\nSeu resultado foi salvo!\n")
        hrule()
        return (TRUE)
      },
      error=function(cond){
        message("URL does not seem to exist.")
        message("Here's the original error message:")
        message(cond)
        # Choose a return value in case of error
        Sys.sleep(2)
        return(FALSE)
      },
      warning=function(cond){
        message("URL caused a warning.")
        message("Here's the original warning message:")
        message(cond)
        # Choose a return value in case of warning
        Sys.sleep(2)
        return(FALSE)
      }
    )

    tentativas = tentativas + 1
  }
  
  # Return TRUE to satisfy swirl and return to course menu
  return(sucesso)
}

readline_clean <- function(prompt = "") {
  wrapped <- strwrap(prompt, width = getOption("width") - 2)
  mes <- stringr::str_c("| ", wrapped, collapse = "\n")
  message(mes)
  readline()
}

hrule <- function() {
  message("\n", paste0(rep("#", getOption("width") - 2), collapse = ""), "\n")
}