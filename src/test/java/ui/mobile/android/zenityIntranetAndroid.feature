Feature: Test de l'application web de l'intranet zenity sur l'environnement de test

  Scenario: connexion à l'intranet sur la version mobile du site
    * configure driver = {type: 'android', start: true}
    * def loginField = "//*[@resource-id='user_login']"
    * def passwordField = "//*[@resource-id='user_pass']"
    * def submitButton = "//*[@resource-id='wp-submit']"
    * def nameValue = "//*[@resource-id='prenomNomDeco']"

    Given driver mobile.driverCaps
    And driver web.zenityIntranetUrl
    * driver.waitUntil("document.readyState == 'complete'")
    And driver.input(loginField, web.identifiant, true)
    And driver.input(passwordField, web.motdepasse, true)
    When driver.click(submitButton)
    * driver.waitUntil("document.readyState == 'complete'")
    Then match driver.text(nameValue) contains web.nom


