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
  
  #Sendo through http
  response = httr::GET('https://us-central1-emf-teacher.cloudfunctions.net/function-save-test', 
            query = info)
  
  print ( rawToChar(response$content)  )

  hrule()
  message("\nSeu resultado foi salvo!\n")
  hrule()
  
  # Return TRUE to satisfy swirl and return to course menu
  TRUE
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