import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordService {
  final String baseUrl = 'https://18.143.206.136/api/forgot-password/';

  Dio user = Dio();
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<String> forgotPassword(String username) async {
    String? token = await getToken();

    print("${token}");

    try {
      final response = await user.post(
        "https://18.143.206.136/api/forgot-password/",
        data:{'username':username},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print("${token}");
      print("hhhh");
      print("response${response}");
      print("response${response.data}");
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        return "Failed to Update";
      }
    } catch (e) {
      print("exxccccceeepp $e");
      return "Something went wrong";
    }
  }
}
