class PaymentResponse {
  final String status;
  final String message;
  final int responseCode;
  final OrderData data;

  PaymentResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      status: json['status'],
      message: json['message'],
      responseCode: json['response_code'],
      data: OrderData.fromJson(json['data']),
    );
  }
}

class OrderData {
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
  final String? disaster;
  final String? pickupLocation;
  final bool isPaid;
  final int deliveryAddress;
  final Invoice invoice;

  OrderData({
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
    required this.invoice,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      orderCode: json['order_code'],
      user: json['user'],
      totalAmount: json['total_amount'],
      isActive: json['is_active'],
      isDeleted: json['is_deleted'],
      createdOn: DateTime.parse(json['created_on']),
      isCompleted: json['is_completed'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      orderStatus: json['order_status'],
      items: (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
      isDonated: json['is_donated'],
      disaster: json['disaster'],
      pickupLocation: json['pickup_location'],
      isPaid: json['is_paid'],
      deliveryAddress: json['delivery_address'],
      invoice: Invoice.fromJson(json['invoice']),
    );
  }
}

class Item {
  final int id;
  final int productItem;
  final String productName;
  final int quantity;
  final String price;
  final String returnStatus;
  final String size;
  final String productImage;
  final double productPrice;
  final bool isReturned;
  final int returnedQuantity;
  final String? returnReason;
  final String? returnRequestedOn;
  final String? refundAmount;
  final String? refundDate;

  Item({
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
      productPrice: json['product_price'],
      isReturned: json['is_returned'],
      returnedQuantity: json['returned_quantity'],
      returnReason: json['return_reason'],
      returnRequestedOn: json['return_requested_on'],
      refundAmount: json['refund_amount'],
      refundDate: json['refund_date'],
    );
  }
}

class Invoice {
  final String invoiceNumber;
  final String totalAmount;
  final DateTime createdAt;
  final String pdf;

  Invoice({
    required this.invoiceNumber,
    required this.totalAmount,
    required this.createdAt,
    required this.pdf,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceNumber: json['invoice_number'],
      totalAmount: json['total_amount'],
      createdAt: DateTime.parse(json['created_at']),
      pdf: json['pdf'],
    );
  }
}
