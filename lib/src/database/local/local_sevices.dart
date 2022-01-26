import 'package:shared_preferences/shared_preferences.dart';

class LocalDBServices {
  //make this class private using the coming methods to use only in one place
  LocalDBServices();

  //initialize shared preferences to use it easily
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //get string from Local DB (SharedPreferences).
  static String? getLocalString({required String key}) {
    return sharedPreferences!.getString(key);
  }

  //set strings to local Data Base
  static Future setLocalString(
      {required String value, required String key}) async {
    return await sharedPreferences!.setString(key, value);
  }

  //remove all data from local data base
  static removeData() {
    return sharedPreferences!.clear();
  }
}
