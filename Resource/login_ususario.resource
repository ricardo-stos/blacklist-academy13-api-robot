*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  String
Resource  ../Resource/geral.resource


*** Variables ***


*** Keywords ***
Entrar com Usuário Admnistrator
    ${body}   Create Dictionary    mail=${email}    password=${password}
    Log  ${body}
    Criar Sessão
    ${resposta}    POST On Session    alias=BlackList    url=login    json=${body}
    Log  ${resposta.json()}
    Set Test Variable    ${TOKEN}    ${resposta.json()["token"]}

Validar o Token e Gravar em um Header Autorização
    ${headers}   Create Dictionary     Authorization=${TOKEN}
    ${resposta}    GET On Session    alias=BlackList    url=validateToken   headers=${headers}
    Log  resposta da solicitação: ${resposta.content}
    Log   ${Token} 