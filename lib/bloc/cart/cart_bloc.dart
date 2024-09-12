
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import '../../data/datasources/cartdatasource.dart';
import '../../data/models/cartmodel.dart';
import '../../data/models/ordermodel.dart';
import '../../data/models/paymentresponsemodel.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartBloc() : super(CartInitial()) {
    final CartDatasource cartDataSource=CartDatasource();
    on<FetchCartData>((event, emit) async {
      List<Cart> list=[];
      emit(CartLoading());
      print("mnbvcxx");
      try {
        final List<Cart> result = await cartDataSource.getCart();
        list=result;
        print("lmnopqrst${list.length}");
        if(list.isNotEmpty){
          emit(CartLoaded(result));
        }
        else{
            emit(CartLoaded([]));
        }
      } catch (e) {
        print("@@@@@@@@@@@@@@@@@@");
        emit(CartError(e.toString()));
      }
    });



    on<AddToCart>((event, emit) async {
      emit(addtoCartLoading());
      try {
        final cartitems = await cartDataSource.postCart(event.productId,event.size);
        print("cartitemsss${cartitems.status}");
        if(cartitems.status=="success"){
          emit(addtoCartSuccess(message: cartitems.message??""));
        }
        else{
          emit(addtoCartError(message: cartitems.message??""));
        }
      } catch (e) {
        emit(addtoCartError(message: e.toString()));
      }
    });
    on<RemovefromCart>((event, emit) async {
      emit(RemoveCartLoading());
      try {
        final deleteditems = await cartDataSource.Removecart(event.productId);
        print("deleteditems: $deleteditems");

        if (deleteditems == "success") {
          emit(RemoveCartSuccess(event.productId));
        } else {
          emit(RemoveCartFailure(deleteditems));
        }
      } catch (e) {
        emit(RemoveCartFailure(e.toString()));
      }
    });



    on<PlaceOrder>((event, emit) async {
      print("PlaceOrder event triggered");
      emit(palceOrderLoading());
      try {
        print("Calling placeOrder with paymentMethod: ${event.paymentMethod}, orderType: ${event.orderType}, deliveryAddressId: ${event.deliveryAddressId}");
        final result = await cartDataSource.placeOrder(event.paymentMethod??"", event.orderType??'', event.deliveryAddressId??0,event.disasterid??0,event.pickupid??0);
        print("result in placeOrderBloc: $result");
        if (result.startsWith('https://')) {
          emit(PlaceOrderSuccess(approvalUrl: result));
        } else {
          emit(placeOrdererror(message: result.toString()));
        }
      } catch (e) {
        print("Exception in placeOrder: $e");
        emit(placeOrdererror(message: e.toString()));
      }
    });


    on<IncreaseCartItemQuantity>((event, emit) async {

      try {
        final cartitems = await cartDataSource.updateCartItemQuantity(event.cartItemId??0, event.increase??'');
        print("object${cartitems}");
        if(cartitems=="success"){
          emit(incrementsuccess());
        }
        else{
          emit(incrementerror(message: cartitems));
        }
      } catch (e) {
        emit(incrementerror(message: e.toString()));
      }
    });

    on<DecreaseCartItemQuantity>((event, emit) async {

      try {
        final cartitems = await cartDataSource.updateCartItemQuantity(event.cartItemId, event.decrease);
        print("object${cartitems}");
        if(cartitems=="success"){
          emit(decrementsuccess());
        }
        else{
          emit(decrementerror(message: cartitems));
        }
      } catch (e) {
        emit(decrementerror(message: e.toString()));
      }
    });

    on<fetchOrders>((event, emit) async {
      List<Order> list=[];
      emit(OrderLoading());
      print("mnbvcxx");
      try {
        final List<Order> result = await cartDataSource.getOrders();
        list=result;
        print("order list${list.length}");
        if(list.isNotEmpty){
          emit(OrderLoaded(orders: result));
        } else{
          emit(OrderError(message: e.toString()));
        }
      } catch (e) {
        print("@@@@@@@@@@@@@@@@@@");
        emit(OrderError(message: e.toString()));
      }
    });

    on<ReturnOrder>((event, emit) async {
      emit(Returnloading());
      try {
        final result = await cartDataSource.returnOrder(event.orderItemId??0,event.returnQuantity??0,event.returnReason??"");
        print("orderitemid${event.orderItemId}");
        print("API call result: $result");
        if(result=="success"){
          emit(ReturnSuccess(result));
        }
        else{
          emit(ReturnError(message: result));
        }
      } catch (e) {
        emit(ReturnError(message: e.toString()));
      }
    });


    on<ExecutePayment>((event, emit) async {
      emit(ExecutionLoading());
      try {

        print('Executing payment with: ${event.paymentId}, ${event.payerId}, ${event.token}');
        final PaymentResponse? result = await cartDataSource.paymentExecute(
          event.paymentId ?? '',
          event.payerId ?? '',
          event.token ?? '',
        );
        if (result != null && result.status == "success") {
          print('Payment successful: ${result.data.orderCode}');

          emit(ExecutionLoaded(result));
        } else {
          // Emit an error state if the payment execution failed
          emit(ExecutionError(message: result?.message ?? "Payment execution failed"));
        }
      } catch (e) {
        print('Error during payment execution: $e');
        emit(ExecutionError(message: e.toString()));
      }
    });

    on<CancelOrderevent>((event, emit) async {

      try {
        final cancelleditems = await cartDataSource.cancelOrder(event.orderid);
        print("cancelleditems: $cancelleditems");

        if (cancelleditems == "success") {
          emit(CancelorderLoaded(event.orderid));
        } else {
          emit(RemoveCartFailure(cancelleditems));
        }
      } catch (e) {
        emit(RemoveCartFailure(e.toString()));
      }
    });


  }
}
