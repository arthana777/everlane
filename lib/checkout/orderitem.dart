import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_textbutton.dart';
import '../widgets/customfont.dart';

class OrderItem extends StatefulWidget {
  OrderItem({super.key, this.ontapremove, this.image, this.title, this.price, this.itemcount, this.size});
  final String? image;
  final String? itemcount;
  final String? title;
  final String? size;
  final double? price;
  final VoidCallback? ontapremove;

  @override
  State<OrderItem> createState() => _CartItemState();
}

class _CartItemState extends State<OrderItem> {

  late  String dropedownvalue1;
  @override
  void initState() {
    dropedownvalue1 = widget.itemcount ?? '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5.r),
                    image: DecorationImage(
                        image: NetworkImage(
                            widget.image??
                                "https://plus.unsplash.com/premium_photo-1658506787944-7939ed84aaf8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bWVuJTIwZmFzaGlvbnxlbnwwfHwwfHx8MA%3D%3D"),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title??
                          "Apple fifteen pro max",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp)),
                    ),
                    Row(
                      children: [
                        Icon(Icons.currency_rupee),
                        Text(
                          widget.price.toString()
                          ,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Text("size :  ",style: CustomFont().bodyText,),
                        Text(widget.size??'',style: CustomFont().subtitleText,),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
