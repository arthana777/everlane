import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../sharedprefrence/sharedprefs_login.dart';
import '../models/cartmodel.dart';
import '../models/ordermodel.dart';
import '../models/paymentresponsemodel.dart';

class CartDatasource{
  final client = http.Client();


  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    print("stringvalueee${token}");
    return token;
  }
  Future<List<Cart>> getCart() async {
    final String? token = await getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Failed: Token not found or is empty');
    }
    print("https://18.143.206.136/api/carts/");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/carts/'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Token $token',
        },
      );
      print("cart products..${response.body}");
      if (response.statusCode == 200) {
        print("Successful response: ${response.body}");
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final List<dynamic> dataList = responseBody['data'];
        print("Data List: $dataList");

        final List<Cart> cartlist = dataList.map((json) =>
            Cart.fromJson(json)).toList();
        print(cartlist.length);
        return cartlist;
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception("Failed to load products ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("$e");
    }
  }


  Future<String> postCart(int cid,String size) async {
    print("piddddddd$cid");
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    final SharedPrefeService sp = SharedPrefeService();
    try {
      final response = await http.post(
        Uri.parse('https://18.143.206.136/api/add-to-cart/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode({
          'product_id': cid,
          'size': size,
        }),
      );
      print(response.body);
      if (response.statusCode == 201) {
        final decodedResponse = jsonDecode(response.body);
        print("ytytytyt${decodedResponse}");
        if (decodedResponse['message'] ==
            "Product added to wishlist successfully.") {
          // await getToken(token);
          return "success";
        }
        else {
          return "Failed: ${decodedResponse['message']}";
        }
        // Login successful, proceed to next step
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
    return "true";
  }


  Future<String> Removecart(int pid) async {
    print("piddddddd$pid");
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    final SharedPrefeService sp = SharedPrefeService();
    try {
      final response = await http.delete(
        Uri.parse('https://18.143.206.136/api/cart-item/$pid/delete/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode({
          'product': pid
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        print("ytytytyt${decodedResponse}");
        if (decodedResponse['message'] ==
            "Wishlist item deleted successfully.") {
          return "success";
        }
        else {
          return "Failed: ${decodedResponse['message']}";
        }
        // Login successful, proceed to next step
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
    return "true";
  }




  Future<String> placeOrder(String method, String orderType, int addressId,int disasterid,int pickupid) async {
    print("Address ID: $addressId");
    print("disaster ID: $disasterid");
    print("Addrepickupss ID: $pickupid");
    print("ordertype ID: $orderType");
    final String? token = await getToken();
    if (token == null || token.isEmpty) {
      return "Failed: Token not found or is empty";
    }

    try {
      final response = await http.post(
        Uri.parse('https://18.143.206.136/api/place-order/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode({
          'payment_method': method,
          'order_type': orderType,
          'address_id': addressId,
          'disaster_id':disasterid,
          'pickup_location_id': pickupid
        }),
      );

      print("Response Body: ${response.body}");

      if (response.statusCode == 201) { // Check for successful creation
        final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

        if (decodedResponse['status'] == "success") {
          return decodedResponse['approval_url'] ?? "No approval URL found";
        }
        else {
          return "Failed: ${decodedResponse['message']}";
        }
      } else {
        return "Failed: ${response.reasonPhrase}";
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
  }



  Future<String> returnOrder(int orderItemId, int returnQuantity,String returnReason ) async {
    print("returnOrder function called with ID: $orderItemId, Quantity: $returnQuantity");
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }

    final SharedPrefeService sp = SharedPrefeService();

    try {
      print("Making HTTP POST request...");
      final response = await http.post(
        Uri.parse('https://18.143.206.136/api/request-return/'), // Update the endpoint if necessary
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode({
          'order_item_id': orderItemId,
          'return_quantity': returnQuantity,
          'return_reason': returnReason,
        }),
      );
      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse['message'] == "Return requested successfully.") {
          return "success";
        } else {
          return " ${decodedResponse['message']}";
        }
      } else {
        return "Failed: ${response.statusCode}";
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
  }





  Future<dynamic> getOrders() async {
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    print("https://18.143.206.136/api/orders/");
    try {
      final response = await client.get(
        Uri.parse('https://18.143.206.136/api/orders/'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
      );
      if (response.statusCode == 200) {
        print("Successful response: ${response.body}");
        final Map<String, dynamic> responseBody = jsonDecode(response.body);


        if (response.statusCode == 200) {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);


          final List<dynamic> dataList = responseBody['data'];
          final List<Order> orderList = dataList.map((json) => Order.fromJson(json)).toList();
          print("orderlstttttttt: ${orderList}");
          return orderList;
        }
      } else {
        print("Failed with status code: ${response.statusCode}");
        return <Order>[];

      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("$e");
    }
  }



  Future<PaymentResponse?> paymentExecute(String paymentId, String payerId, String token) async {
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return null;
    }

    final url = 'https://18.143.206.136/api/payment/execute/?paymentId=$paymentId&token=$token&PayerID=$payerId';
    print("Request URL: $url");

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
      );

      if (response.statusCode == 200) {
        print("Successful response: ${response.body}");
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return PaymentResponse.fromJson(responseBody);
      } else {
        print("Failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<String> cancelOrder(int orderid) async {
    print("orderid$orderid");
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    final SharedPrefeService sp = SharedPrefeService();
    try {
      final response = await http.delete(
        Uri.parse('https://18.143.206.136/api/cancel-order-item/$orderid/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode({
          'id': orderid
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        print("ytytytyt${decodedResponse}");
        if (decodedResponse['message'] ==
            "Order item canceled successfully") {
          return "success";
        }
        else {
          return "Failed: ${decodedResponse['message']}";
        }
        // Login successful, proceed to next step
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
    return "true";
  }


  Future<String> updateCartItemQuantity(int cartItemId, String action) async {
    print("cartitemid$cartItemId");
    final String? stringValue = await getToken();
    if (stringValue == null || stringValue.isEmpty) {
      return "Failed: Token not found or is empty";
    }
    final SharedPrefeService sp = SharedPrefeService();
    try {
      final response = await http.post(
        Uri.parse('https://18.143.206.136/api/update-cart-item-quantity/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $stringValue',
        },
        body: jsonEncode({
          "cart_item_id": cartItemId,
          "action": action,
        }),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        // Handle success
        print("Cart item updated successfully");
      } else {
        // Handle failure
        throw Exception('Failed to update cart item');
      }
    } catch (e) {
      return "Failed: ${e.toString()}";
    }
    return "true";
  }

}