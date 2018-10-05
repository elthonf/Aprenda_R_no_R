# A sintaxe para criar novos operadores binários no R é diferente de qualquer
# outra coisa que você deve ter visto no R. Isso permite que você defina uma
# nova sintaxe para sua função. Eu recomendaria apenas fazer seu próprio
# operador binário se você planeja usá-lo frequentemente!
#   
# 
# Os operadores binários definidos pelo usuário possuem a seguinte sintaxe:
#       %[whatever]%
# em que [whatever] representa qualquer nome válido de variável.
# 
# Digamos que eu quisesse criar um operador binário que multiplicasse dois
# números e, em seguida, adicionasse um ao produto. Uma implementação desse
# operador está abaixo:
# 
# "%mult_add_one%" <- function(left, right){ # PRESTE ATENÇÃO ÀS ASPAS
#   left * right + 1
# }
# 
# Eu poderia usar este operador assim: `4 %mult_add_one% 5` o que
# deveria resultar em 21.
# 
# 
# Como fizemos muitas coisas com string e com a função `paste`, vamos
# continuar nesta linha.
# Escreva seu próprio operador binário abaixo! Seu operador binário
# deve ser chamado %p% para que a expressão:
# 
#       "Bom" %p% "trabalho!"
# 
# resulte na string: "Bom trabalho!"

"%p%" <- function(left, right){
  
}



