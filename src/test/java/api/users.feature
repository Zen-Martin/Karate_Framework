Feature: api test

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: obtenir tous les utilisateurs puis le premier à l'aide de son id
  # 1ère requête
    # on ajoute /users à l'url définit dans le background
    Given path 'users'
    # la méthode GET sera utilisée pour la requête
    When method get
    # le code de la réponse http attendue est 200
    Then status 200
    # la première requête sera donc un GET de url + '/users' où l'on attend un code 200 en réponse

    # la variable first représente la première réponse renvoyée par la requête ci-dessus
    # où response est une variable globale qui représente la réponse de la dernière requête envoyée
    * def first = response[0]
  # 2ème requête
    # on ajoute /users/first.id à l'url définit dans le background
    # où first.id représente l'id du 1er user renvoyé dans la réponse de la 1ère requête
    Given path 'users', first.id
    When method get
    Then status 200

  Scenario: créer un utilisateur
  	# création d'un objet JSON 'user' représentant un utilisateur
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """
  # 3ème requête
    # on peut aussi redéfinir la variable url comme ceci :
    Given url 'https://jsonplaceholder.typicode.com/users'
    # request permet d'ajouter au body de la requête une donnée, ici c'est l'objet JSON déclaré ci-dessus
    And request user
    # la méthode POST sera utilisée pour la requête
    When method post
    # le code de la réponse http attendue est 201
    Then status 201
    # print permet d'afficher dans la console
    * print 'id crée : ', response.id