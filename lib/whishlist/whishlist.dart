
import 'package:everlane/whishlist/whishlistitem.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/whishlist/whishlist_bloc.dart';
import '../bloc/whishlist/whishlist_event.dart';
import '../bloc/whishlist/whishlist_state.dart';
import '../data/models/whishlistmodel.dart';
import '../data/navigation_provider/navigation_provider.dart';
import '../product_detail/product_details.dart';


class Whishlist extends StatefulWidget {
  const Whishlist({super.key});

  @override
  State<Whishlist> createState() => _WhishlistState();
}

class _WhishlistState extends State<Whishlist> {
  List<WhislistProduct>whishlist = [];
  List<int> wishlistProductIds = [];


  @override
  void initState() {
    BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
    super.initState();
  }
  bool loading=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFEFEFEF),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: CustomAppBar(
              text: 'My Wishlist',
              leading: InkWell(
                onTap: () {
                  final navigationProvider =
                  Provider.of<NavigationProvider>(context, listen: false);
                  navigationProvider.updateScreenIndex(0);
                  Navigator.pop(context,);
                },
                child: Icon(Icons.arrow_back),
              ),
            )),
        body: MultiBlocListener(
          listeners: [
            BlocListener<WhishlistBloc, WishlistState>(
                listener: (context, state) {
              print("pppppppppp$state");
              if (state is WishlistLoading||state is RemoviewishlistLoading) {

                setState(() {
                  loading=false;
                });
                // Show loading indicator

              } else if (state is WishlistSuccess) {

                setState(() {
                  loading=false;
                  whishlist = state.whishlists;
                  wishlistProductIds = whishlist.map((item) => item.product??0).toList();
                });

              }

              else if (state is WishlistFailure) {
              // Navigator.pop(context);

              }
              else if(state is RemoveWishlistSuccess){
                // setState(() {
                //   whishlist.removeWhere((item) => item.product == state.removedProductId);
                // });
                whishlist.removeWhere(
                        (item) => item.product == state.removedProductId);
                wishlistProductIds.remove(state.removedProductId);
                loading = false;
                Fluttertoast.showToast(
                  msg: "product removed Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0,
                );
                print("Item removed, updated wishlist: $whishlist");

              }
              else if (state is RemoveWishlistFailure) {
                setState(() {
                  loading = false;
                });
              }
              }),
          ],
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
              loading?Center(child: CircularProgressIndicator()):SizedBox(
                  child:whishlist.isEmpty?Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 130.w,vertical: 300.h),
                    child: Text('" wishlist empty "',style: CustomFont().subtitleText,),
                  ): ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: whishlist.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        // onTap: (){
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ProductDetails(
                        //           productId: whishlist[index].product ?? 0,
                        //         )),
                        //   );
                        // },
                        onTap: (){

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                productId:whishlist[index].product ?? 0,
                                isWishlisted: wishlistProductIds.contains(whishlist[index].product ?? 0,
                              ),
                            ),
                            ),
                          ).then((isWishlisted) {
                            setState(() {
                              if (isWishlisted != null && isWishlisted) {
                                wishlistProductIds.add(whishlist[index].product ?? 0,);
                              } else {
                                wishlistProductIds.remove(whishlist[index].product ?? 0,);
                              }
                            });
                          });

                          context.read<ProductBloc>().add(
                            LoadDetails(whishlist[index].product ?? 0,),
                          );
                        },
                        child: WhishlistItem(
                          removeonTap: (){
                            setState(() {
                              wishlistProductIds.remove(
                                  whishlist[index].product ?? 0);
                              whishlist.removeAt(index);
                              Fluttertoast.showToast(
                                msg: "product removed Successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0,
                              );
                            });
                            BlocProvider.of<WhishlistBloc>(context)
                                .add(Removefromwishlist(whishlist[index].product??0),
                            );


                        },
                          text: whishlist[index].name??'',
                          image: whishlist[index].image??"",
                          price: whishlist[index].price??0.0,
                          description: whishlist[index].description??""

                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ));
  }
}
