*** Settings ***
Resource  ../Resource/geral.resource
Resource  ../Resource/criar_diretoria.resource
Resource  ../Resource/login_ususario.resource


*** Test Cases ***
CT02 - Criar Diretoria
    Criar Sessão
    Entrar com Usuário Admnistrator
    Criar Diretoria
    Cadastrar Nova Diretoria
    Conferir Nova Diretoria Foi Cadastrada Com Sucesso

