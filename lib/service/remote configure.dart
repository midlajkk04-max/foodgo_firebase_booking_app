import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 10),  
      ),
    );

    await remoteConfig.setDefaults(
      const {
        'pizza_name_1': 'Chicken Pizza',
        'pizza_price_1': '70',
        'pizza_name_2': 'Cheese Pizza',
        'pizza_price_2': '120',
        'pizza_name_3': 'Egg Pizza',
        'pizza_price_3': '90',
        'pizza_name_4': 'Peri Peri Pizza',
        'pizza_price_4': '155',

        'enable_food_override': false,
        'override_food_id': '',
        'override_food_price': '',
      },
    );

    await remoteConfig.fetchAndActivate();
  }

  
  String getString(String key) {
    return remoteConfig.getString(key);
  }
}