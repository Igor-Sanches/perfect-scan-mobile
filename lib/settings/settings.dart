import 'package:shared_preferences/shared_preferences.dart';

class Settings {

  static setUID(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  static Future<String?> getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  static void put({required  bool? value, required String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key!, value!);
  }

  static Future<bool?> get({required String key, required bool? valueDefault}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? valueDefault;
  }

  static Future<bool?> get isWifiAutoConnect async => (await Settings.get(key: 'WifiAutoConnect', valueDefault: true))!;
  static Future<bool?> get isAutoOpenLinks async => (await Settings.get(key: 'AutoOpenLinks', valueDefault: true))!;
  static Future<bool?> get isAutoFocus async => (await Settings.get(key: 'AutoFocus', valueDefault: true))!;
  static Future<bool?> get isModoMassaPhoto async => (await Settings.get(key: 'ModoMassaPhoto', valueDefault: false))!;
  static Future<bool?> get isModoMassa async => (await Settings.get(key: 'ModoMassa', valueDefault: false))!;
  static Future<bool?> get isApitar async => (await Settings.get(key: 'Apitar', valueDefault: true))!;
  static Future<bool?> get isSaveScanCodes async => (await Settings.get(key: 'SaveScanCodes', valueDefault: true))!;
  static Future<bool?> get isSaveMakerCodes async => (await Settings.get(key: 'SaveMakerCodes', valueDefault: true))!;

}