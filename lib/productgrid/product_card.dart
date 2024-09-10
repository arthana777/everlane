import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    this.ontap,
    this.cartOntap,
    required this.isInWishlist,
  });
  final String image;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback? ontap;
  final VoidCallback? cartOntap;
  final bool isInWishlist;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
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
                      borderRadius: BorderRadius.circular(10).w,
                      image: DecorationImage(
                        image: NetworkImage(
                          image,
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
                            borderRadius: BorderRadius.circular(20.r)),
                        child: InkWell(
                            onTap: ontap,
                            child: Center(
                                child: Icon(
                              isInWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20.sp,
                              color: isInWishlist ? Colors.red : Colors.grey,
                            ))),
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
                      subtitle,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500)),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                    child: Row(
                      children: [
                        Icon(Icons.currency_rupee),
                        Text(price,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14.sp, color: Colors.green))),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60.w,
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
