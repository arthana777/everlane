import 'dart:convert';
import 'package:everlane/data/models/userregistration.dart';
import 'package:http/http.dart' as http;

class SignupRepository {
  final String apiUrl = 'https://18.143.206.136/api/register/';

  Future registerUser(Userregistration user) async {
    try {
      print("Attempting to registeration user");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return "success";
      } else {
        return "failed";
      }
    } catch (e) {
      print('Error occurred during registration: $e');
    }
  }
}
