import 'dart:convert';

class Order {
  final int id;
  final String orderCode;
  final int user;
  final String totalAmount;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdOn;
  final bool isCompleted;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final List<Item> items;
  final bool isDonated;
  final dynamic disaster;
  final dynamic pickupLocation;
  final bool isPaid;
  final int deliveryAddress;


  Order({
    required this.id,
    required this.orderCode,
    required this.user,
    required this.totalAmount,
    required this.isActive,
    required this.isDeleted,
    required this.createdOn,
    required this.isCompleted,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.items,
    required this.isDonated,
    this.disaster,
    this.pickupLocation,
    required this.isPaid,
    required this.deliveryAddress,

  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id']??0,
      orderCode: json['order_code']??"",
      user: json['user']??0,
      totalAmount: json['total_amount']??"",
      isActive: json['is_active']??"",
      isDeleted: json['is_deleted']??"",
      createdOn: DateTime.parse(json['created_on']),
      isCompleted: json['is_completed'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      orderStatus: json['order_status'],
      items: (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
      isDonated: json['is_donated'],
      disaster: json['disaster']??"",
      pickupLocation: json['pickup_location'],
      isPaid: json['is_paid'],
      deliveryAddress: json['delivery_address']??0,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_code': orderCode,
      'user': user,
      'total_amount': totalAmount,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'created_on': createdOn.toIso8601String(),
      'is_completed': isCompleted,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'order_status': orderStatus,
      'items': items.map((item) => item?.toJson()).toList(),
      'is_donated': isDonated,
      'disaster': disaster,
      'pickup_location': pickupLocation,
      'is_paid': isPaid,
      'delivery_address': deliveryAddress,

    };
  }
}
class Item {
  final int id;
  final int productItem;
  final String productName;
  final int quantity;
  final String price;
  final String returnStatus;
  final String? orderitemstatus;
  final String size;
  final String productImage;
  final double productPrice;
  final bool isReturned;
  final int returnedQuantity;
  final dynamic returnReason;
  final dynamic returnRequestedOn;
  final dynamic refundAmount;
  final dynamic refundDate;

  Item( {
    required this.id,
    required this.productItem,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.returnStatus,
    required this.size,
    required this.productImage,
    required this.productPrice,
    required this.isReturned,
    required this.returnedQuantity,
    this.returnReason,
    this.returnRequestedOn,
    this.refundAmount,
    this.refundDate,
     this.orderitemstatus,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      productItem: json['product_item'],
      productName: json['product_name'],
      quantity: json['quantity'],
      price: json['price'],
      returnStatus: json['return_status'],
      size: json['size'],
      productImage: json['product_image'],
      productPrice: json['product_price'].toDouble(),
      isReturned: json['is_returned'],
      returnedQuantity: json['returned_quantity'],
      returnReason: json['return_reason'],
      returnRequestedOn: json['return_requested_on'],
      refundAmount: json['refund_amount'],
      refundDate: json['refund_date'],
      orderitemstatus: json['order_item_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_item': productItem,
      'product_name': productName,
      'quantity': quantity,
      'price': price,
      'return_status': returnStatus,
      "order_item_status":orderitemstatus,
      'size': size,
      'product_image': productImage,
      'product_price': productPrice,
      'is_returned': isReturned,
      'returned_quantity': returnedQuantity,
      'return_reason': returnReason,
      'return_requested_on': returnRequestedOn,
      'refund_amount': refundAmount,
      'refund_date': refundDate,
    };
  }
}

