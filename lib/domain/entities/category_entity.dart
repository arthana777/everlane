import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? name;
  final int? id;
  final int? category;
  final String? image;

  CategoryEntity( { this.name,  this.id,  this.image,this.category, });

  @override
  List<Object?> get props => [name, id];

  @override
  String toString() => 'CategoryEntity(name: $name, id: $id)';
}
