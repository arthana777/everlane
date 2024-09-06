import 'package:everlane/bloc/category_bloc.dart';
import 'package:everlane/data/navigation_provider/navigation_provider.dart';
import 'package:everlane/product_detail/product_details.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/whishlist/whishlist_bloc.dart';
import '../bloc/whishlist/whishlist_event.dart';
import '../bloc/whishlist/whishlist_state.dart';
import '../cartscreen/cartscreen.dart';
import '../data/models/cartmodel.dart';
import '../data/models/product_model.dart';
import '../data/models/whishlistmodel.dart';
import '../domain/entities/category_entity.dart';
import '../productgrid/product_card.dart';
import '../widgets/customcircularindicator.dart';
import '../widgets/customcolor.dart';

class CategoryGridview extends StatefulWidget {
  final String subcategoryName;
  final int productId;

  CategoryGridview({super.key, required this.subcategoryName, required this.productId});

  @override
  State<CategoryGridview> createState() => _CategoryGridviewState();
}

class _CategoryGridviewState extends State<CategoryGridview> {
  List<Product> filtercategories = [];
  List<Product> products = [];
  List<Cart> carts = [];
  List<WhislistProduct> whishlist = [];
  List<int> wishlistProductIds = [];
  List<CategoryEntity> subcategories = [];
  bool isLoading = true;
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(Loadfiltercategories(1));
    BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
    BlocProvider.of<ProductBloc>(context).add(Loadfiltercategories(widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: PreferredSize(preferredSize: Size.fromHeight(80.h), child: CustomAppBar(
          leading: InkWell(
              onTap: (){
                final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
                navigationProvider.updateScreenIndex(0);
               Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
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
                      top: 15.h,
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
          text:  widget.subcategoryName,)),
        body: MultiBlocListener(
          listeners: [

            BlocListener<ProductBloc, ProductState>(
              listener: (context, state) {
                print(state);
                if (state is filtercategoryLoading) {
                  setState(() {
                    isLoading = true; // Show loading indicator
                  });
                }
                 if (state is filtercategoryLoaded) {
                  filtercategories = state.filtercategories;
                  setState(() {
                    isLoading = false;
                  });

                  print("ssss${filtercategories.length}");
                  for (var i = 0; i < filtercategories.length; i++) {
                    print("GGGGG${filtercategories[i].id}");
                  }
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
                if (state is addtoWishlistLoading || state is RemoviewishlistLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
                else if (state is addtoWishlistSuccess) {
                  print("adding to whislisttt");
                 // Navigator.pop(context);

                  setState(() {
                    wishlistProductIds.add(state.addedProductId);
                    isLoading=false;
                  });

                  BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
                } else if (state is addtoWishlistFailure) {
                  // Dismiss loading indicator and show error message
                 // Navigator.pop(context);

                  setState(() {
                    isLoading = false;
                  });
                }
                else if (state is WishlistSuccess) {
                  // loading=false;
                  setState((){});
                  whishlist = state.whishlists;
                  wishlistProductIds = whishlist.map((item) => item.product??0).toList();
                  // for(var i=0;i<=whishlist.length;i++){
                  //   wishlistProductIds.add(whishlist[i].product);
                  // }
                  print(whishlist.length);
                  print(whishlist[0]);
                  print("oooooooooooooooo");
                  setState(() {
                    isLoading = false;
                  });

                }
                else if (state is RemoveWishlistSuccess) {

                  setState(() {
                    wishlistProductIds.remove(state.removedProductId);
                    isLoading = false;
                    //whishlist.removeWhere((item) => item.id == state.removedProductId);
                  });

                }
                else if (state is RemoveWishlistFailure) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          ],
          child: isLoading
              ? Center(
            child: LoadingAnimationWidget.prograssiveDots(
              color: Colors.purple,
              size: 50.w,
            ),
          ): Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.62,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                ),
                itemCount: filtercategories.length,
                itemBuilder: (BuildContext context, index) {
                  print("object${filtercategories[index].name}");
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetails(productId: filtercategories[index].id??0,)),
                        );
                        context.read<ProductBloc>().add(
                          LoadDetails(filtercategories[0].id??0),
                        );
                      },
                      child: ProductCard(
                        ontap: () {
                          setState(() {
                            if  (wishlistProductIds.contains(filtercategories[index]?.id) ){
                              print("remove${filtercategories[index]?.id}");
                              BlocProvider.of<WhishlistBloc>(context)
                                  .add(Removefromwishlist(filtercategories[index].id ?? 0),
                              );
                              wishlistProductIds.remove(filtercategories[index]?.id??0);
                                // setState(() {
                                //   isLoading=false;
                                // });
                            }else{
                              // setState(() {
                              //   isLoading=false;
                              // });
                              print("added${filtercategories[index]?.id}");
                              BlocProvider.of<WhishlistBloc>(context)
                                  .add(AddToWishlist(filtercategories[index]?.id ?? 0));
                              wishlistProductIds.add(filtercategories[index]?.id??0);
                              print(filtercategories[index]?.id ?? 0);
                            }
                          });
                        },
                        title: filtercategories[index].name??"no name",
                        subtitle: filtercategories[index].brand,
                        image: filtercategories[index].image??"",
                        price: filtercategories[index].price??'',
                        isInWishlist: wishlistProductIds.contains(filtercategories[index].id),
                        //isInWishlist: whishlist.any((item) => item.id == products[index].id),
                      ));
                }),
          ),
        ));
  }
}
