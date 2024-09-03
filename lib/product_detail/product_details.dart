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
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/address/address_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/whishlist/whishlist_bloc.dart';
import '../bloc/whishlist/whishlist_event.dart';
import '../bloc/whishlist/whishlist_state.dart';
import '../btm_navigation/btm_navigation.dart';
import '../checkout/address_list.dart';
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
  List<int> wishlistProductIds = [];
  List<WhislistProduct> whishlist = [];
  DetailProduct? productdetail;
  int? isclicked;
  bool isAddedToCart = false;
  bool isItemOutOfStock = false;
  bool isInWishlist(int? productId) {
    return wishlistProductIds.contains(productId);
  }
  //bool isInWishlist=wishlistProductIds.contains(productde?.id));
@override
  void initState() {
  BlocProvider.of<ProductBloc>(context).add(LoadDetails(widget.productId));
    super.initState();
  }
  void tappingfun(int index) {
    isclicked = index;
    isItemOutOfStock = productdetail?.items?[index].stock == 0;

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    // final productdetails = widget.;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: CustomColor.primaryColor,
          onPressed: isAddedToCart?null:() {
            if (isclicked != null) {
              BlocProvider.of<CartBloc>(context).add(
                AddToCart(
                  productId: productdetail?.id??0,
                  size: productdetail?.items?[isclicked!].size??'',
                ),
              );
              print('Product ID: ${productdetail?.id}');
              print('Selected Size: ${productdetail?.items?[isclicked!].size}');
              setState(() {

              });

              //here add a flutter toast
              Fluttertoast.showToast(
                msg: "Product added to cart successfully!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );

            }

          },
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
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  // final navigationProvider =
                  //     Provider.of<NavigationProvider>(context, listen: false);
                  // navigationProvider.updateScreenIndex(0);

                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => BtmNavigation()),
                  //   (Route<dynamic> route) => false,
                  // );
                },
              ),
            )),
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
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is addtoWishlistSuccess) {
                    print("adding to whislisttt");
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                          Text('Product added to wishlist successfully!')),
                    );
                    //BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
                  } else if (state is addtoWishlistFailure) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  } else if (state is WishlistSuccess) {
                    // loading=false;
                    whishlist = state.whishlists;
                    for (var i = 0; i <= whishlist.length; i++) {
                      wishlistProductIds.add(whishlist[i].product??0);
                    }
                    print(whishlist.length);
                    print(whishlist[0]);
                    print("oooooooooooooooo");
                    setState(() {});
                  } else if (state is RemoveWishlistSuccess) {
                    setState(() {
                      whishlist.removeWhere(
                              (item) => item.id == state.removedProductId);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Item deleted successfully')),
                    );
                  } else if (state is RemoveWishlistFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
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
                } else if (state is addtoCartSuccess) {
                  print("adding to cart");
                  // Navigator.pop(context);


                } else if (state is addtoCartError) {
                  //Navigator.pop(context);

                }
              }),
            ],
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
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

                      ],
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
                      padding:  EdgeInsets.symmetric(horizontal: 50.w),
                      child: productdetail == null
                          ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 50.h,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      )
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
                        // color: Colors.orangeAccent,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productdetail?.items.length,
                            itemBuilder: (context, index) {
                              final item = productdetail!.items?[index];
                              print("sizessss${item}");
                              print(productdetail?.items?.length);
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: (){
                                    tappingfun(index);
                                  },
                                  child: Container(
                                    height: 20.h,
                                    width: 60.w,
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
                      style: CustomFont().subtitleText,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      width: 550.w,
                      child: Text(
                          "dfhjaskdaslcm ckvmeiocj dnkdnsv m kmf lfkc,mcv kfmn fhjaskdaslcm ckvmeiocj dnkdnsv m kmf lfkc,mcv k "),
                    ),
                    SizedBox(height: 50.h,),
                  ],
                ),
              ),
            )));
  }
}
