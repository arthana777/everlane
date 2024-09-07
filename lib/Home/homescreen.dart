import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:everlane/Home/searchscreen.dart';
import 'package:everlane/Home/seasons/seasongridview.dart';
import 'package:everlane/bloc/cart/cart_bloc.dart';
import 'package:everlane/bloc/product/product_bloc.dart';
import 'package:everlane/product_detail/product_details.dart';
import 'package:everlane/questionnaire/qstmodalbottomsheet.dart';
import 'package:everlane/sharedprefrence/sharedprefs_login.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/category_bloc.dart';
import '../bloc/whishlist/whishlist_bloc.dart';
import '../bloc/whishlist/whishlist_event.dart';
import '../bloc/whishlist/whishlist_state.dart';
import '../data/models/product_model.dart';
import '../data/models/whishlistmodel.dart';
import '../domain/entities/category_entity.dart';
import '../donation/donationscreen.dart';
import '../widgets/customcolor.dart';
import 'category_gridview.dart';
import '../productgrid/product_card.dart';
import '../widgets/customfont.dart';
import 'seasons/category_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryEntity> categories = [];
  List<CategoryEntity> banners = [];
  List<Product> products = [];
  List<Product> seasons = [];
  List<Product> filtercategories = [];
  List<CategoryEntity> subcategories = [];
  List<WhislistProduct> whishlist = [];
  List<int> wishlistProductIds = [];
  int? isclicked;
  bool isLoading = true;

  SharedPrefeService sp = SharedPrefeService();

  CustomColor customColor = CustomColor();

  final List<Map<String, String>> seasonbanner = [
    {
      'id': '1',
      'title': 'winter',
      'image':
          //'image': "https://drive.google.com/file/d/159d9IK0BY8I_99FxxkuTzU1mpkTaf17y/view?usp=sharing",

      'https://img.freepik.com/free-photo/view-snowman-with-winter-landscape-snow_23-2150635358.jpg?ga=GA1.1.1985107230.1716028092&semt=ais_hybrid'
    },
    {
      'id': '2',
      'title': 'summer',
      'image':
          'https://media.istockphoto.com/id/1465451690/photo/beach-umbralla-and-chair-on-sand-summer-holiday-travel-background.jpg?s=612x612&w=0&k=20&c=ChGTBog7Px_3uTkdCINE43kNf4qM2EZ-pkLzvYq5Wzs='
    },
    {
      'id': '3',
      'title': 'rainy',
      'image':
          'https://img.freepik.com/free-photo/young-woman-walking-rain-with-umbrella_1303-22538.jpg?ga=GA1.1.1985107230.1716028092&semt=ais_hybrid',
    },
    {
      'id': '4',
      'title': 'autumn',
      'image':
      'https://img.freepik.com/free-photo/view-from-flat-lay-woman-style-accessories-autumn-leaves-fashion-trend-vintage-photo-camera-traveler-outfit_285396-5107.jpg?ga=GA1.1.1985107230.1716028092&semt=ais_hybrid',
    },
  ];

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(LoadCategories());
    BlocProvider.of<CategoryBloc>(context).add(LoadBanners(1));
    BlocProvider.of<ProductBloc>(context).add(LoadProducts());
    BlocProvider.of<CategoryBloc>(context).add(LoadSubCategories(1));
    BlocProvider.of<WhishlistBloc>(context).add(RetrieveWhishlist());
    sp.getToken();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });

    //BlocProvider.of<ProductBloc>(context).add(LoadSeasons(seasonbanner[1]['title']??""));
    // context.read<CategoryBloc>().add(
    //     LoadBanners()
    super.initState();
  }

  void tappingfun(int index) {
    isclicked = index;
    setState(() {});
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.white,
      ),
    );
  }

  Widget shimmerCategories() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 8, // You can adjust the number to your need
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  width: 60.w,
                  height: 10.h,
                  color: Colors.black12,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget shimmerBanner() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 600.h,
        color: Colors.white,
      ),
    );
  }

  Widget shimmerTrending() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 20, right: 00),
            child: Container(
              height: 200.h,
              width: 170.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            )),
      ),
    );
  }

  Widget shimmerSeasons() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: seasonbanner.length,
          itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 4),
              child: Container(
                height: 200.h,
                color: Colors.white,
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            elevation: 6,
            backgroundColor: CustomColor.primaryColor,
            onPressed: () {
              Qstmodalbottomsheet.moreModalBottomSheet(context);
            },
            label: Container(
              height: 30.h,
              decoration: const BoxDecoration( 
                color: CustomColor.primaryColor,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.question_mark_sharp,
                size: 20.sp,
                color: CustomColor.buttoniconColor,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            titleSpacing: 20,
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            //leading: leading,
            leadingWidth: 20.w,
            surfaceTintColor: Colors.white,
            toolbarHeight: 70.h,
            //leadingWidth: 20,
            title: Text("Everlane Style", style: CustomFont().appbarText),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Searchscreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.search_rounded,
                          size: 30.sp,
                        )),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DonationHomeScreen(),
                            ),
                          );
                        },
                        child:Container(
                          height: 25.h,
                          width: 25.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/128/2967/2967188.png',
                                ),
                            fit: BoxFit.cover)
                          ),
                        ),
                    ),
                  ],
                ),
                // padding: const EdgeInsets.only(left: 15),
              ),
            ],
          ),

          body: MultiBlocListener(
              listeners: [
                BlocListener<CategoryBloc, CategoryState>(
                  listener: (context, state) {
                    if (state is CategoryLoaded) {
                      categories = state.categories;
                      context.read<CategoryBloc>().add(
                            LoadSubCategories(categories[0].id ?? 0),
                          );
                      tappingfun(0);
                    }
                    if (state is BannerLoaded) {
                      banners = state.banners;
                      setState(() {});
                    }
                    if (state is SubCategoryLoaded) {
                      subcategories = state.subcategories;
                      setState(() {});
                    }
                    if (state is SubCategoryLoading) {}
                  },
                ),
                BlocListener<ProductBloc, ProductState>(
                  listener: (context, state) {
                    print(state);
                    if (state is ProductLoaded) {
                      products = state.products;
                      setState(() {});
                    } else if (state is SeasonsLoaded) {
                      seasons = state.seasons;
                      setState(() {});
                    } else if (state is filtercategoryLoaded) {
                      filtercategories = state.filtercategories;
                      setState(() {});
                    }
                  },
                ),
                BlocListener<WhishlistBloc, WishlistState>(
                  listener: (context, state) {
                    print(state);
                    if (state is addtoWishlistLoading) {
                           setState(() {
                             isLoading=false;
                           });
                    } else if (state is addtoWishlistSuccess) {
                      print("adding to whislisttt");
                      setState(() {
                        isLoading=false;
                      });
                      BlocProvider.of<WhishlistBloc>(context)
                          .add(RetrieveWhishlist());
                    } else if (state is addtoWishlistFailure) {

                      setState(() {
                        isLoading=false;
                      });
                    } else if (state is WishlistSuccess) {
                      // loading=false;
                      whishlist = state.whishlists;
                      wishlistProductIds = whishlist.map((item) => item.product??0).toList();
                      // for (var i = 0; i <= whishlist.length; i++) {
                      //   wishlistProductIds.add(whishlist[i].product??0);
                      // }
                      setState(() {
                        isLoading=false;
                      });
                    } else if (state is RemoveWishlistSuccess) {
                      setState(() {
                        isLoading=false;
                        whishlist.removeWhere(
                            (item) => item.id == state.removedProductId);
                      });
                    } else if (state is RemoveWishlistFailure) {

                    }
                  },
                ),
              ],
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 400.w,
                        child: isLoading
                            ? buildShimmer()
                            : ListView.separated(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 5),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      tappingfun(index);
                                      context.read<CategoryBloc>().add(
                                            LoadSubCategories(
                                                categories[index].id ?? 0),
                                          );
                                      context.read<CategoryBloc>().add(
                                            LoadBanners(
                                                categories[index].id ?? 0),
                                          );
                                    });
                                  },
                                  child: Container(
                                    // height: 40.h,
                                    width: 360.w / 2,
                                    decoration: BoxDecoration(
                                        color: isclicked == index
                                            ? Color(0xFF973d93)
                                            : Color(0xFF973d93)
                                                .withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: Center(
                                        child: Text(
                                      categories[index].name ?? 'text',
                                      style: CustomFont().buttontext,
                                    )),
                                  ),
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 5.w,
                                  );
                                },
                              ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, top: 30.h, bottom: 5.w),
                        child: Text(
                          "Categories ",
                          style: CustomFont().subtitleText,
                        ),
                      ),
                      SizedBox(
                        height: 110.h,
                        child: isLoading
                            ? shimmerCategories()
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 18),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: subcategories.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            context.read<ProductBloc>().add(
                                                Loadfiltercategories(
                                                    subcategories[index].id ??
                                                        0));
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryGridview(
                                                  subcategoryName:
                                                      subcategories[index]
                                                              .name ??
                                                          "",
                                                  productId:
                                                      subcategories[index].id ??
                                                          0,
                                                ),
                                              ),
                                            );

                                            //context.read<ProductBloc>().add(LoadProducts());
                                          },
                                          child: Container(
                                            height: 80.h,
                                            width: 80.w,
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      subcategories[index]
                                                              .image ??
                                                          'https://media.istockphoto.com/id/1176789549/photo/handsome-gentleman-downtown.jpg?s=1024x1024&w=is&k=20&c=psf6n8f2mWlkiCxZKh4LHJeEjda-4dv4H734xm8MBiA='),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 15.h,
                                            child: Text(
                                              subcategories[index].name ?? "",
                                              style: CustomFont().bodyText,
                                            )),
                                      ],
                                    ),
                                  );
                                }),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      isLoading
                          ? shimmerBanner()
                          : CarouselSlider(
                              options: CarouselOptions(
                                  height: 600.0.h,
                                  aspectRatio: 5.0,
                                  viewportFraction: 1,
                                  autoPlay: true),
                              items: banners.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black26,
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(i.image ?? ''),
                                              fit: BoxFit.cover)),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 30.h, bottom: 10.h),
                        child: Text(
                          "Trending",
                          style: CustomFont().subtitleText,
                        ),
                      ),
                      SizedBox(
                        height: 300.h,
                        child: isLoading
                            ? shimmerTrending()
                            : ListView.builder(
                                padding: EdgeInsets.all(4),
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(
                                      left: 20.w,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                              productId:
                                                  products[index].id ?? 0,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ProductCard(
                                          ontap: () {
                                            print(
                                                "wishlist length${whishlist.length}");
                                            setState(() {
                                              if (wishlistProductIds.contains(
                                                  products[index]?.id)) {
                                                print(
                                                    "remove${products[index]?.id}");
                                                BlocProvider.of<WhishlistBloc>(
                                                        context)
                                                    .add(
                                                  Removefromwishlist(
                                                      products[index].id??0),
                                                );
                                                wishlistProductIds.remove(products[index]?.id??0);

                                              } else {
                                                print(
                                                    "added${products[index]?.id}");
                                                BlocProvider.of<WhishlistBloc>(
                                                        context)
                                                    .add(AddToWishlist(
                                                        products[index]?.id ??
                                                            0));
                                                wishlistProductIds.add(
                                                    products[index]?.id ?? 0);
                                                print(products[index]?.id ?? 0);
                                              }
                                            });
                                          },
                                          title: products[index].name ?? '',
                                          subtitle:
                                              products[index].description ?? '',
                                          image: products[index].image ??
                                              'https://plus.unsplash.com/premium_photo-1706727290668-f6b805ea48da?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyfHx8ZW58MHx8fHx8',
                                          price: products[index].price ?? "",
                                          isInWishlist: wishlistProductIds
                                              .contains(products[index]?.id)),
                                      // isInWishlist: whishlist.any((item) => item.id == products[index].id),
                                    )),
                              ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10).w,
                        child: Text(
                          "Seasons",
                          style: CustomFont().subtitleText,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 950.h,
                        child: isLoading
                            ? shimmerSeasons()
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: seasonbanner.length,
                                itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w,
                                          right: 10.w,
                                          top: 1.h,
                                          bottom: 4.h),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Seasongridview(
                                                  seasonName:
                                                      seasonbanner[index]
                                                              ['title'] ??
                                                          "",
                                                ),
                                              ),
                                            );
                                            context.read<ProductBloc>().add(
                                                  LoadSeasons(
                                                      seasonbanner[index]
                                                              ['title'] ??
                                                          ''),
                                                );
                                            // context.read<ProductBloc>().add(LoadProducts());
                                          },
                                          child: CategoryBanner(
                                            title: seasonbanner[index]['title'],
                                            image: seasonbanner[index]['image'],
                                          )),
                                    )),
                      ),
                    ]),
              ))),
    );
  }
}
