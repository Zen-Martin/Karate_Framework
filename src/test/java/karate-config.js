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
        "connectHardwareKeyboard": true,
        "newCommandTimeout" : 500,
        "browserName": "Chrome"
      },
      nativeCaps: {
        "app" : "C:\\Users\\Pawk73\\Documents\\Karate-Auto\\karate-Zen_Framework\\Zen_KarateFramework\\apk\\UiDemo.apk",
        "platformName": "Android",
        "platformVersion": "9.0",
        "deviceName": "emulator-5554",
        "connectHardwareKeyboard": true,
        "newCommandTimeout" : 500
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

  var result = karate.callSingle('classpath:api/Ztrain.feature@login', config);
      config.authInfo = { token: result.response.token , user: result.response.user._id };

  return config;
};
