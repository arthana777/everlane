// product_event.dart

part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class LoadSeasons extends ProductEvent {
  final String season;
  LoadSeasons(this.season);

  @override
  List<Object> get props => [season];
}
class Loadfiltercategories extends ProductEvent {
  final int id;
  Loadfiltercategories(this.id);

}
class LoadDetails extends ProductEvent {
  final int id;
  LoadDetails(this.id);

}
class Searchproducts extends ProductEvent {
  final String keyword;
  Searchproducts(this.keyword);

  @override
  List<Object> get props => [keyword];
}
