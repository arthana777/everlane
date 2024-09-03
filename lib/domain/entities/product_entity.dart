import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String name;
  final String description;
  final String price;
  final String brand;
  final int subcategory;
  final String image;
  final DateTime createdOn;
  final bool isDeleted;
  final bool isTrending;
  final List<Item> items;

  ProductEntity({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.brand,
    required this.subcategory,
    required this.image,
    required this.createdOn,
    required this.isDeleted,
    required this.isTrending,
    required this.items,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    brand,
    subcategory,
    image,
    createdOn,
    isDeleted,
    isTrending,
    items,
  ];
}
