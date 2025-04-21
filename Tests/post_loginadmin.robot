*** Settings ***
Resource  ../Resource/geral.resource
Resource  ../Resource/login_ususario.resource



*** Test Cases ***
CT01 - Login com usuário administrador
    Criar Sessão
    Entrar com Usuário Admnistrator
    Validar o Token e Gravar em um Header Autorização
    