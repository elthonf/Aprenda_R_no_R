# Você pode passar funções como argumentos para outras funções, assim como você
# pode passar dados para funções. Digamos que você defina as seguintes 3 funções:
# 
# add_two_numbers <- function(num1, num2){
#    num1 + num2
# }
# 
# multiply_two_numbers <- function(num1, num2){
# num1 * num2
# }
# 
# some_function <- function(func){
#    func(2, 4)
# }
# 
# Como você pode ver, usamos o parâmatro "func" como uma função dentro de
# "some_function()". Passando funções como argumentos, some_function(add_two_numbers)
# deve retornar 6, enquanto some_function(multiply_two_numbers) deve retornar 8.
# 
# Conclua a função "evaluate" abaixo para que, se a função receba
# como argumento uma função em "func" e alguns dados (como um vetor) em "dat".
# A função evaluate() deve retornar a execução da função "func" recebendo como
# parâmetros os valores de "dat".
# 
# 
# Dica: Esse exercício é mais complicado, então vou te dar alguns exemplos de
# como você faz para saber se a função evaluate() está certa:
#    1. evaluate(sum, c(2, 4, 6)) deve retornar 12
#    2. evaluate(median, c(7, 40, 9)) deve retornar 9
#    3. evaluate(floor, 11.1) deve retornar 11

evaluate <- function(func, dat){
  # Write your code here!
  # Remember: the last expression evaluated will be returned! 
}
