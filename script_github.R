
#-------------------------------------------------------------------------------
# Se identificando para o para o github (via terminal):


# observações:
# 1) necessário instalar primeiro o pacote usethis!!!
# 2) trocar o nome e email de usuário!!!


# git config --global user.email "fndemarqui@gmail.com"
# git config --global user.name "fndemarqui"

# alternativamente, via R:
usethis::use_git_config(user.name = "fndemarqui",              # seu nome
                        user.email = "fndemarqui@gmail.com")   # seu email

#-------------------------------------------------------------------------------
# No terminal entrar com a linha de comando para lincar o projeto com o github:

# git remote add origin https://github.com/fndemarqui/meuprojeto.git
# git add .
# git status
# git commit -m "meu primeiro comentario"
# git push -u origin master



# # para adicionar tudo
# git add .
#
# # para comitar
# git commit -m "escreva seu comentário aqui"
#
# # para subir conteúdo:
# git push

# # para baixar conteúdo:
# git push
