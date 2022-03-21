Feature: api test

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: obtenir tous les utilisateurs puis le premier à l'aide de son id (fail test)
    Given path 'users'
    When method get
    Then status 500