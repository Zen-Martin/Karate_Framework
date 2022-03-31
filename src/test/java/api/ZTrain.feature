#This Feature Use CallSingle for connection
Feature: Ztrain API Automation

  Background:
    * url 'https://ztrain-shop.herokuapp.com'
    * header Accept = 'application/json'

  @login
  Scenario Outline: Login user
    Given path '/auth/login'
    And request {email: "<email>" , password:"<password>"}
    When method POST
    Then status 201
    And print response

    Examples:
      |email          |password |
      |super@hero.com |123super |

  Scenario Outline: Create product
    * header Authorization = "Bearer " + authInfo.token
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
    * header Authorization = "Bearer " + authInfo.token
    Given path '/cart/add'
    And request {product:"<product>", user_id:'#(authInfo.user)', quantity:<quantity>}
    When method POST
    Then status 201

    Examples:
      |product                  |quantity |
      |624579738de76c3928917be3 |3        |

  Scenario Outline: Update quantity product to cart
    * header Authorization = "Bearer " + authInfo.token
    Given path '/cart/update'
    And request {product:"<product>", user_id:'#(authInfo.user)', quantity:<quantity>}
    When method PUT
    Then status 200

    Examples:
      |product                  |quantity |
      |624579738de76c3928917be3 |10       |

  Scenario Outline: Delete product to cart
    * header Authorization = "Bearer " + authInfo.token
    * def userCart = '/cart/delete/' + authInfo.user
    Given path userCart
    And request {product:"<product>"}
    When method DELETE
    And print response
    Then status 200

    Examples:
      |product                  |
      |624579738de76c3928917be3 |

  Scenario: Delete all product on cart
    * header Authorization = "Bearer " + authInfo.token
    * def userCart = '/cart/delete/' + authInfo.user
    Given path userCart
    When method DELETE
    And print response
    Then status 200

  Scenario: get cart
    * header Authorization = "Bearer " + authInfo.token
    * def userCart = '/cart/' + authInfo.user
    Given path userCart
    * method GET
    Then status 200
    And print response