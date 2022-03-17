Feature: api test

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: obtenir tous les utilisateurs puis le premier à l'aide de son id (fail test)
    Given path 'users'
    When method get
    # Status attendu 200 mais on veut un test fail pour les rapports
    Then status 500