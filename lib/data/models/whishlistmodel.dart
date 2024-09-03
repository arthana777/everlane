class WhislistProduct {
  final int? id;
  final int? product;
  final String? image;
  final String? name;
  final double? price;
  final String? description;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdOn;

  WhislistProduct({
     this.id,
     this.product,
     this.image,
     this.description,
    required this.isActive,
    required this.isDeleted,
    required this.createdOn,
     this.name,
     this.price,
  });

  factory WhislistProduct.fromJson(Map<String, dynamic> json) {
    return WhislistProduct(
      id: json['id'] != null ? (json['id'] as int) : 0,
      product: json['product'] != null ? (json['product'] as int) : 0,
      isActive: json['is_active'] ?? false,
      isDeleted: json['is_deleted'] ?? false,
      createdOn: DateTime.tryParse(json['created_on'] ?? '') ?? DateTime.now(),
      image: json['product_image'] != null ? json['product_image'] as String : '',
      name: json['product_name'] != null ? json['product_name'] as String : '',
      price: json['product_price'] != null ? (json['product_price'] as num).toDouble() : 0.0,
      description: json['product_description'] != null ? json['product_description'] as String : '',
    );
  }
}
