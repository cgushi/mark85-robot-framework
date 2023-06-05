*** Settings ***

Resource       ${EXECDIR}/resources/base.robot

*** Test Cases ***
Deve cadastrar um novo usuário

    &{user}        Create Dictionary
    ...    name=Cristian Gushi
    ...    email=cgushi@qax.com.br
    ...    password=mudar123

    Remove User By Email        ${user}[email]

    Start Session
    Go To signup
    Register user    ${user}
    Notice should be        Boas vindas ao Mark85, o seu gerenciador de tarefas.


Usuário duplicado
    [Tags]    dup

    &{user}        Create Dictionary
    ...    name=Steve Jobs
    ...    email=steve@qax.com.br
    ...    password=mudar123

    Create nwe user         ${user}

    Start Session
    Go To signup
    Register user           ${user}
    Notice should be        Oops! Já existe um cadastro com e-mail informado.

Nome deve ser obrigatório
    [Tags]    inv_name
    &{user}        Create Dictionary
    ...    name=${EMPTY}
    ...    email=steve@qax.com.br
    ...    password=mudar123

    Remove User By Email        ${user}[email]

    Start Session
    Go To signup
    Register user    ${user}
    Alert should be    Informe seu nome completo

Email deve ser obrigatório
    [Tags]    inv_email
    &{user}        Create Dictionary
    ...    name=Steve Jobs
    ...    email=${EMPTY}
    ...    password=mudar123

    Remove User By Email        ${user}[email]

    Start Session
    Go To signup
    Register user    ${user}
    Alert should be    Informe seu e-email

Senha deve ser obrigatória
    [Tags]    inv_password
    &{user}        Create Dictionary
    ...    name=Steve Jobs
    ...    email=steve@qax.com.br
    ...    password=${EMPTY}

    Remove User By Email        ${user}[email]

    Start Session
    Go To signup
    Register user    ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos
