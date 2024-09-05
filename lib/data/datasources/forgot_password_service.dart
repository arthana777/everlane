import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:everlane/data/models/forgot_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordService {
  final String baseUrl = 'https://18.143.206.136/api/forgot-password/';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Dio user = Dio();

  Future<String> forgotPassword(String username) async {
    try {
      String? token = await getToken();
      if (token == null) {
        return "Authorization token not found.";
      }

      final response = await user.post(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json',
          },
        ),
        data: jsonEncode(ForgotModel(username: username).toJson()),
      );
    print("Data Received Get : ${response.data}");
    print("Token: $token");
    print("Response Status: ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data['data'] ?? "Data updated successfully!";
      } else {
        return "Failed to update data: ${response.statusCode}";
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      return "Request failed: ${e.response?.statusCode ?? 'unknown status code'}";
    } catch (e) {
      // Handle other errors
      return "An error occurred: $e";
    }
  }
}
