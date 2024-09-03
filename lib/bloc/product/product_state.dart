part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState{}
class ProductLoaded extends ProductState{
  final List<Product> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState{
  final String message;
   ProductError(this.message);
}


class SeasonsLoading extends ProductState {}

class SeasonsLoaded extends ProductState {

  final List<Product> seasons;
   SeasonsLoaded( this.seasons);

}

class SeasonError extends ProductState {
  final String message;
   SeasonError(this.message);
}

class filtercategoryLoading extends ProductState {}

class filtercategoryLoaded extends ProductState {

  final List<Product> filtercategories;
   filtercategoryLoaded( this.filtercategories);
}

class filtercategoryError extends ProductState {
  final String message;
  filtercategoryError(this.message);
}


class DetailsLoading extends ProductState {}

class DetailsLoaded extends ProductState {

  final DetailProduct productdetail;
  DetailsLoaded( this.productdetail);
}

class DetailsError extends ProductState {
  final String message;
  DetailsError(this.message);
}


class SearchLoading extends ProductState {}
class SearchLoaded extends ProductState {

  final List<Product> keyword;
  SearchLoaded( this.keyword);

}

class SearchError extends ProductState {
  final String message;
  SearchError(this.message);
}


