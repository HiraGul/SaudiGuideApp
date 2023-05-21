import 'package:saudi_guide/Models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefs {
  /// reference of Shared Preferences
  static SharedPreferences? preferences;

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  static setIsLoggedIn({required String isLoggedIn}) async =>
      await preferences!.setString('login', isLoggedIn);
  static String? getIsLoggedIn() => preferences!.getString('login');
  static setUseData(UserData userModel) async {
    preferences = await SharedPreferences.getInstance();
    await preferences?.setString("user", userModel.toJson().toString());
  }

  static Future clearSharedPreferences() => preferences!.clear();

  // static UserData getUseData( ) async {
  //   preferences = await SharedPreferences.getInstance();
  //   await preferences?.setString("user", userModel.toJson().toString());
}
