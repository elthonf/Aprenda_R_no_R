# So swirl does not repeat execution of plot commands
AUTO_DETECT_NEWVAR <- FALSE

# Returns TRUE if e$expr matches any of the expressions given
# (as characters) in the argument.
ANY_of_exprs <- function(...){
  e <- get("e", parent.frame())
  any(sapply(c(...), function(expr)omnitest(expr)))
}

equiv_val <- function(correctVal){
  e <- get("e", parent.frame()) 
  #print(paste("User val is ",e$val,"Correct ans is ",correctVal))
  isTRUE(all.equal(correctVal,e$val))
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