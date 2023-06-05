*** Settings ***
Documentation        Helpers

Library    libs/mongo.py

*** Keywords ***
Create nwe user
    [Arguments]        ${user}

    Remove User By Email    ${user}[email]
    Insert User             ${user}