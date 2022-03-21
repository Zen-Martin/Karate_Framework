Feature: api test connexion

  Background:
    * url 'https://reqres.in/api'

  Scenario: enregistrement d'un utilisateur
    Given path 'register'
    * def user =
    """
    {
      "email":  "eve.holt@reqres.in" ,
      "password":  "pistolet"
    }
    """
    And form fields user
    When method post
    Then status 200
    * def accessToken = response.token
    Then print accessToken