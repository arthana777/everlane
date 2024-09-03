// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



import '../../sharedprefrence/sharedprefs_login.dart';

class Apiservices{

  Future<void> saveToken(String token,bool val) async {
    print("token:- ${token}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setBool('auth_val', val);
    print("booleannn$val");

  }

 Future<String> getdata(String username,String password) async {
        print("hhhhhh$username");
    print(password);
    final SharedPrefeService sp = SharedPrefeService();
    try{
      final response = await http.post(
        Uri.parse('https://18.143.206.136/api/login/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final errresponse = jsonDecode(response.body);
        print("yyyyyyyyyyyyyyyyy${errresponse}");
        if(errresponse['message']=="Login successful"){
          final String token = errresponse['token'];
          await saveToken(token,true);
          return "success";
        }
        else{
          return "Failed";
        }
       // Login successful, proceed to next step
      }
    }catch(e){
      print("loooppppp${e}");

    }
    return "true";
  }

}