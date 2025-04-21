*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  String
Resource  ../Resource/geral.resource
Resource  ../Resource/login_ususario.resource
Resource  ../Resource/criar_diretoria.resource

*** Variables ***
${DIRETORIA_ID}    67c5f9316d366102592b74a9


*** Keywords ***
Criar Nome Diretoria
    ${palavra_randomica}    Generate Random String    8    [LETTERS]
    ${palavra_randomica}    Convert To Lower Case    ${palavra_randomica}
    Set Test Variable    ${DIRETORIA1}    ${palavra_randomica}
    Log  ${DIRETORIA1}

Alterar Diretoria 
        
    ${body}      Create Dictionary        boardName=${DIRETORIA1}
    Log  ${body}
    Criar Sessão
    Entrar com Usuário Admnistrator
    ${headers}   Create Dictionary     Authorization=${TOKEN}
    ${resposta}    PUT On Session    alias=BlackList    url=board/${DIRETORIA_ID}    json=${body}    headers=${headers}    expected_status=200
    Log  ${resposta.json()}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}
    
Conferir Diretoria Alterada Com Sucesso
    Log  ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    msg   Cadastro atualizado com sucesso.
    Dictionary Should Contain Key     ${RESPOSTA["updatedBoard"]}   _id
    Status Should Be    200

Alterar Diretoria Com Nome em Branco
        
    ${body}      Create Dictionary        boardName=
    Log  ${body}
    Criar Sessão
    Entrar com Usuário Admnistrator
    ${headers}   Create Dictionary     Authorization=${TOKEN}
    ${resposta}    PUT On Session    alias=BlackList    url=board/${DIRETORIA_ID}    json=${body}    headers=${headers}    expected_status=400
    Log  ${resposta.json()}
    Should Be Equal As Strings        ${resposta.status_code}    400
    Should Be Equal As Strings        ${resposta.json()["error"]}    ["O campo 'diretoria' é obrigatório."]
   

Alterar Diretoria Com Nome com Números
        
    ${body}      Create Dictionary        boardName=1234
    Log  ${body}
    Criar Sessão
    Entrar com Usuário Admnistrator
    ${headers}   Create Dictionary     Authorization=${TOKEN}
    ${resposta}    PUT On Session    alias=BlackList    url=board/${DIRETORIA_ID}    json=${body}    headers=${headers}    expected_status=400
    Log  ${resposta.json()}
    Should Be Equal As Strings        ${resposta.status_code}    400
    Should Be Equal As Strings        ${resposta.json()["error"]}    ["O campo 'diretoria' só pode conter letras e o caractere especial '&'."]


Alterar Diretoria Sem Token
        
    ${body}      Create Dictionary        boardName=1234
    Log  ${body}
    Criar Sessão
    Entrar com Usuário Admnistrator
    ${headers}   Create Dictionary     Authorization=
    ${resposta}    PUT On Session    alias=BlackList    url=board/${DIRETORIA_ID}    json=${body}    headers=${headers}    expected_status=403
    Log  ${resposta.json()}
    Should Be Equal As Strings        ${resposta.status_code}    403
    Should Be Equal As Strings        ${resposta.json()["errors"]}    ['No token provided.']


Alterar Diretoria Com Mais 50 Caracteres
        
    ${body}      Create Dictionary        boardName=Aureliano Magnífico das Estrelas Brilhantes do Horizonte
    Log  ${body}
    Criar Sessão
    Entrar com Usuário Admnistrator
    ${headers}   Create Dictionary     Authorization=${TOKEN}
    ${resposta}    PUT On Session    alias=BlackList    url=board/${DIRETORIA_ID}    json=${body}    headers=${headers}    expected_status=400
    Log  ${resposta.json()}
    Should Be Equal As Strings        ${resposta.status_code}    400
    Should Be Equal As Strings        ${resposta.json()["error"]}    ["O campo 'diretoria' deve possuir no máximo 50 caracteres."]


Alterar Diretoria Com Caracteres Especiais
        
    ${body}      Create Dictionary        boardName=@@#@$%&%%@#*
    Log  ${body}
    Criar Sessão
    Entrar com Usuário Admnistrator
    ${headers}   Create Dictionary     Authorization=${TOKEN}
    ${resposta}    PUT On Session    alias=BlackList    url=board/${DIRETORIA_ID}    json=${body}    headers=${headers}    expected_status=400
    Log  ${resposta.json()}
    Should Be Equal As Strings        ${resposta.status_code}    400
    Should Be Equal As Strings        ${resposta.json()["error"]}    ["O campo 'diretoria' só pode conter letras e o caractere especial '&'."]


Alterar Diretoria Com Nome Já Cadastrado
        
    ${body}      Create Dictionary        boardName=Brasil
    Log  ${body}
    Criar Sessão
    Entrar com Usuário Admnistrator
    ${headers}   Create Dictionary     Authorization=${TOKEN}
    ${resposta}    PUT On Session    alias=BlackList    url=board/${DIRETORIA_ID}    json=${body}    headers=${headers}    expected_status=409
    Log  ${resposta.json()}
    Should Be Equal As Strings        ${resposta.status_code}    409
    Should Be Equal As Strings        ${resposta.json()["alert"]}    ['Não é possível salvar esse registro. Diretoria já cadastrada no sistema.']


Alterar Diretoria Erro de Servidor
        
    ${body}      Create Dictionary        boardName=DELLLLLLLL
    Log  ${body}
    Criar Sessão
    Entrar com Usuário Admnistrator
    ${headers}   Create Dictionary     Authorization=${TOKEN}
    ${resposta}    PUT On Session    alias=BlackList    url=board/67c5fd8d6d366102592b74e     json=${body}    headers=${headers}    expected_status=500
    Log  ${resposta.json()}
    Should Be Equal As Strings        ${resposta.status_code}   500 
    Should Be Equal As Strings          ${resposta.json()["error"]}                                           CastError: Cast to ObjectId failed for value \"67c5fd8d6d366102592b74e\" (type string) at path \"_id\" for model \"Board\"