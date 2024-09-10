
class DetailProduct {
  final int id;
  final String name;
  final String description;
  final String price;
  final String brand;
  final int subcategory;
  final String image;
  final bool? isActive;
  final DateTime createdOn;
  final bool isDeleted;
  final bool isTrending;
  final List<Item> items;

  DetailProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.brand,
    required this.subcategory,
    required this.image,
     this.isActive,
    required this.createdOn,
    required this.isDeleted,
    required this.isTrending,
    required this.items,
  });

  factory DetailProduct.fromJson(Map<String, dynamic> json) {
    return DetailProduct(
      id: json['id']??0,
      name: json['name'],
      description: json['description'],
      price: json['price'],
      brand: json['brand'],
      subcategory: json['subcategory'],
      image: json['image'],
      isActive: json['is_active'],
      createdOn: DateTime.parse(json['created_on']),
      isDeleted: json['is_deleted'],
      isTrending: json['is_trending'],
      items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'brand': brand,
      'subcategory': subcategory,
      'image': image,
      'is_active': isActive,
      'created_on': createdOn.toIso8601String(),
      'is_deleted': isDeleted,
      'is_trending': isTrending,
      'items': List<dynamic>.from(items.map((x) => x.toJson())),
    };
  }
}

class Item {
  final int id;
  final int product;
  final String size;
  final int stock;
  final bool isOutOfStock;

  Item({
    required this.id,
    required this.product,
    required this.size,
    required this.stock,
    required this.isOutOfStock,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id']??0,
      product: json['product'],
      size: json['size'],
      stock: json['stock'],
      isOutOfStock: json['is_out_of_stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'size': size,
      'stock': stock,
      'is_out_of_stock': isOutOfStock,
    };
  }
}
