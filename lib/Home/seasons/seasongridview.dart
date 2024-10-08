import 'package:everlane/data/models/whishlistmodel.dart';
import 'package:everlane/data/navigation_provider/navigation_provider.dart';
import 'package:everlane/product_detail/product_details.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/whishlist/whishlist_bloc.dart';
import '../../bloc/whishlist/whishlist_event.dart';
import '../../bloc/whishlist/whishlist_state.dart';
import '../../btm_navigation/btm_navigation.dart';
import '../../cartscreen/cartscreen.dart';
import '../../data/models/cartmodel.dart';
import '../../data/models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../productgrid/product_card.dart';
import '../../widgets/cartcount.dart';
import '../../widgets/customcircularindicator.dart';

class Seasongridview extends StatefulWidget {
  final String seasonName;
  Seasongridview({
    super.key,
    required this.seasonName,
  });

  @override
  State<Seasongridview> createState() => _SeasongridviewState();
}

class _SeasongridviewState extends State<Seasongridview> {
  List<Product> seasons = [];
  List<Product> products = [];
  List<Cart> carts = [];
  List<WhislistProduct> whishlist = [];
  List<int> wishlistProductIds = [];
  bool isLoading = true;

  @override
  void initState() {
    // BlocProvider.of<ProductBloc>(context).add((Loadfiltercategories(1)));
    BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
    seasons.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              text: widget.seasonName,
              leading: InkWell(
                  onTap: () {
                    final navigationProvider =
                        Provider.of<NavigationProvider>(context, listen: false);
                    navigationProvider.updateScreenIndex(0);
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back)),
              action: [
                CartCount()
              ],
            )),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ProductBloc, ProductState>(
              listener: (context, state) {
                print(state);
                if (state is SeasonsLoading) {
                  setState(() {
                    isLoading = true; // Show loading indicator
                  });
                }
                else if (state is SeasonsLoaded) {
                  seasons = state.seasons;
                  setState(() {
                    isLoading = false;
                  });
                  print("ssss${seasons.length}");
                  for (var i = 0; i < seasons.length; i++) {
                    print("GGGGG${seasons[i].id}");
                  }
                }

                else {
                  const Center(
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
                    isLoading = false;
                  });
                } else if (state is addtoWishlistSuccess) {
                  print("adding to whislisttt");
                  setState(() {
                    wishlistProductIds.add(state.addedProductId);
                    isLoading=false;
                  });

                  BlocProvider.of<WhishlistBloc>(context)
                      .add(RetrieveWhishlist());
                } else if (state is addtoWishlistFailure) {
                  // Dismiss loading indicator and show error message
                  setState(() {
                    isLoading = false;
                  });
                } else if (state is WishlistSuccess) {
                  // loading=false;
                  whishlist = state.whishlists;
                  wishlistProductIds = whishlist.map((item) => item.product??0).toList();
                  //wishlistProductIds = whishlist.map((item) => item.product).toList();
                  // for (var i = 0; i < whishlist.length; i++) {
                  //   wishlistProductIds.add(whishlist[i].product??0);
                  // }
                  print(whishlist.length);
                  print(whishlist[0]);
                  print("oooooooooooooooo");
                  setState(() {});
                } else if (state is RemoveWishlistSuccess) {
                  setState(() {
                    wishlistProductIds.remove(state.removedProductId);
                    isLoading = false;
                    //whishlist.removeWhere((item) => item.id == state.removedProductId);
                  });

                } else if (state is RemoveWishlistFailure) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: isLoading
                ? CustomCircularProgressIndicator()
            :GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.62,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                ),
                itemCount: seasons.length,
                itemBuilder: (BuildContext context, index) {
                  print("object${seasons[index].name}");
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              productId: seasons[index].id ?? 0,
                              isWishlisted: wishlistProductIds.contains(seasons[index].id ?? 0),
                            ),
                          ),
                        ).then((isWishlisted) {
                          setState(() {
                            if (isWishlisted != null && isWishlisted) {
                              wishlistProductIds.add(seasons[index].id ?? 0);
                            } else {
                              wishlistProductIds.remove(seasons[index].id ?? 0);
                            }
                          });
                        });

                        context.read<ProductBloc>().add(
                          LoadDetails(seasons[0].id??0),
                        );
                      },
                      child: ProductCard(
                        ontap: () {
                          print("wishlist length${whishlist.length}");
                          setState(() {
                            if (wishlistProductIds
                                .contains(seasons[index].id)) {
                              print("remove${seasons[index].id}");
                              BlocProvider.of<WhishlistBloc>(context).add(
                                Removefromwishlist(whishlist[index].product??0),
                              );
                              wishlistProductIds
                                  .remove(seasons[index].id ?? 0);
                            } else {
                              print("added${seasons[index].id}");
                              BlocProvider.of<WhishlistBloc>(context)
                                  .add(AddToWishlist(seasons[index].id ?? 0));
                              wishlistProductIds.add(seasons[index].id ?? 0);
                              print(seasons[index].id ?? 0);
                            }
                          });
                        },
                        title: seasons[index].name ?? "no name",
                        subtitle: seasons[index].brand,
                        image: seasons[index].image ?? "",
                        price: seasons[index].price ?? '',
                        isInWishlist:
                            wishlistProductIds.contains(seasons[index].id),
                        // isInWishlist: whishlist.any((item) => item.id == seasons[index].id),
                      ));
                }),
          ),
        ));
  }
}
