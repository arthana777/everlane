import 'dart:convert';

class CartListResponse {
  final List<Cart> data;

  CartListResponse({
    required this.data,
  });

  factory CartListResponse.fromJson(Map<String, dynamic> json) {
    return CartListResponse(
      data: List<Cart>.from(json['data'].map((item) => Cart.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': List<dynamic>.from(data.map((item) => item.toJson())),
    };
  }
}

class Cart {
  final int id;
  final int user;
  final List<CartItem> items;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdOn;
  final String totalPrice;

  Cart({
    required this.id,
    required this.user,
    required this.items,
    required this.isActive,
    required this.isDeleted,
    required this.createdOn,
    required this.totalPrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      user: json['user'],
      items: List<CartItem>.from(json['items'].map((item) => CartItem.fromJson(item))),
      isActive: json['is_active'],
      isDeleted: json['is_deleted'],
      createdOn: DateTime.parse(json['created_on']),
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'items': List<dynamic>.from(items.map((item) => item.toJson())),
      'is_active': isActive,
      'is_deleted': isDeleted,
      'created_on': createdOn.toIso8601String(),
      'total_price': totalPrice,
    };
  }
}

class CartItem {
  final int id;
  final int product;
  final int productitem;
  final String productName;
  final double productPrice;
  final int quantity;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdOn;
  final String productImage;
  final String? size;

  CartItem( {
    required this.id,
    required this.product,
    required this.productitem,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.isActive,
    required this.isDeleted,
    required this.createdOn,
    required this.productImage,
    this.size,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id']??0,
      productitem: json['product_item'],
      product: json['product_id'],
      productName: json['product_name'],
      productPrice: json['product_price'].toDouble(),
      quantity: json['quantity'],
      isActive: json['is_active'],
      isDeleted: json['is_deleted'],
      createdOn: DateTime.parse(json['created_on']),
      productImage: json['product_image'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'product_name': productName,
      'product_price': productPrice,
      'quantity': quantity,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'created_on': createdOn.toIso8601String(),
      'product_image': productImage,
      'size':size
    };
  }
}
