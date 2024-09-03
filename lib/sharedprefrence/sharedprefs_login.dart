import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefeService{
  String loginModelKey='loginkey';
  String isloggined='logined';


  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Future<String?> getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('auth_token');
  // }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('auth_token');
    return stringValue;

  }
  //String? token = await getToken();
//saveToken('26feb8be6a2cca6296cf4a4e54d2c84d00d62ab2');

}