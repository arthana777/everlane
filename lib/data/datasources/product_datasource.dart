import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:everlane/data/models/product_model.dart';

import '../models/detailproduct.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProductFromApi();
  Future<List<Product>> getSeasons(String season);
  Future<List<Product>> getfiltercategory(int id);
  Future<DetailProduct> getDetailsProduct(int id);
  Future<List<Product>> searchProducts(String keyword);
}

class ProductRemoteDataSourceimpl extends ProductRemoteDataSource {
  final client = http.Client();
  final Dio clientDio= Dio();

  @override
  Future<List<Product>> getProductFromApi() async {
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/products/trending/'),
        headers: {
          'content-type': 'application/json',
        },
      );
      print("trending products..${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
print("llllllllll${responseBody.length}");
        final List<dynamic> categoryList = responseBody['data'];
print("uuuuuuuuu${categoryList.length}");
        final List<Product> products = categoryList.map((json) => Product.fromJson(json)).toList();
        // final List<Product> products = categoryList.map((json) =>
        //     Product.fromJson(json)).toList();
        print("ppppppppppp${products.length}");
        return products;
      } else {
        throw Exception("Failed to load products${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception("$e");
    }
  }

  @override
  Future<List<Product>> getSeasons(String season) async {
    print("https://18.143.206.136/api/products/$season/");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/products/$season/'),
        headers: {
          'content-type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
         print("seasonssss${responseBody}");
        final List<dynamic> productList = responseBody['data'];
        final List<Product> seasons = productList.map((json) =>
            Product.fromJson(json)).toList();
        print("hereeeeeee${seasons}");
        return seasons;
      } else {
        throw Exception("Failed to load products${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception("$e");
    }
  }

  @override
  Future<List<Product>> getfiltercategory(int subcategory) async{
    print("https://18.143.206.136/api/products/?subcategory=$subcategory");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/products/?subcategory=$subcategory'),
        headers: {
          'content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print( responseBody['data']);
        final List<dynamic> productList = responseBody['data'];

        final List<Product> filtercategories = productList.map((json) =>
            Product.fromJson(json)).toList();
        print(filtercategories);
        return filtercategories;
      } else {
        throw Exception("Failed to load products${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception("$e");
    }
  }

  @override
  Future<DetailProduct>getDetailsProduct(int id)async {
    print("https://18.143.206.136/api/products/$id/");
    final DetailProduct productdetails;
    try {
      final response = await clientDio.get(
       'https://18.143.206.136/api/products/$id/',
        options: Options(
          headers: {
            'content-type': 'application/json',
          },
        ),

      );
      print("details products..${response.data}");
      if (response.statusCode == 200) {
       productdetails=DetailProduct.fromJson(response.data['data']);
        return productdetails;
      } else {
        throw Exception("Failed to load products${response.statusCode}");
      }
    } catch (e) {
      print("hhhhhhhhhhhhhhhhhhhhhhhh$e");
      throw Exception("$e");
    }
  }

  @override
  Future<List<Product>> searchProducts(String keyword) async {
    print("SSSSSSSSSSSSSSSSSSS :https://18.143.206.136/api/products/?query=$keyword");
    // print("{http://18.143.206.136/api/products/?query=$keyword}");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/products/?query=$keyword'),
        headers: {
          'content-type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print("seasonssss${responseBody}");
        final List<dynamic> productList = responseBody['data'];
        final List<Product> keyword = productList.map((json) =>
            Product.fromJson(json)).toList();
        print("hereeeeeee${keyword}");
        return keyword;
      } else {
        throw Exception("Failed to load products${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception("$e");
    }
  }
}
