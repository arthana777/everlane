part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {}
class FetchCartData extends CartEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final int productId;
  final String size;

   AddToCart( {required this.productId,required this.size,});

  @override
  List<Object?> get props => [productId];
}
class RemovefromCart extends CartEvent{

  final int productId;
  RemovefromCart(this.productId);

  @override
  List<Object> get props => [productId];
}
class PlaceOrder extends CartEvent {
  final int deliveryAddressId;
  final int? disasterid;
  final int? pickupid;

  final String orderType;
  final String paymentMethod;

  PlaceOrder( {required this.deliveryAddressId, required this.orderType, required this.paymentMethod, this.disasterid,  this.pickupid,});


  @override
  // TODO: implement props
  List<Object?> get props => [deliveryAddressId,orderType,paymentMethod];
}

class IncreaseCartItemQuantity extends CartEvent {
  final int cartItemId;
  final String increase;

  IncreaseCartItemQuantity(this.cartItemId, this.increase);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DecreaseCartItemQuantity extends CartEvent {
  final int cartItemId;
final String decrease;
  DecreaseCartItemQuantity(this.cartItemId, this.decrease);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class fetchOrders extends CartEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class ExecutePayment extends CartEvent {
  @override
  final String? paymentId;
  final String? payerId;
  final String? token;

  ExecutePayment(this.paymentId, this.payerId, this.token, );
  List<Object?> get props => [];
}


class ReturnOrder extends CartEvent {
  final int? orderItemId;
  final int? returnQuantity;
  final String? returnReason;


  ReturnOrder({this.orderItemId, this.returnQuantity, this.returnReason, });


  @override
  // TODO: implement props
  List<Object?> get props => [orderItemId,returnQuantity,returnReason];
}
