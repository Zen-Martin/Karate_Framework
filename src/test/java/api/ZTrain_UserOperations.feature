#This Feature Use Background for connection
#For before launch this you should comment karate callSingle in karate-config.js
Feature: Ztrain API Automation

  Background:
    * url 'https://ztrain-shop.herokuapp.com'
    * header Accept = 'application/json'
    Given path '/auth/login'
    And request {email: 'super@hero.com' , password:"123super"}
    And method POST
    And status 201
    * def userAccess = "Bearer " + response.token
    * def userId = response.user._id

  Scenario Outline: Create product
    * header Authorization = userAccess
    * def product =
    """
    {
      name: "#('Smartphone samsung galaxy S8+' +  Date.now())",
      description: "<description>",
      image: "<image>",
      price: <price>
    }
    """
    Given path '/product/create'
    And request product
    When method POST
    Then status 201
    And print response

    Examples:
      |description                                                                                                                                                                                                                              |image                                                                                        |price |
      |Le Samsung Galaxy Note10 Plus est un smartphone haut de gamme annoncé le 7 août 2019. Équipé du S Pen qui fait le succès de la gamme, il est équipé d'un écran AMOLED de 6,3 pouces et d'un triple capteur photo de 12+16+12 mégapixels  |https://www.frandroid.com/produits/samsung/smartphones/600933-samsung-galaxy-note-10-pro.png |300000 |

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

  Scenario Outline: Delete a product to cart
    * header Authorization = userAccess
    * def userCart = '/cart/delete/' + userId
    Given path userCart
    And request {product:"<product>"}
    When method DELETE
    And print response
    Then status 200

    Examples:
      |product                  |
      |6239d9865484ea8439e99f8e |

  Scenario: Delete all product to cart
    * header Authorization = userAccess
    * def userCart = '/cart/delete/' + userId
    Given path userCart
    When method DELETE
    And print response
    Then status 200

  Scenario: get cart
    * header Authorization = userAccess
    * def userCart = '/cart/' + userId
    Given path userCart
    * method get
    * print response
    Then status 200
