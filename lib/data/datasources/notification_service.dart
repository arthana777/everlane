import 'package:dio/dio.dart';
import 'package:everlane/data/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  String notificationUrl = 'https://18.143.206.136/api/notification/';
  Dio user = Dio();

  NotificationService({user});

  Dio delet = Dio();

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await user.get(
        notificationUrl,
        options: Options(
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data['status'] == 'success') {
        List<dynamic> dataList = response.data['data'];
        // Check if data is empty
        if (dataList.isEmpty) {
          throw Exception('No notifications found');
        }
        return dataList.map((data) => NotificationModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load notifications: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }

  Future<String> deleteNotification(int id) async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    try {
      final response = await user.delete(
        'https://18.143.206.136/api/notification/$id/delete/',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return response.data['message'];
      } else {
        throw Exception('Failed to delete notification');
      }
    } on DioException catch (e) {
      throw Exception('Failed to delete notification: ${e.message}');
    }
  }
}
