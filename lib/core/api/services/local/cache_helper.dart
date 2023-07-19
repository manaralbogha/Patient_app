import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

/*  static Future<bool> putData({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }*/
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    // print(value);
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    // print(value);
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    //  print(value);
    if (value is bool) {
      //print(value);
      return await sharedPreferences!.setBool(key, value);
    }
    //print(value);
    return await sharedPreferences!.setDouble(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(
      key,
    );
  }

  static dynamic deletData({
    required String key,
  }) {
    return sharedPreferences!.remove(
      key,
    );
  }
}
