import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:everlane/data/models/addressmodel.dart';
import 'package:everlane/data/models/disastermodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../sharedprefrence/sharedprefs_login.dart';
import '../models/mydonationsmodel.dart';
import '../models/pickupmodel.dart';

class UseraddressDatasourse {
  final client = http.Client();
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('auth_token');
    print("stringvalueee${stringValue}");
    return stringValue;
  }

  Future<dynamic> getAddress() async {
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    print("https://18.143.206.136/api/addresses/");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/addresses/'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
      );
      if (response.statusCode == 200) {
        print("Successful response: ${response.body}");
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody['data'] != null && responseBody['data'] is List) {
          final List<dynamic> dataList = responseBody['data'];
          final List<UserAddress> useradress =
              dataList.map((json) => UserAddress.fromJson(json)).toList();
          print(useradress.length);
          return useradress;
        } else {
          // Return an empty list if 'data' is null or not a list
          return <UserAddress>[];
        }
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception("Failed to load userdata ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("$e");
    }
  }

  Future<String> DeleteAddress(int aid) async {
    print("piddddddd$aid");
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    final SharedPrefeService sp = SharedPrefeService();
    try {
      final response = await http.delete(
        Uri.parse('https://18.143.206.136/api/addresses/$aid/delete/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode({'id': aid}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        print("ytytytyt${decodedResponse}");
        if (decodedResponse['message'] == "Address deleted successfully.") {
          // await getToken(token);
          return "success";
        } else {
          return "Failed: ${decodedResponse['message']}";
        }
        // Login successful, proceed to next step
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
    return "true";
  }

  Future<String> createAddress(
    String mobile,
    String pincode,
    String locality,
    String address,
    String city,
    String state,
    String landmark,
    bool isDefault,
    bool isActive,
    bool isDeleted,
  ) async {
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    // final SharedPrefeService sp = SharedPrefeService();
    try {
      final response = await http.post(
        Uri.parse('https://18.143.206.136/api/addresses/create/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode(<String, dynamic>{
          'mobile': mobile,
          'pincode': pincode,
          'locality': locality,
          'address': address,
          'city': city,
          'state': state,
          'landmark': landmark,
          'is_default': isDefault,
          'is_active': isActive,
          'is_deleted': isDeleted,
        }),
      );
      print(response.body);
      if (response.statusCode == 201) {
        final decodedResponse = jsonDecode(response.body);
        print("ytytytyt${decodedResponse}");
        if (decodedResponse['message'] == "Address created successfully.") {
          // await getToken(token);
          return "success";
        } else {
          return "Failed: ${decodedResponse['message']}";
        }
        // Login successful, proceed to next step
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
    return "true";
  }

  Future<String> DisasterReg(
    String name,
    String adhar,
    String location,
    String description,
    int requiredMenDresses,
    int requiredWomenDresses,
    int requiredKidsDresses,
    //int user,
  ) async {
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }

    try {
      final response = await http.post(
        Uri.parse('https://18.143.206.136/api/disasters/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'adhar': adhar,
          'location': location,
          'description': description,
          'required_men_dresses': requiredMenDresses,
          'required_women_dresses': requiredWomenDresses,
          'required_kids_dresses': requiredKidsDresses,
          // 'user': user,
        }),
      );

      print(response.body);
      if (response.statusCode == 201) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse['message'] == "Address created successfully.") {
          return "success";
        } else {
          return "Failed: ${decodedResponse['message']}";
        }
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
    return "true";
  }

  Future<dynamic> getDisasterlist() async {
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    print("https://18.143.206.136/api/disasters/");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/disasters/'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
      );
      if (response.statusCode == 200) {
        print("Successful response: ${response.body}");
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final List<dynamic> dataList = responseBody['data'];

        final List<Disaster> disasteradress =
            dataList.map((json) => Disaster.fromJson(json)).toList();
        print(disasteradress.length);
        return disasteradress;
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception("Failed to load userdata ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("$e");
    }
  }

 Future<List<Donation>> getMyDonations() async {
  final String? token = await getToken();

  if (token == null || token.isEmpty) {
    throw Exception("Token not found or is empty.");
  }

  final Uri url = Uri.parse('https://18.143.206.136/api/user-donations/');
  print("Fetching donations from: $url");

  try {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      print("Successful response: ${response.body}");

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Check if 'data' exists and is a List
      if (responseBody.containsKey('data') && responseBody['data'] is List) {
        final List<dynamic> dataList = responseBody['data'];

        final List<Donation> myDonations =
            dataList.map((json) => Donation.fromJson(json)).toList();

        print("Number of donations: ${myDonations.length}");
        return myDonations;
      } else {
        throw Exception("Invalid response: 'data' field is missing or not a list.");
      }
    } else {
      print("Failed with status code: ${response.statusCode}");
      throw Exception("Failed to load donations. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception occurred: $e");
    throw Exception("Error fetching donations: $e");
  }
}


  Future<dynamic> getmyregistrations() async {
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    print("https://18.143.206.136/api/my-disasters/");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/my-disasters/'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
      );
      if (response.statusCode == 200) {
        print("Successful response: ${response.body}");
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> dataList = responseBody['data'];

        final List<Disaster> mydisasters =
            dataList.map((json) => Disaster.fromJson(json)).toList();
        print(mydisasters.length);
        return mydisasters;
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception("Failed to load userdata ${response.statusCode}");
      }
    } catch (e) { 
      print("Exception: $e");
      throw Exception("$e");
    }
  }

  Future<String> uploadCloths(int disid, List<File> images, int men, int women,
      int kids, int pickup) async {
    print("disasterId: $disid ");
    print("image length: ${images}");
    final String? token = await getToken();
    if (token == null || token.isEmpty) {
      return "Failed: Token not found or is empty";
    }

    final dio = Dio();
    final uri = 'https://18.143.206.136/api/donations/';

    try {
      final imageFiles = await Future.wait(images.map((image) async {
        //return MultipartFile.fromFile(image.path, filename: path.basename(image.path));
        return MultipartFile.fromFile(image.path,
            filename: image.uri.pathSegments.last);
      }).toList());
      final formData = FormData.fromMap({
        'disaster': disid,
        'men_dresses': men,
        'women_dresses': women,
        'kids_dresses': kids,
        // disid.toString(),
        'images': imageFiles,
        'pickup_location': pickup,
        //'images': await MultipartFile.fromFile(image.path, filename: image.uri.pathSegments.last),
      });
      print("formdataaa${formData}");
      print("response of upload image ");

      final response = await dio.post(
        uri,
        data: formData,
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      print("response of upload image ${response.statusCode} ${response.data}");
      if (response.statusCode == 201) {

          return "success";

      }else{
        return "Failed";
      }




    } catch (e) {
      return "Failed: ${e.toString()}";
    }
  }

  Future<dynamic> getPickuplocations() async {
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    print("https://18.143.206.136/api/pickups/");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/pickups/'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
      );
      if (response.statusCode == 200) {
        print("Successful response: ${response.body}");
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody['data'] != null && responseBody['data'] is List) {
          final List<dynamic> dataList = responseBody['data'];
          final List<PickupLocation> pickuplocations =
              dataList.map((json) => PickupLocation.fromJson(json)).toList();
          print("lengthhhofpickuplocations${pickuplocations.length}");
          return pickuplocations;
        } else {
          // Return an empty list if 'data' is null or not a list
          return <PickupLocation>[];
        }
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception("Failed to load userdata ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("$e");
    }
  }
}
