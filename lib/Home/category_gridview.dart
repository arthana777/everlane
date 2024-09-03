import 'package:everlane/bloc/category_bloc.dart';
import 'package:everlane/data/navigation_provider/navigation_provider.dart';
import 'package:everlane/product_detail/product_details.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../bloc/product/product_bloc.dart';
import '../bloc/whishlist/whishlist_bloc.dart';
import '../bloc/whishlist/whishlist_event.dart';
import '../bloc/whishlist/whishlist_state.dart';
import '../data/models/product_model.dart';
import '../data/models/whishlistmodel.dart';
import '../domain/entities/category_entity.dart';
import '../productgrid/product_card.dart';
import '../widgets/customcircularindicator.dart';

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
                if (state is addtoWishlistLoading) {
                  // setState(() {
                  //   isLoading=true;
                  // });
                } else if (state is addtoWishlistSuccess) {
                  print("adding to whislisttt");
                 // Navigator.pop(context);
                 //  setState(() {
                 //    isLoading=false;
                 //  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Product added to wishlist successfully!')),
                  );
                  BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
                } else if (state is addtoWishlistFailure) {
                  // Dismiss loading indicator and show error message
                 // Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
                else if (state is WishlistSuccess) {
                  // loading=false;
                  whishlist = state.whishlists;
                  wishlistProductIds = whishlist.map((item) => item.product??0).toList();
                  // for(var i=0;i<=whishlist.length;i++){
                  //   wishlistProductIds.add(whishlist[i].product);
                  // }
                  print(whishlist.length);
                  print(whishlist[0]);
                  print("oooooooooooooooo");
                  setState(() {

                  });

                }
                else if (state is RemoveWishlistSuccess) {
                  setState(() {
                    whishlist.removeWhere((item) => item.id == state.removedProductId);
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
          ],
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: isLoading
                ? CustomCircularProgressIndicator():GridView.builder(
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
                          print("wishlist length${whishlist.length}");
                          setState(() {
                            if  (wishlistProductIds.contains(filtercategories[index]?.id) ){
                              print("remove${filtercategories[index]?.id}");
                              BlocProvider.of<WhishlistBloc>(context)
                                  .add(Removefromwishlist(whishlist[index].product??0),
                              );
                              wishlistProductIds.remove(filtercategories[index]?.id??0);
                                setState(() {
                                  isLoading=false;
                                });
                            }else{
                              setState(() {
                                isLoading=false;
                              });
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
