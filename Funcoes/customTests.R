test_func1 <- function() {
  try({
    func <- get('boring_function', globalenv())
    t1 <- identical(func(9), 9)
    t2 <- identical(func(4), 4)
    t3 <- identical(func(0), 0)
    ok <- all(t1, t2, t3)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_func2 <- function() {
  try({
    func <- get('my_mean', globalenv())
    t1 <- identical(func(9), mean(9))
    t2 <- identical(func(1:10), mean(1:10))
    t3 <- identical(func(c(-5, -2, 4, 10)), mean(c(-5, -2, 4, 10)))
    ok <- all(t1, t2, t3)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_func3 <- function() {
  try({
    func <- get('remainder', globalenv())
    t1 <- identical(func(9, 4), 9 %% 4)
    t2 <- identical(func(divisor = 5, num = 2), 2 %% 5)
    t3 <- identical(func(5), 5 %% 2)
    ok <- all(t1, t2, t3)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_func4 <- function() {
  try({
    func <- get('evaluate', globalenv())
    t1 <- identical(func(sum, c(2, 4, 7)), 13)
    t2 <- identical(func(median, c(9, 200, 100)), 100)
    t3 <- identical(func(floor, 12.1), 12)
    ok <- all(t1, t2, t3)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_func5 <- function() {
  try({
    func <- get('telegram', globalenv())
    t1 <- identical(func("Good", "morning"), "START Good morning STOP")
    t2 <- identical(func("hello", "there", "sir"), "START hello there sir STOP")
    t3 <- identical(func(), "START STOP")
    ok <- all(t1, t2, t3)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_func6 <- function() {
  try({
    func <- get('mad_libs', globalenv())
    t1 <- identical(func(place = "Baltimore", adjective = "smelly", noun = "Roger Peng statue"), "Novidades diretas de Baltimore . Hoje, pessoas smelly tomaram as ruas em protesto contra o(a) novo(a) Roger Peng statue que foi instalado(a) na cidade.")
    t2 <- identical(func(place = "Washington", adjective = "angry", noun = "Shake Shack"), "Novidades diretas de Washington . Hoje, pessoas angry tomaram as ruas em protesto contra o(a) novo(a) Shake Shack que foi instalado(a) na cidade.")
    #print(func(place = "Baltimore", adjective = "smelly", noun = "Roger Peng statue"))
    #print(func(place = "Washington", adjective = "angry", noun = "Shake Shack"))
    #print(paste("t1:", t1))
    #print(paste("t2:", t2))
    ok <- all(t1, t2)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_func7 <- function() {
  try({
    func <- get('%p%', globalenv())
    t1 <- identical(func("Good", "job!"), "Good job!")
    t2 <- identical(func("one", func("two", "three")), "one two three")
    ok <- all(t1, t2)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_eval1 <- function(){
  try({
    e <- get("e", parent.frame())
    expr <- e$expr
    t1 <- identical(expr[[3]], 6)
    expr[[3]] <- 7
    t2 <- identical(eval(expr), 8)
    ok <- all(t1, t2)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_eval2 <- function(){
  try({
    e <- get("e", parent.frame())
    expr <- e$expr
    t1 <- identical(expr[[3]], quote(c(8, 4, 0)))
    t2 <- identical(expr[[1]], quote(evaluate))
    expr[[3]] <- c(5, 6)
    t3 <- identical(eval(expr), 5)
    ok <- all(t1, t2, t3)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_eval3 <- function(){
  try({
    e <- get("e", parent.frame())
    expr <- e$expr
    t1 <- identical(expr[[3]], quote(c(8, 4, 0)))
    t2 <- identical(expr[[1]], quote(evaluate))
    expr[[3]] <- c(5, 6)
    t3 <- identical(eval(expr), 6)
    ok <- all(t1, t2, t3)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
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
  while (!sucesso & tentativas <= 5) {
    print(paste0("Tentando submeter ao professor, tentativa ", tentativas, " ... (max 5) ..."))
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
  
  if(!sucesso){
    j = jsonlite::toJSON(info, auto_unbox = T)
    j.s = as.character(j)
    j.serial = charToRaw(j.s)
    j.64 = openssl::base64_encode(j.serial)
    url_full = paste0( "https://us-central1-emf-teacher.cloudfunctions.net/function-save-testb64?all=", j.64)
    warning("Não foi possível enviar o andamento da sua atividade diretamente pelo R. Uma janela será aberta para salvar seu andamento com a seguinte URL:")
    warning(url_full)
    warning("Você pode fechar a janela do seu navegador após mensagem de sucesso.")
    browseURL(url_full)
    sucesso = TRUE
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