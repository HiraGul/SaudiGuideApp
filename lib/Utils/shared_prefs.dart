import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
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

  static setInterest({required bool isLoggedIn}) async =>
      await preferences!.setBool('check', isLoggedIn);
  static bool? getInterest() => preferences!.getBool('check');






  static setUseData(UserData userModel)async{
    preferences=await SharedPreferences.getInstance();
    await preferences?.setString("user", userDataToJson(userModel));
  }

  static Future<UserData?> getUserData()async{
    preferences=await SharedPreferences.getInstance();
    String userJson=preferences?.getString("user")??"";
    if(userJson.isNotEmpty){
      return userDataFromJson(userJson);
    }
    else{
      return null;
    }
  }

  static Future clearSharedPreferences() => preferences!.clear();



  // static setUseData(UserData userModel) async {
  //   preferences = await SharedPreferences.getInstance();
  //   await preferences?.setString("user", userModel.toJson().toString());
  // }
  //
  // static Future<UserData> getUserData( ) async {
  //   preferences = await SharedPreferences.getInstance();
  // var data =    preferences?.getString('user');
  //
  //
  // if(data != null){
  //  var  jsonResponse =  json.decode(data ?? "");
  //
  //  return UserData.fromJson(jsonResponse);
  // }else{
  //   return UserData('', '', '', '', '', '', '');
  // }
  // }


    // await preferences?.setString("user", userModel.toJson().toString());
}
