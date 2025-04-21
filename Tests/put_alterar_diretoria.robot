*** Settings ***
Resource  ../Resource/geral.resource
Resource  ../Resource/alterar_diretoria.resource
Resource  ../Resource/login_ususario.resource
Resource  ../Resource/criar_diretoria.resource
    


*** Test Cases ***
CT03 - Alterar Diretoria
    Criar Sessão
    Entrar com Usuário Admnistrator
    Criar Diretoria
    Criar Nome Diretoria
    Alterar Diretoria
    Conferir Diretoria Alterada Com Sucesso
    Alterar Diretoria Com Nome em Branco
    Alterar Diretoria Com Nome com Números
    Alterar Diretoria Sem Token
    Alterar Diretoria Com Mais 50 Caracteres
    Alterar Diretoria Com Caracteres Especiais
    Alterar Diretoria Com Nome Já Cadastrado
    Alterar Diretoria Erro de Servidor    
