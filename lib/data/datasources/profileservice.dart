import 'package:dio/dio.dart';
import 'package:everlane/data/models/userprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final String baseUrl = 'https://18.143.206.136/api/profile/';

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Dio client = Dio(); 

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Userprofile> fetchUserProfile() async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    Userprofile userprofile;
    final response = await client.get(
      baseUrl,
      options: Options(
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    print("datas${response.data}");
    print("Token:- ${token}");
    print("responce${response.data['data']}");
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      userprofile = Userprofile.fromJson(response.data['data']);

      print("hehehe kittyy ${response.data['data']}");

      return userprofile;
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
