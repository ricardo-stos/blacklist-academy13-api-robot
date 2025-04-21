*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  String
Resource  ../Resource/geral.resource
Resource  ../Resource/login_ususario.resource

*** Variables ***


*** Keywords ***
Criar Diretoria
    ${palavra_randomica}    Generate Random String    8    [LETTERS]
    ${palavra_randomica}    Convert To Lower Case    ${palavra_randomica}
    Set Test Variable    ${DIRETORIA}    ${palavra_randomica}
    Log  ${DIRETORIA}

Cadastrar Nova Diretoria
    ${body}   Create Dictionary    boardName=${DIRETORIA}
    Log  ${body}
    Criar Sessão
    Entrar com Usuário Admnistrator 
    ${headers}   Create Dictionary     Authorization=${TOKEN}
    ${resposta}    POST On Session    alias=BlackList    url=board/    json=${body}    headers=${headers}    expected_status=201
    Log  ${resposta.json()}
    Set Test Variable    ${DIRETORIA_ID}    ${resposta.json()["newBoard"]["_id"]}
    Log  ${DIRETORIA_ID}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Conferir Nova Diretoria Foi Cadastrada Com Sucesso
   Log  ${RESPOSTA}
   Dictionary Should Contain Item    ${RESPOSTA}    msg   Cadastro realizado com sucesso!
   Dictionary Should Contain Key     ${RESPOSTA["newBoard"]}   _id
   Status Should Be    201    