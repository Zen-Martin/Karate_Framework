Feature: Ztrain API Automation

  Background:
    * url 'https://ztrain-shop.herokuapp.com'
    * header Accept = 'application/json'
    Given path '/auth/login'
    And request {email: 'super@hero.com' , password:"123super"}
    When method POST
    And status 201
    * def userAccess = "Bearer"+" "+response.token
    * def userId = response.user._id

  Scenario Outline: Create product
    * header Authorization = userAccess
    Given path '/product/create'
    And request {name:"<name>", description:"<description>", image:"<image>", price:<price>}
    When method POST
    Then status 201

    Examples:
      |name                        |description                                                                                                                                                                                                                              |image                                                                                        |price |
      |Samsung Galaxy Note 18 Plus |Le Samsung Galaxy Note10 Plus est un smartphone haut de gamme annoncé le 7 août 2019. Équipé du S Pen qui fait le succès de la gamme, il est équipé d'un écran AMOLED de 6,3 pouces et d'un triple capteur photo de 12+16+12 mégapixels  |https://www.frandroid.com/produits/samsung/smartphones/600933-samsung-galaxy-note-10-pro.png |30000 |

  Scenario Outline: Add product to cart
    * header Authorization = userAccess
    Given path '/cart/add'
    And request {product:"<product>", user_id:'#(userId)', quantity:<quantity>}
    When method POST
    Then status 201

     Examples:
      |product                  |quantity |
      |6239d9865484ea8439e99f8e |3        |

  Scenario Outline: Update quantity product to cart
    * header Authorization = userAccess
    Given path '/cart/update'
    And request {product:"<product>", user_id:'#(userId)', quantity:<quantity>}
    When method PUT
    Then status 200

    Examples:
      |product                  |quantity |
      |6239d9865484ea8439e99f8e |10       |

  Scenario Outline: Delete product to cart
    * header Authorization = userAccess
    Given path '/cart/delete'
    And request {product:"<product>", user_id:'#(userId)', quantity:<quantity>}
    When method DELETE
    And print response
    Then status 200

    Examples:
      |product                  |quantity |
      |6239d9865484ea8439e99f8e |5        |

  Scenario: get cart
    * header Authorization = userAccess
    Given path 'cart', '#(userId)'
    * method get
    * print response
    Then status 200
