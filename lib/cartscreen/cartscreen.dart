import 'package:everlane/checkout/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/whishlist/whishlist_bloc.dart';
import '../bloc/whishlist/whishlist_event.dart';
import '../bloc/whishlist/whishlist_state.dart';
import '../btm_navigation/btm_navigation.dart';
import '../data/models/cartmodel.dart';
import '../data/models/whishlistmodel.dart';

import '../product_detail/product_details.dart';
import '../widgets/customappbar.dart';
import '../widgets/customcircularindicator.dart';
import '../widgets/customcolor.dart';
import '../widgets/customfont.dart';
import 'cartitem.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> carts = [];
  List<int> wishlistProductIds = [];
  List<WhislistProduct> whishlist = [];
  int? isclicked;
  bool isLoading = true;

  @override
  void initState() {
    context.read<CartBloc>().add(FetchCartData());
    super.initState();
  }

  void tappingfun(int index) {
    isclicked = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: carts.any((cart) => cart.items.isNotEmpty)
              ? CustomColor.primaryColor
              : Color(0xFF973d93).withOpacity(0.5),
          onPressed: carts.any((cart) => cart.items.isNotEmpty)
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                }
              : null,
          label: Container(
            height: 30.h,
            width: 150.w,
            decoration: BoxDecoration(
                //color:  carts.any((cart) => cart.items.isNotEmpty)?CustomColor.primaryColor:Color(0xFF973d93).withOpacity(0.5),
                ),
            child: Center(
              child: Text("Checkout", style: CustomFont().buttontext),
            ),
          ),
          icon: Icon(
            Icons.shopping_cart_outlined,
            size: 20.sp,
            color: CustomColor.buttoniconColor,
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(
            text: 'My Cart',
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: BtmNavigation(),
                          type: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 230))
                      // MaterialPageRoute(builder: (context) => const BtmNavigation()),
                      );
                },
                icon: const Icon(Icons.arrow_back)),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<CartBloc, CartState>(
              listener: (context, state) {
                print(state);
                if (state is CartLoading) {
                  setState(() {
                    isLoading = false;
                  });
                } else if (state is CartLoaded) {
                  carts = state.carts;
                  print("Cart Loaded: ${carts.length} carts loaded.");
                  setState(() {
                    isLoading = false;
                  });
                } else if (state is CartError) {
                  setState(() {});
                }
                else if (state is RemoveCartSuccess) {
                  print("remmmoooovvveee ${state.removedProductId}");
                  context.read<CartBloc>().add(FetchCartData());
                  setState(() {

                    //
                    // carts.removeWhere((item) => item.product == state.removedProductId);
                  });
                }
              },
            ),

          ],
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: isLoading
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 300.h),
                    child: CustomCircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: carts.isEmpty ? 0 : carts.length,
                        itemBuilder: (context, cartIndex) {
                          final cart = carts[cartIndex];
                          print(carts.length);
                          if (cart.items.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 100.h, horizontal: 110.w),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 190.w,
                                        height: 190.h,
                                        child: Image.network(
                                          "https://i.pinimg.com/564x/92/8b/b3/928bb331a32654ba76a4fc84386f3851.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text("Your cart is empty!",
                                          style: CustomFont().titleText),
                                      SizedBox(
                                        height: 11.h,
                                      ),
                                      Text(
                                          textAlign: TextAlign.center,
                                          "Looks like you haven't added anything to your cart yet.",
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 13.sp))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Column(
                            children: carts[cartIndex].items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    print("erkdkufhcbj ${item.id}");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                          productId: item.product?? 0,
                                          isWishlisted: wishlistProductIds.contains(item.product?? 0),
                                        ),
                                      ),
                                    ).then((isWishlisted) {
                                      setState(() {
                                        if (isWishlisted != null && isWishlisted) {
                                          wishlistProductIds.add(item.product?? 0);
                                        } else {
                                          wishlistProductIds.remove(item.product?? 0);
                                        }
                                      });
                                    });

                                    context.read<ProductBloc>().add(
                                      LoadDetails(item.product?? 0),
                                    );
                                  },
                                  child: CartItemCard(
                                    ontapremove: () {
                                      setState(() {});
                                      BlocProvider.of<CartBloc>(context).add(
                                        RemovefromCart(item.id),
                                      );
                                    },
                                    title: item.productName,
                                    price: item.productPrice,
                                    image: item.productImage,
                                    itemcount: item.quantity.toString(),
                                    size: item.size!,
                                    decreased: () {
                                      BlocProvider.of<CartBloc>(context).add(
                                          IncreaseCartItemQuantity(
                                              cartItemId :item.id,
                                              increase:'increase'));
                                    },
                                    increased: () {
                                      if (item.quantity > 1) {
                                        BlocProvider.of<CartBloc>(context).add(
                                            DecreaseCartItemQuantity(
                                                item.id, 'decrease'));
                                      }
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: carts.any((cart) => cart.items.isNotEmpty)
                            ? Text(
                                "Cart summary",
                                style: CustomFont().subtitleText,
                              )
                            : null,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: carts.any((cart) => cart.items.isNotEmpty)
                              ? Container(
                                  height: 60.h,
                                  width: 450.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.4)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            "Total",
                                            style: CustomFont().bodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
                                            ":",
                                            style: CustomFont().subtitleText,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            carts.isNotEmpty
                                                ? carts[0].totalPrice ?? ''
                                                : '0.0',
                                            style: CustomFont().bodyText,
                                          ),
                                        ),
                                        // _buildRow(context, "Discount", "00"),
                                        // SizedBox(height: 10.h),
                                        // _buildRow(context, "Total", carts.isNotEmpty ? carts[0].totalPrice ??'' : '0.0',),
                                      ],
                                    ),
                                  ),
                                )
                              : null),
                      SizedBox(
                        height: 80.h,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
