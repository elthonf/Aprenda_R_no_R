# As reticências podem ser usadas para passar argumentos para outras funções
# que são usadas dentro da função que você está escrevendo. Normalmente, uma
# função que possui as reticência como argumento tem as reticências como o
# último argumento. Assim, o uso de uma função assim seria semelhante a:
# 
# ellipses_func(arg1, arg2 = TRUE, ...)
# 
# No exemplo acima, arg1 não possui valor padrão, portanto, um valor deve
# ser fornecido para arg1. arg2 tem um valor padrão, e outros argumentos
# podem vir depois de arg2.
# Curiosamente, o uso para a função paste é o seguinte:
# 
# paste(..., sep = " ", collapse = NULL)
# 
# Perceba que as reticências são o primeiro argumento nesta função e todos
# os outros argumentos após as reticências têm valores padrão. Esta é uma
# regra estrita na programação R: todos os argumentos depois das reticências
# devem ter valores padrão. Dê uma olhada na função simon_says abaixo:
# 
# simon_says <- function(...){
#   paste("Simon says:", ...)
# }
# 
# A função simon_says funciona exatamente como a função paste, exceto
# que o início de cada string é prefixado pela string "Simon says:"
# 
# Os telegramas costumavam ser demarcados com as palavras INICIAR e PARAR para
# demarcar o início e o fim das frases. Escreva uma função abaixo chamada
# telegram que formata frases para telegramas.
# Por exemplo, a expressão `telegram("Bom","dia")` deve retornar:
#   "START Bom dia STOP"


telegram <- function(...){
  #Coloque aqui o seu código
  #Lembre-se de que a saída deve seguir o padrão START ... STOP
}