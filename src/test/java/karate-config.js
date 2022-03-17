function fn() {
  var env = karate.env;
  if (!env) {
    env = 'test';
  }
  var config = {
    web: {
      navigateur: {type: 'chrome'},
      zenityIntranetUrl: 'https://intranet-test.zenity-test.fr',
      identifiant: 'tgalarneau@zenity.fr',
      motdepasse: 'Motdepasse1',
      nom: 'Galarneau'
    },
    mobile: {
      driverCaps: {
        "platformName": "Android",
        "platformVersion": "9.0",
        "deviceName": "emulator-5554",
        "browserName": "Chrome",
        "connectHardwareKeyboard": true
      }
    }
  }
  if (env == 'prod') {
    config.web.zenityIntranetUrl = 'https://intranet.zenity.fr';
    config.web.identifiant = 'identifiant_prod';
    config.web.motdepasse = 'mdp_prod';
    config.web.nom = 'nom_prod';
  }
  karate.configure('report', { showLog: true, showAllSteps: false } );
  karate.log('environnement utilisé pour ce test :', env);
  return config;
};