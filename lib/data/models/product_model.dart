class Product {
  int? id;
  String name;
  String description;
  String price;
  //final int product;
  String brand;
  int subcategory;
  String image;
  final DateTime createdOn;
  final bool isDeleted;
  final bool isTrending;
 // final List<Item>? items;

  // bool isTrending;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.brand,
    required this.subcategory,
    required this.image,
    //required this.product,
    required this.createdOn,
    required this.isDeleted,
    required this.isTrending,
    // this.items,
    // required this.isTrending,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      brand: json['brand'] ?? '',
      //product: json['product']??'',
      subcategory: json['subcategory'] ?? 0,
      image: json['image'] ?? '',
      createdOn: DateTime.tryParse(json['created_on'] ?? '') ?? DateTime.now(),
      isDeleted: json['is_deleted'] ?? false,
      isTrending: json['is_trending'] ?? false,
     // items:List<Item>.from(json['items'].map((item) => Item.fromJson(item))),
      // List<Dish>.from(json["dishes"].map((x) => Dish.fromJson(x))),
      // items: json['items'] != null
      //     ? List<Item>.from(json['items'].map((item) => Item.fromJson(item)))
      //     : [], // Return an empty list if items is null
      //isTrending: json['is_trending'],
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
      'created_on': createdOn.toIso8601String(),
      'is_deleted': isDeleted,
      'is_trending': isTrending,
      //'items': items?.map((item) => item.toJson()).toList(),
      //'is_trending': isTrending,
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
      id: json['id'] ?? "",
      product: json['product'] ?? '',
      size: json['size'] ?? "",
      stock: json['stock'] ?? "",
      isOutOfStock: json['is_out_of_stock'] ?? "",
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
