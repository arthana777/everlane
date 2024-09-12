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
//import 'package:loading_animation_widget/loading_animation_widget.dart';
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
import '../widgets/cartcount.dart';
import '../widgets/customcolor.dart';

class ProductDetails extends StatefulWidget {
  final int productId;
  final bool isWishlisted;
  ProductDetails({Key? key, required this.productId,  required this.isWishlisted}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isWishlisted = false;
  int cartItemCount=0;
  List<int> wishlistProductIds = [];
  List<WhislistProduct> whishlist = [];
  DetailProduct? productdetail;
  List<Cart> carts = [];
  int? isclicked;
  bool isLoading = false;
  bool buttonloading=false;
  bool isAddedToCart = false;
  bool isItemOutOfStock = false;
  bool isInWishlist(int? productId) {
    return wishlistProductIds.contains(productId);
  }
  void toggleWishlist() {
    setState(() {
      _isWishlisted = !_isWishlisted;
      if (_isWishlisted) {
        // Add to wishlist logic
        BlocProvider.of<WhishlistBloc>(context).add(AddToWishlist(widget.productId));
      } else {
        // Remove from wishlist logic
        BlocProvider.of<WhishlistBloc>(context).add(Removefromwishlist(widget.productId));
      }
    });
  }

  //bool isInWishlist=wishlistProductIds.contains(productde?.id));
  @override
  void initState() {
    print("dcmhbjkj ${widget.productId}");
    BlocProvider.of<ProductBloc>(context).add(LoadDetails(widget.productId));
    BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
    _isWishlisted = widget.isWishlisted!;
    super.initState();
  }

  void tappingfun(int index) {
    print("is Clicked button$isclicked");
    print("is Clicked button$index");
    final item = productdetail?.items[index];

    if (item != null && item.stock > 0) {
      isclicked = index;
      isItemOutOfStock = false;
    } else {
      isItemOutOfStock = true;
    }

    setState(() {});
  }



  void _addToCart(int index) {
    if (isclicked == null) {
      Fluttertoast.showToast(
        msg: "Please select a size before adding to cart!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    if (isclicked != null) {
      bool isProductInCart = false;

      // Check if the product with the selected size is already in the cart
      final cartState = BlocProvider.of<CartBloc>(context).state;
      if (cartState is CartLoaded) {
        isProductInCart = cartState.carts.any((item) =>
        item.id == productdetail?.id &&
            item.items[index].size == productdetail?.items[isclicked!].size);
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
        // Fluttertoast.showToast(
        //   msg: "Product added to cart !",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   //toastDuration: Duration(seconds: 2),
        //   backgroundColor: Colors.green,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      }

      setState(() {
        isAddedToCart = true;
      });
    }
  }
 // int cartItemCount = 0;
  @override
  Widget build(BuildContext context) {
    // final productdetails = widget.;
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            print(state);
            if (state is DetailsLoaded) {
              productdetail = state.productdetail;
              print(productdetail);
              //tappingfun(0);
              setState(() {});
              print(productdetail);
            } else {
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
              setState(() {});
            } else if (state is addtoWishlistSuccess) {
              print("adding to whislisttt");
              setState(() {

                wishlistProductIds.add(productdetail?.id ?? 0);
              });
              //Navigator.pop(context);

              //BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
            } else if (state is addtoWishlistFailure) {
              //Navigator.pop(context);
            } else if (state is WishlistSuccess) {
              // loading=false;
              whishlist = state.whishlists;
              wishlistProductIds.clear();
              for (var i = 0; i <= whishlist.length; i++) {
                // wishlistProductIds.add(whishlist[i].product??0);
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
        BlocListener<CartBloc,CartState>(listener: (context, state) {
          print(state);
          if (state is CartLoaded) {
            cartItemCount = state.carts.length;
          } else if (state is addtoCartSuccess) {
setState(() {
  buttonloading=false;
});
            print("adding to cart");
            isAddedToCart=true;
            Fluttertoast.showToast(
              msg: "${state.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            BlocProvider.of<CartBloc>(context).add(FetchCartData());
            // Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
          } else if (state is addtoCartError) {
            //Navigator.pop(context);
            setState(() {
              buttonloading=false;
            });
          }
        }),

        // BlocListener<CartBloc, CartState>(listener: (context, state) {
        //   print(state);
        //   if (state is incrementloading) {
        //     isLoading = true;
        //     CircularProgressIndicator();
        //   } else if (state is incrementsuccess) {
        //     print("adding to cart");
        //     // Navigator.pop(context);
        //     setState(() {
        //       isLoading = false;
        //     });
        //   } else if (state is incrementerror) {
        //     //Navigator.pop(context);
        //     setState(() {
        //       isLoading = false;
        //     });
        //   }
        // }),
      ],
      child: Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: CustomColor.primaryColor,
              onPressed:
              (){
                if(isclicked != null ){
                  buttonloading=true;
                  setState(() {

                  });
                  _addToCart(isclicked!);

                }
                else{
                  Fluttertoast.showToast(
                    msg: "Please select a size before adding to cart!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              // isclicked != null ?
              //
              //     () => _addToCart(isclicked!) : null,

              label: Container(
                height: 30.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                ),
                child: buttonloading
                    ? Center(
                  child: LoadingAnimationWidget.prograssiveDots(
                    color: Colors.white,
                    size: 50.w,
                  ),
                )
                    : Center(
                  child: Text(
                    "Add to cart",
                    style: CustomFont().buttontext,
                  ),
                ),
              ),
              icon: IconButton(
                color: Colors.white,
                onPressed: () {},
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
                    widget.isWishlisted? BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist()):null;
                    Navigator.pop(context, _isWishlisted);

                  },
                  child: Icon(Icons.arrow_back),
                ),
                action: [
                  CartCount()
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Container(
                              height: 500.h,
                              width: 600.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.r),
                                  topLeft: Radius.circular(30.r),
                                ),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(productdetail?.image ?? ""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20.h,
                              right: 20.w,
                              child: InkWell(
                                  onTap:
                                    toggleWishlist,
                                    // setState(() {
                                    //   if (wishlistProductIds
                                    //       .contains(productdetail?.id)) {
                                    //     print("remove${productdetail?.id}");
                                    //     final wishlistItem =
                                    //         whishlist.firstWhere((item) =>
                                    //             item.product ==
                                    //             productdetail?.id);
                                    //     BlocProvider.of<WhishlistBloc>(context)
                                    //         .add(
                                    //       Removefromwishlist(
                                    //           wishlistItem.id ?? 0),
                                    //     );
                                    //     wishlistProductIds
                                    //         .remove(productdetail?.id ?? 0);
                                    //   } else {
                                    //     print("added${productdetail?.id}");
                                    //     BlocProvider.of<WhishlistBloc>(context)
                                    //         .add(AddToWishlist(
                                    //             productdetail?.id ?? 0));
                                    //     wishlistProductIds
                                    //         .add(productdetail?.id ?? 0);
                                    //     print(productdetail?.id ?? 0);
                                    //   }
                                    // });

                                  child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius:
                                              BorderRadius.circular(20.r)),
                                      child: Icon(
                                       // isInWishlist(productdetail?.id)
                                        _isWishlisted  ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 25.sp,
                                        color:
                                        //isInWishlist(productdetail?.id)
                                        _isWishlisted? Colors.red
                                            : Colors.grey,
                                      ))),
                            ),
                          ]),
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
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: productdetail == null
                                ? Center(
                                    child: Text(
                                      'Loading...',
                                      style: CustomFont().subtitleText,
                                    ),
                                  )
                                : productdetail!.items.isEmpty
                                    ? Center(
                                        child: Container(
                                          height: 40.h,
                                          width: 300.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    CustomColor.primaryColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.r)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Out of Stock',
                                              style: CustomFont()
                                                  .subtitleText
                                                  .copyWith(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 50.h,
                                        width: double.infinity,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            //physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                productdetail?.items.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  productdetail!.items[index];
                                              print("sizessss${item}");
                                              print(
                                                  productdetail?.items.length);
                                              return  Stack(
                                                  children: [
                                                Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: InkWell(
                                                  onTap: item.isOutOfStock
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            isclicked = index;
                                                          });
                                                          tappingfun(index);
                                                        },
                                                  child:
                                                      Container(
                                                        height: 35.h,
                                                        width: 70.w,
                                                        decoration: BoxDecoration(
                                                            color: isclicked ==
                                                                    index
                                                                ? Color(0xFF973d93)
                                                                : item.isOutOfStock
                                                                    ? Colors.white10
                                                                    : Colors
                                                                        .black12,
                                                            //border: item.isOutOfStock?Border.all(color: Colors.white):Border.all(color: CustomColor.primaryColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                          border: item.isOutOfStock?Border.all(color: Colors.red):null,
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                                item?.size ?? "s",
                                                                style: item
                                                                        .isOutOfStock
                                                                    ? GoogleFonts
                                                                        .questrial(
                                                                            textStyle:
                                                                                TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            12.sp,
                                                                      ))
                                                                    : CustomFont()
                                                                        .subtitleText)),
                                                      ),

                                                ),
                                              ),
                                              item.isOutOfStock? Positioned(
                                                  left: 22.w,
                                                  top: 5.h,
                                                  child: Icon(Icons.close,size: 30.sp,color: Colors.red.withOpacity(0.5),)
                                              ):SizedBox(),
                                              ],
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
                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
              ),
            )),
    );
  }
}