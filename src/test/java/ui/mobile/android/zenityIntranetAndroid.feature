Feature: Test de apps web et apps native

  Scenario: connexion à l'intranet sur la version mobile du site
    * configure driver = {type: 'android'}
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

  Scenario: android mobile native app test
    * configure driver = {type: 'android'}
    Given driver mobile.nativeCaps
    And driver.click('#com.bs.droidaction:id/showTextCheckBox')
    * driver.clear('#com.bs.droidaction:id/showTextOnDelay')
    And driver.input('#com.bs.droidaction:id/showTextOnDelay', "10000")
    And driver.input('#com.bs.droidaction:id/editTextBox', "KarateDSL")
    And driver.click('#com.bs.droidaction:id/showTextCheckBox')


