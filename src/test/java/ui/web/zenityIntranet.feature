Feature: Test de l'application web de l'intranet zenity sur l'environnement de test

  Scenario: connexion à l'intranet sur la version ordinateur du site
    * configure driver = web.navigateur
    * def loginField = "#user_login"
    * def passwordField = "#user_pass"
    * def submitButton = "#wp-submit"
    * def nameValue = "#prenomNomDeco"

    Given driver web.zenityIntranetUrl
    And driver.maximize()
    And driver.input(loginField, web.identifiant, true)
    And driver.input(passwordField, web.motdepasse, true)
    When driver.click(submitButton)
    And driver.waitUntil("document.readyState == 'complete'")
    Then match driver.text(nameValue) contains web.nom