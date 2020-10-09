import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class Authentication{

  // get currently stored token, if token is not valid, return null
  static Future<String> getCurrentToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") != null
        && sharedPreferences.getString("token_expire_date")!= null
        && DateTime.parse(sharedPreferences.getString("token_expire_date")).isAfter(DateTime.now())
    ){
      return sharedPreferences.getString("token");
    }
    //Go back to login page
    else {
      return null;
    }
  }

  //For whatever reason user needs to go back to login screen, clear cache and go to login
  static void bounceUser(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
  }

  //Ensures no data in shared prefs
  static void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}