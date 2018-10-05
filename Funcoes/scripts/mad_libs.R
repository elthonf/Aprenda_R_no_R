# Vamos explorar como "extrair" os argumentos das reticências. 
# Abaixo eu tenho uma função de exemplo que deve somar dois
# argumentos explicitamente nomeados chamados alpha e beta.
# 
# 
# add_alpha_and_beta <- function(...){
# 
#   # Primeiro, devemos capturar as reticências transformando-as em
#   # uma lista e, em seguida, atribuir a lista a uma variável.
#   # Vamos nomear esta variável como `args`.
#   
#   args <- list(...)
# 
#   # Agora vamos assumir que existem dois argumentos nomeados dentro
#   # de args com os nomes `alpha` e` beta`. Podemos extrair os
#   # argumentos nomeados da lista args usando o nome do argumento
#   # e os colchetes duplos. A variável the`args` é apenas uma lista normal!
#   
#   alpha <- args[["alpha"]]
#   beta  <- args[["beta"]]
# 
#   # Então, retornamos a soma de alpha e beta.
# 
#   alpha + beta
# }
# 
# Você já jogou Mad Libs antes? É aquele jogo das palavras que você
# Escreve mais de um texto e troca partes deste texto por palavras de
# mesma função sintática.
# A função abaixo irá construir uma frase a
# partir de partes do texto que você fornecer como argumentos. Já deixei escrita
# a maior parte da função, mas você precisará extrair os argumento
# apropriados das reticências.


mad_libs <- function(...){
  # Faça a extração dos argumentos aqui. São só 3, você consegue!
  
  # Não altere nenhum código abaixo deste comentário
  # Observe abaixo as variáveis que você precisará passar como
  # parâmetro para que o código abaixo seja funcional!
  paste("Novidades diretas do(a)", place, ". Hoje, cidadãos", adjective, "tomaram as ruas em protesto contra o novo", noun, "que foi instalado na cidade.")
}
