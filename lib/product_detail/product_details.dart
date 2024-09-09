import 'package:everlane/bloc/product/product_bloc.dart';
import 'package:everlane/cartscreen/cartscreen.dart';
import 'package:everlane/checkout/address_creation.dart';
import 'package:everlane/data/navigation_provider/navigation_provider.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/address/address_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/whishlist/whishlist_bloc.dart';
import '../bloc/whishlist/whishlist_event.dart';
import '../bloc/whishlist/whishlist_state.dart';
import '../btm_navigation/btm_navigation.dart';
import '../checkout/address_list.dart';
import '../data/models/cartmodel.dart';
import '../data/models/detailproduct.dart';
import '../data/models/product_model.dart';
import '../data/models/whishlistmodel.dart';
import '../domain/entities/product_entity.dart';
import '../widgets/customcolor.dart';

class ProductDetails extends StatefulWidget {

  final int productId;
  ProductDetails({Key? key, required this.productId}) : super(key: key);


  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int cartItemCount = 0;
  List<int> wishlistProductIds = [];
  List<WhislistProduct> whishlist = [];
  DetailProduct? productdetail;
  List<Cart> carts = [];
  int? isclicked;
  bool isLoading=false;
  bool isAddedToCart = false;
  bool isItemOutOfStock = false;
  bool isInWishlist(int? productId) {
    return wishlistProductIds.contains(productId);
  }
  //bool isInWishlist=wishlistProductIds.contains(productde?.id));
@override
  void initState() {
  BlocProvider.of<ProductBloc>(context).add(LoadDetails(widget.productId));
  BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
    super.initState();
  }
  void tappingfun(int index) {
    isclicked = index;
    isItemOutOfStock = productdetail?.items[index].stock == 0;

    setState(() {});
  }
  void _addToCart(int index) {
    if (isclicked != null) {
      bool isProductInCart = false;

      // Check if the product with the selected size is already in the cart
      final cartState = BlocProvider.of<CartBloc>(context).state;
      if (cartState is CartLoaded) {
        isProductInCart = cartState.carts.any((item) =>
        item.id == productdetail?.id && item.items[index].size == productdetail?.items[isclicked!].size
        );
      }

      if (isProductInCart) {
        print("quatity updated");
        Fluttertoast.showToast(
          msg: "Quantity updated in cart!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        BlocProvider.of<CartBloc>(context).add(
          AddToCart(
            productId: productdetail?.id ?? 0,
            size: productdetail?.items[index].size ?? '',
          ),
        );
        Fluttertoast.showToast(
          msg: "Product added to cart successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      setState(() {
        isAddedToCart = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final productdetails = widget.;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: CustomColor.primaryColor,
          // onPressed: isAddedToCart?null:() {
          //   if (isclicked != null) {
          //     BlocProvider.of<CartBloc>(context).add(
          //       AddToCart(
          //         productId: productdetail?.id??0,
          //         size: productdetail?.items?[isclicked!].size??'',
          //       ),
          //     );
          //     print('Product ID: ${productdetail?.id}');
          //     print('Selected Size: ${productdetail?.items?[isclicked!].size}');
          //     setState(() {
          //
          //     });
          //
          //     //here add a flutter toast
          //     Fluttertoast.showToast(
          //       msg: "Product added to cart successfully!",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.BOTTOM,
          //       backgroundColor: Colors.green,
          //       textColor: Colors.white,
          //       fontSize: 16.0,
          //     );
          //
          //   }
          //
          // },
          onPressed: isclicked != null ? () => _addToCart(isclicked!) : null,
          label: Container(
            height: 30.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: CustomColor.primaryColor,
            ),
            child: Center(
              child:  Text(
                "Add to cart",
                style: CustomFont().buttontext,
              ),
            ),
          ),
          icon: IconButton(
            color: Colors.white,
            onPressed: () {

            },
            icon: Icon(
              Icons.shopping_cart,
              size: 20.sp,
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: productdetail?.name ?? '',
            leading: InkWell(
              onTap: () {
                final navigationProvider =
                Provider.of<NavigationProvider>(context, listen: false);
                navigationProvider.updateScreenIndex(0);
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
            action: [
              Stack(
                children: [
                  Container(
                    height: 100.h,
                    width: 100.w,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                      },
                      icon: Icon(Icons.shopping_cart_outlined, size: 30.sp),
                    ),
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      int cartItemCount = 0;
                      if (state is CartLoaded) {
                        carts = state.carts;
                        state.carts.forEach((cart) {
                          cartItemCount=cart.items.length;
                          print("Cart ID: ${cart.id}, Items: ${cart.items.length}");
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
                              cartItemCount.toString(),
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),

        // PreferredSize(
        //     preferredSize: Size.fromHeight(50.h),
        //     child: CustomAppBar(
        //       text: productdetail?.name ?? '',
        //       leading: InkWell(
        //           onTap: () {
        //             final navigationProvider =
        //             Provider.of<NavigationProvider>(context, listen: false);
        //             navigationProvider.updateScreenIndex(0);
        //             Navigator.pop(context);
        //           },
        //           child: Icon(Icons.arrow_back)),
        //       action: [
        //         Stack(
        //           children: [
        //             Container(
        //               height: 100.h,
        //               width: 100.w,
        //               child: IconButton(onPressed: (){
        //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
        //               }, icon: Icon(Icons.shopping_cart,size: 30.sp,)),
        //
        //             ),
        //             Positioned(
        //               right: 40.w,
        //                 top: 5.h,
        //                 child: Container(
        //                     height: 15.h,
        //                     width: 15.w,
        //                     decoration: BoxDecoration(
        //                       color: Colors.purple.withOpacity(0.4),
        //                       borderRadius: BorderRadius.circular(10.r),
        //                     ),
        //                     child: Center(child: Text(cartItemCount.toString(),style: GoogleFonts.poppins(color: Colors.white),))))
        //           ],
        //         )
        //       ],
        //     )),
        body: MultiBlocListener(
            listeners: [
              BlocListener<ProductBloc, ProductState>(
                listener: (context, state) {
                  print(state);
                  if (state is DetailsLoaded) {
                    productdetail=state.productdetail;
                    print(productdetail);
                    tappingfun(0);
                    setState(() {});
                    print(productdetail);
                  }
                  else {
                    Center(
                      child: Text("Unknown state"),
                    );
                  }
                },
              ),

              BlocListener<WhishlistBloc, WishlistState>(
                listener: (context, state) {
                  print(state);
                  if (state is addtoWishlistLoading) {
                    setState(() {

                    });

                  } else if (state is addtoWishlistSuccess) {
                    print("adding to whislisttt");
                    setState(() {
                      wishlistProductIds.add(productdetail?.id ?? 0);
                    });
                    //Navigator.pop(context);

                    //BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
                  } else if (state is addtoWishlistFailure) {
                    Navigator.pop(context);

                  } else if (state is WishlistSuccess) {
                    // loading=false;
                    whishlist = state.whishlists;
                    wishlistProductIds.clear();
                    for (var i = 0; i <= whishlist.length; i++) {
                      wishlistProductIds.add(whishlist[i].product??0);
                    }
                    setState(() {});
                    print(whishlist.length);
                    print(whishlist[0]);
                    print("oooooooooooooooo");

                  } else if (state is RemoveWishlistSuccess) {
                    setState(() {
                      whishlist.removeWhere(
                              (item) => item.id == state.removedProductId);
                    });

                  } else if (state is RemoveWishlistFailure) {

                  }
                },
              ),
              BlocListener<CartBloc, CartState>(listener: (context, state) {
                print(state);
                if (state is addtoCartLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        Center(child: CircularProgressIndicator()),
                  );
                }
                else if (state is CartLoaded) {
                  cartItemCount = state.carts.length;
                }else if (state is addtoCartSuccess) {
                  print("adding to cart");
                  // Navigator.pop(context);
              setState(() {

                   });

                } else if (state is addtoCartError) {
                  //Navigator.pop(context);

                }
              }),
            ],
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: isLoading
                    ? Center(
                  child: LoadingAnimationWidget.prograssiveDots(
                    color: Colors.purple,
                    size: 50.w,
                  ),
                ): Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 500.h,
                          width: 600.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.r),
                              topLeft: Radius.circular(30.r),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(productdetail?.image ??
                                  ""),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                    Positioned(
                      top: 20.h,
                      right: 20.w,
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              if (wishlistProductIds
                                  .contains(productdetail?.id)) {
                                print("remove${productdetail?.id}");
                                final wishlistItem = whishlist.firstWhere(
                                        (item) =>
                                    item.product == productdetail?.id);
                                BlocProvider.of<WhishlistBloc>(context).add(
                                  Removefromwishlist(wishlistItem.id ?? 0),
                                );
                                wishlistProductIds
                                    .remove(productdetail?.id ?? 0);
                              } else {
                                print("added${productdetail?.id}");
                                BlocProvider.of<WhishlistBloc>(context).add(
                                    AddToWishlist(productdetail?.id ?? 0));
                                wishlistProductIds
                                    .add(productdetail?.id ?? 0);
                                print(productdetail?.id ?? 0);
                              }
                            });
                          },
                          child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius:
                                  BorderRadius.circular(20.r)),
                              child: Icon(
                                isInWishlist(productdetail?.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 25.sp,
                                color: isInWishlist(productdetail?.id)
                                    ? Colors.red
                                    : Colors.grey,
                              ))),
                    ),
                    ]
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productdetail?.name ?? '',
                            style: CustomFont().subtitleText,
                          ),
                          Row(
                            children: [
                              Icon(Icons.currency_rupee),
                              Text(
                                productdetail?.price ?? '',
                                style: CustomFont().subtitleText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 18.w),
                      child: productdetail == null
                          ? null
                          : productdetail!.items.isEmpty
                          ? Center(
                        child: Text(
                          'Out of Stock',
                          style: CustomFont().subtitleText.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          :Container(
                        height: 50.h,
                         width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            //physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productdetail?.items.length,
                            itemBuilder: (context, index) {
                              final item = productdetail!.items[index];
                              print("sizessss${item}");
                              print(productdetail?.items.length);
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: (){
                                    tappingfun(index);
                                  },
                                  child: Container(
                                    height: 20.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                        color: isclicked == index
                                            ? Color(0xFF973d93)
                                            : Colors.black12,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(item?.size ?? "s",
                                            style: CustomFont().subtitleText)),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      productdetail?.description ?? '',
                      style: CustomFont().bodyText,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      width: 550.w,
                    ),
                    SizedBox(height: 50.h,),
                  ],
                ),
              ),
            )));
  }
}
