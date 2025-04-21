*** Settings ***    
Library  RequestsLibrary
Library  Collections
Library  String


*** Variables ***
${Url}        https://black-list.qacoders.dev.br/api/
${email}      sysadmin@qacoders.com  
${password}   1234@Test

*** Keywords ***
Criar Sessão
    ${headers}   Create Dictionary      accept=application/json         Content-Type=application/json
    Create Session  alias=BlackList     url=${Url}     headers=${headers}

