import 'package:everlane/bloc/question_result/bloc/question_result_bloc.dart';
import 'package:everlane/bloc/question_result/bloc/question_result_event.dart';
import 'package:everlane/bloc/question_result/bloc/question_result_state.dart';
import 'package:everlane/data/models/product_model.dart';
import 'package:everlane/product_detail/product_details.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:everlane/data/datasources/qst_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/product/product_bloc.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    List<Product> product = [];
    List<int> wishlistProductIds = [];
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Recommended Product",
          style: CustomFont().appbarText,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) =>
            QuestionResultBloc(QstService())..add(FetchProduct()),
        child: BlocBuilder<QuestionResultBloc, QuestionResultState>(
          builder: (context, state) {
            if (state is QuestionResultLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuestionResultLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of items per row
                    childAspectRatio: 0.63,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    // Aspect ratio of each item
                  ),
                  itemCount:
                      state.qstresult.length, // Assuming qstresults is a list
                  itemBuilder: (context, index) {
                    final product = state.qstresult[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              productId: state.qstresult[index].id ?? 0,
                              isWishlisted: wishlistProductIds.contains(state.qstresult[index].id ?? 0,),
                            ),
                          ),
                        ).then((isWishlisted) {
                          setState(() {
                            if (isWishlisted != null && isWishlisted) {
                              wishlistProductIds.add(state.qstresult[index].id ?? 0,);
                            } else {
                              wishlistProductIds.remove(state.qstresult[index].id ?? 0,);
                            }
                          });
                        });

                        context.read<ProductBloc>().add(
                          LoadDetails(state.qstresult[index].id ?? 0,),
                        );
                      },
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ProductDetails(
                      //               productId: state.qstresult[index].id ?? 0,
                      //             )),
                      //   );
                      // },
                      child: Container(
                        height: 350.h,
                        width: 175.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10).w,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 210.h,
                                width: 210.h,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 200.h,
                                      width: 200.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10).w,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            product.image ?? '',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Container(
                                          height: 30.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          // child: InkWell(
                                          //   onTap: ontap,
                                          //   child: Center(
                                          //     child: Icon(
                                          //       isInWishlist
                                          //           ? Icons.favorite
                                          //           : Icons.favorite_border,
                                          //       size: 20.sp,
                                          //       color: isInWishlist
                                          //           ? Colors.red
                                          //           : Colors.grey,
                                          //     ),
                                          //   ),
                                          // ),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ).r,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                      child: Text(
                                        product.description ?? "",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500)),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Text(
                                      product.name ?? "",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey)),
                                      maxLines: 1,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            '${product.price?.toString() ?? "N/A"}',
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.green))),
                                        SizedBox(
                                          width: 60.w,
                                        ),
                                        Text('5',
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 12.sp))),
                                        const Icon(
                                          Icons.star_outlined,
                                          color: Colors.yellow,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is QuestionResulError) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const Center(child: Text("No data"));
              //${product.name ??} "",,'${product.price?.toString() ?? "N/A"}', product.image ?? '',
            }
          },
        ),
      ),
    );
  }
}
