import 'package:dio/dio.dart';
import 'package:everlane/data/models/qstresult.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QstService {
  String url = 'https://18.143.206.136/api/questionnaire/';
  String getUrl = 'https://18.143.206.136/api/recommendations/';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Dio user = Dio();

  Future<String> updateUserQuestion(Map<String, dynamic> data) async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('Token not found');
    } try {
      final response = await user.patch(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return response.data['message'] ?? "Data updated successfully!";
      } else {
        return "";
      }
    } catch (e) {
      print("Error: $e");
      return "Something went wrong";
    }
  }

  Future<List<Qstresult>> fetchUserProfile() async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await user.get(
      getUrl,
      options: Options(
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    print("Data Received Get : ${response.data}");
    print("Token: $token");
    print("Response Status: ${response.statusCode}");

    if (response.statusCode == 200) {
      try {
        List<dynamic> dataList = response.data['data'];
        List<Qstresult> results =
            dataList.map((data) => Qstresult.fromJson(data)).toList();
        print("Parsed Data:");
        return results;
      } catch (e) {
        print("Error during parsing: $e");
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
