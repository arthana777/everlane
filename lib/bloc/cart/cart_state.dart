part of 'cart_bloc.dart';

@immutable
sealed class CartState extends Equatable{}

final class CartInitial extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class CartLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CartLoaded extends CartState {
  final List<Cart> carts;

  CartLoaded(this.carts);

  @override
  List<Object> get props => [carts];
}

class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  List<Object> get props => [message];
}

class addtoCartInitial extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class addtoCartLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class addtoCartSuccess extends CartState {
  @override
  // final List<Cart> carts; // Assuming you have a Cart model
  //
  // addtoCartSuccess({required this.carts});

  @override
  List<Object?> get props => [];
}

class addtoCartError extends CartState {
  @override
  final String message;

   addtoCartError({required this.message});

  @override
  List<Object?> get props => [message];
}


class RemoveCartLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RemoveCartSuccess extends CartState {
  final int removedProductId;
  RemoveCartSuccess(this.removedProductId);
  List<Object> get props => [removedProductId];
}

class RemoveCartFailure extends CartState {
  final String error;
  RemoveCartFailure(this.error);
  @override
  List<Object> get props => [];
}


class incrementsuccess extends CartState {
  @override
  // final List<Cart> carts; // Assuming you have a Cart model
  //
  // addtoCartSuccess({required this.carts});

  @override
  List<Object?> get props => [];
}

class incrementerror extends CartState {
  @override
  final String message;

  incrementerror({required this.message});

  @override
  List<Object?> get props => [message];
}


class decrementsuccess extends CartState {
  @override
  // final List<Cart> carts; // Assuming you have a Cart model
  //
  // addtoCartSuccess({required this.carts});

  @override
  List<Object?> get props => [];
}

class decrementerror extends CartState {
  @override
  final String message;

  decrementerror({required this.message});

  @override
  List<Object?> get props => [message];
}



class palceOrderLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class PlaceOrderSuccess extends CartState {
  final String approvalUrl;

  PlaceOrderSuccess({required this.approvalUrl});

  @override
  List<Object?> get props => [approvalUrl];
}


class placeOrdererror extends CartState {
  @override
  final String message;

  placeOrdererror({required this.message});

  @override
  List<Object?> get props => [message];
}
class OrderLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OrderLoaded extends CartState {

  final List<Order> orders;
  OrderLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrderError extends CartState {
  final String message;

  OrderError({required this.message});

  @override
  List<Object> get props => [message];
}


class Returnloading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ReturnSuccess extends CartState {
  String message;
  ReturnSuccess(this.message);
  @override
  // final List<Cart> carts; // Assuming you have a Cart model
  //
  // addtoCartSuccess({required this.carts});

  @override
  List<Object?> get props => [];
}

class ReturnError extends CartState {
  @override
  final String message;

  ReturnError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ExecutionLoading extends CartState {
  @override
  List<Object?> get props => [];
}

class ExecutionLoaded extends CartState {
  final PaymentResponse paymentResponse;

  ExecutionLoaded(this.paymentResponse);

  @override
  List<Object> get props => [paymentResponse];
}

class ExecutionError extends CartState {
  final String message;

  ExecutionError({required this.message});

  @override
  List<Object> get props => [message];
}

class CancelorderLoaded extends CartState{
  final int orderid;

  CancelorderLoaded(this.orderid);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}








