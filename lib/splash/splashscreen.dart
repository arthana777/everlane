import 'dart:async';

import 'package:everlane/first_page/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../btm_navigation/btm_navigation.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userIsLogedIn=false;
 // SharedPreferencesService sp=SharedPreferencesService();


  Future<void>loadData()async{
    final prefs = await SharedPreferences.getInstance();
    userIsLogedIn =   prefs.getBool('auth_val',)?? false;
    print("splash:$userIsLogedIn");
    setState(() {

    });
  }

  @override
  void initState(){  
    super.initState();
    loadData();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
          userIsLogedIn? const BtmNavigation():FirstPage()),
      );
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('https://img.freepik.com/free-vector/suit-jacket-cover-neon-sign_1262-15734.jpg?ga=GA1.2.1985107230.1716028092&semt=ais_hybrid'),fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
