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
    ...    name=Cristian Gushi
    ...    email=cgushi@qax.com.br
    ...    password=mudar123

    Remove User By Email        ${user}[email]

    Start Session
    Go To signup
    Register user    ${user}
    Register user    ${user}
    Notice should be        Oops! Já existe um cadastro com e-mail informado.