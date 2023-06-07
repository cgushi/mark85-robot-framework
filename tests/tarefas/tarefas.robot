*** Settings ***
Documentation        Testes de cadastro de tarefas

Resource        ${EXECDIR}/resources/base.robot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    
    ${data}        Get fixture    tasks    create

    Create new user    ${data}[user]
    Login Session      ${data}[user]

    Create tasks       @{data}[tasks]

Deve remover uma tarefa indesejada
    [Tags]    remove

    ${data}        Get fixture    tasks     remove

    Create new user    ${data}[user]
    Login Session      ${data}[user]

    Create tasks       @{data}[tasks]
    
    Remove tasks       @{data}[tasks]

Deve poder marcar uma tarefa como concluída
    [Tags]    concluida

    ${data}        Get fixture    tasks        concluído


    Create new user    ${data}[user]
    Login Session      ${data}[user]

    Create tasks       @{data}[tasks]
    
    Complete tasks     @{data}[tasks]