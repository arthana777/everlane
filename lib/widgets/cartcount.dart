import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/cart/cart_bloc.dart';
import '../cartscreen/cartscreen.dart';
import '../data/models/cartmodel.dart';
import 'customcolor.dart';

class CartCount extends StatefulWidget {
   const CartCount({super.key});

  @override
  State<CartCount> createState() => _CartCountState();
}

class _CartCountState extends State<CartCount> {
  List<Cart> carts = [];
@override
  void initState() {
  BlocProvider.of<CartBloc>(context).add(FetchCartData());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen()));
            },
            icon: Icon(Icons.shopping_cart_outlined, size: 30.sp),
          ),
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {

            if (state is CartLoading) {

            } else if (state is CartLoaded) {
              carts = state.carts;
              state.carts.forEach((cart) {
                CartCountProvider.cartItemCount = cart.items.length;
                print(
                    "Cart ID: ${cart.id}, Items: ${cart.items.length}");
              });
            }
            return Positioned(
              right: 35.w,
              top: 8.h,
              child: Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    CartCountProvider.cartItemCount.toString(),
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CartCountProvider{
  static int cartItemCount = 0;
}