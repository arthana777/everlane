// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



import '../../sharedprefrence/sharedprefs_login.dart';
import '../models/whishlistmodel.dart';

class WhishlistDatasource {
  final client = http.Client();


  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('auth_token');
    print("stringvalueee${stringValue}");
    return stringValue;
  }

  Future<String> addToWishlist(int pid) async {
    print("piddddddd$pid");
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    final SharedPrefeService sp = SharedPrefeService();
    try {
      final response = await http.post(
        Uri.parse('https://18.143.206.136/api/wishlist/add/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode({
          'product_id': pid
        }),
      );
      print(response.body);
      if (response.statusCode == 201) {
        final decodedResponse = jsonDecode(response.body);
        return decodedResponse['status'];
        // print("ytytytyt${decodedResponse}");
        // if (decodedResponse['message'] ==
        //     "Product added to wishlist successfully.") {
        //   // await getToken(token);
        //   return "success";
        }
        else {
          final decodedResponse = jsonDecode(response.body);
          return ' ${decodedResponse['status']}';
          //return "Failed: ${decodedResponse['message']}";
        }
        // Login successful, proceed to next step
      }
     catch (e) {
      return "Failed: ${e.toString()}";
    }
  }


  Future<dynamic> getWhishlist() async {
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    print("https://18.143.206.136/api/wishlist/");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/wishlist/'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
      );
      print("whishlist products..${response.body}");
      if (response.statusCode == 200) {
        print("Successful response: ${response.body}");
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final List<dynamic> dataList = responseBody['data'];
        print("Data List: $dataList");

        final List<WhislistProduct> wishlist = dataList.map((json) =>
            WhislistProduct.fromJson(json)).toList();
        print(wishlist.length);
        return wishlist;
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception("Failed to load products ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("$e");
    }
  }

  Future<String> RemoveWishlist(int pid) async {
    print("remove$pid");
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    final SharedPrefeService sp = SharedPrefeService();
    try {
      final response = await http.delete(
        Uri.parse('https://18.143.206.136/api/wishlist/delete/$pid/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode({
          'product_id': pid
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        print("ytytytyt${decodedResponse}");
        if (decodedResponse['message'] ==
            "Wishlist item deleted successfully.") {
          // await getToken(token);
          return "success";
        }
        else {
          return "${decodedResponse['message']}";
        }
        // Login successful, proceed to next step
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
    return "Wishlist item deleted successfully";
  }
}