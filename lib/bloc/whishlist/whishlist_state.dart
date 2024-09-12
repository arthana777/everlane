import 'package:equatable/equatable.dart';

import '../../data/models/whishlistmodel.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class addtoWishlistInitial extends WishlistState {}

class addtoWishlistLoading extends WishlistState {}

class addtoWishlistSuccess extends WishlistState {
  // late final List whishlists;
  final int addedProductId;
  addtoWishlistSuccess(this.addedProductId);
}

class addtoWishlistFailure extends WishlistState {
  final String error;
  addtoWishlistFailure(this.error);
  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {
  final List<WhislistProduct> whishlists;
  WishlistSuccess(this.whishlists);
}

class WishlistFailure extends WishlistState {
  final String error;

  WishlistFailure(this.error);

  @override
  List<Object> get props => [];
}

class RemoviewishlistLoading extends WishlistState {}

class RemoveWishlistSuccess extends WishlistState {
  final int removedProductId;
  RemoveWishlistSuccess(this.removedProductId);
  List<Object> get props => [removedProductId];
}

class RemoveWishlistFailure extends WishlistState {
  final String error;
  RemoveWishlistFailure(this.error);
  @override
  List<Object> get props => [];
}
