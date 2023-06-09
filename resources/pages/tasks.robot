*** Settings ***
Documentation        Página de gestão de tarefas

Library     Browser

*** Keywords ***
Go to task form
    Click        css=a[href$=create]

    Wait For Elements State
    ...            css=h1 >> text=Cadastrar Tarefa
    ...            visible        5

Create task
    [Arguments]        ${task}

    Fill Text        css=input[placeholder$=tarefa]        ${task}[name] 

    FOR  ${tag}  IN  @{task}[tags]
        Fill Text        css=input[name=tags]        ${tag}
        Keyboard Key     press        Enter
    END
    
    Click        css=button[type=submit] >> text=Cadastrar

Remove task
    [Arguments]        ${task_name}
    
    Click        xpath=//strong[text()="${task_name}"]/..//button[@class="task-remove"]

Complete task
    [Arguments]        ${task_name}
    
    Click        xpath=//strong[text()="${task_name}"]/..//button[@class="item-toggle"]

Task should be registered
    [Arguments]        ${task_name}

    Wait For Elements State
    ...            css=.task-item >> text=${task_name}
    ...            visible        5  

Task should not exist
    [Arguments]        ${task_name}

    Wait For Elements State
    ...            css=.task-item >> text=${task_name}
    ...            detached        5  

Task should be done
    [Arguments]        ${task_name}

    Wait For Elements State
    ...            css=.task-done >> text=${task_name}
    ...            visible        5  

Create tasks
    [Arguments]        @{tasks}

    FOR  ${task}  IN  @{tasks}
        Go to task form
        Create task                 ${task}
        Task should be registered        ${task}[name]
    END

Remove tasks
    [Arguments]        @{tasks}

    FOR  ${task}  IN  @{tasks}
        Remove task              ${task}[name]
        Task should not exist    ${task}[name]
    END

Complete tasks
    [Arguments]        @{tasks}

    FOR  ${task}  IN  @{tasks}
        Complete task              ${task}[name]
        Task should be done        ${task}[name]
    END