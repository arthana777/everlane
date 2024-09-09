import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class AddToWishlist extends WishlistEvent {
  final int productId;
  const AddToWishlist(this.productId);

  @override
  List<Object> get props => [productId];
}


class RetrieveWhishlist extends WishlistEvent{
  @override
  List<Object> get props => [];
}

class Removefromwishlist extends WishlistEvent{

  final int productId;
  Removefromwishlist(this.productId);

  @override
  List<Object> get props => [productId];
}
