import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/categoryy_models.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategoryFromApi();
  Future<List<CategoryModel>> getSubCategoryFromApi(int id)
  ; Future<List<CategoryModel>> getBanner(int id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final client = http.Client();

  @override
  Future<List<CategoryModel>> getCategoryFromApi() async {
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/categories/'),
        headers: {
          'content-type': 'application/json',
        },
      );
        print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
print("kjdfkyhujh ${ responseBody['data']}");
        final List<dynamic> categoryList = responseBody['data'];

        final List<CategoryModel> categories = categoryList.map((json) => CategoryModel.fromJson(json)).toList();
        print(categories);
        return categories;
      } else {
        throw Exception("Failed to load categories${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception("$e");
    }
  }

  Future<List<CategoryModel>> getSubCategoryFromApi(int id) async {

    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/subcategories/?category_id=$id'),

        headers: {
          'content-type': 'application/json',
        },
      );
      //print("DDDDDDDD${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final List<dynamic> categoryList = responseBody['data'];

        final List<CategoryModel> subcategories = categoryList.map((json) => CategoryModel.fromJson(json)).toList();
        print(subcategories);
        return subcategories;
      } else {
        throw Exception("Failed to load categories${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception("$e");

    }
  }
  Future<List<CategoryModel>> getBanner(int id) async {

    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/bannerss/?category_id=$id'),

        headers: {
          'content-type': 'application/json',
        },
      );
      //print("bannersssss${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final List<dynamic> categoryList = responseBody['data'];

        final List<CategoryModel> banners = categoryList.map((json) => CategoryModel.fromJson(json)).toList();
        print(banners);
        return banners;
      } else {
        throw Exception("Failed to load categories${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception("$e");

    }
  }
}
