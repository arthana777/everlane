
import 'package:everlane/bloc/whishlist/whishlist_event.dart';
import 'package:everlane/bloc/whishlist/whishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/whislist_datasource.dart';
import '../../data/models/whishlistmodel.dart';

class WhishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WhishlistBloc() : super(WishlistInitial()) {
   WhishlistDatasource wishlistdatasource = WhishlistDatasource();
    on<AddToWishlist>((event, emit) async {
      emit(addtoWishlistLoading());
      try {
        final whilistitems = await wishlistdatasource.addToWishlist(event.productId);
        print("object${whilistitems}");
        if(whilistitems=="success"){
          emit(addtoWishlistSuccess(event.productId));
        }
        else{
          emit(addtoWishlistFailure(whilistitems));
        }
      } catch (e) {
        emit(addtoWishlistFailure(e.toString()));
      }
    });


   on<RetrieveWhishlist>((event, emit) async {
     List<WhislistProduct> list=[];
     emit(WishlistLoading());
     print("mnbvcxx");
     try {
       final result = await wishlistdatasource.getWhishlist();

       list=result;
       print("QQQQQQQQQQQ${list.length}");
           if(list.isNotEmpty){
             emit(WishlistSuccess(result));
           }
     } catch (e) {
       print("@@@@@@@@@@@@@@@@@@");
       emit(WishlistFailure(e.toString()));
     }
   });

   on<Removefromwishlist>((event, emit) async {
     emit(RemoviewishlistLoading());
     try {
       final deleteditems = await wishlistdatasource.RemoveWishlist(event.productId);
       print("deleteditems: $deleteditems");

       if (deleteditems == "success") {
         emit(RemoveWishlistSuccess(event.productId));  // Simplified success state
       } else {
         emit(RemoveWishlistFailure(deleteditems));  // Emitting the failure with the message
       }
     } catch (e) {
       emit(RemoveWishlistFailure(e.toString()));
     }
   });
  }
}