Feature: Ztrain API Automation

  Background:
    * url 'https://ztrain-shop.herokuapp.com'
    * header Accept = 'application/json'

  Scenario Outline: Register user
    Given path '/user/register'
    And request {email:"<email>", password:"<password>", adress:"<adress>", age:<age>}
    When method POST
    Then print response
    And status 201

    Examples:
      |email          |password |adress        |age |
      |super@hero.com |123super |Douala-logpom | 20 |


  Scenario Outline: Login user
    * def expectedUser = read('user.json')
    * def myUser = expectedUser.user.email
    * def myToken = expectedUser.token
    * header Authorization = "Bearer"+" "+myToken
    Given path '/auth/login'
    And request {email: '#(myUser)' , password:"<password>"}
    When method POST
    Then print response
    And status 201
    Examples:
      |password |
      |123super |


  Scenario Outline: Create product
    * def expectedUser = read('user.json')
    * def myToken = expectedUser.token
    * header Authorization = "Bearer"+" "+myToken
    Given path '/product/create'
    And request {name:"<name>", description:"<description>", image:"<image>", price:<price>}
    When method POST
    Then status 201

    Examples:
      |name      |description                                                                        |image                                                                                                                            |price  |
      |Iphone 13 |le modèle standard de la 15ème génération de smartphones commercialisés par Apple  |https://c1.lestechnophiles.com/images.frandroid.com/wp-content/uploads/2021/09/apple-iphone-13-pro-frandroid-2021.png?resize=580 |700000 |
