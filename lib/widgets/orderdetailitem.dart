
import 'dart:ui';

import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailitem extends StatefulWidget {
  OrderDetailitem({super.key, this.ontapremove, this.image, this.title, this.orderstatus, this.itemcount, this.type, this.invoicedwnld, this.quatity, this.returnstatus, this.text});
  final String? image;
  final String? itemcount;
  final int? quatity;
  final String? title;
  final String? text;
  final String? orderstatus;
  final String? returnstatus;
  final String? type;
  final VoidCallback? ontapremove;
  final VoidCallback? invoicedwnld;

  @override
  State<OrderDetailitem> createState() => _OrderDetailitemState();
}

class _OrderDetailitemState extends State<OrderDetailitem> {

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
                    SizedBox(
                      width:200.w,
                      child: Text(
                        widget.title??
                            "Apple fifteen pro max",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp)),
                      ),
                    ),
                    Row(
                      children: [
                        Text("Order status : "),
                        Text(
                          widget.orderstatus??""
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment method   : ",
                          style: CustomFont().bodyText,
                        ),
                        Text(
                          widget.type??"",
                          style:  GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp),),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("items : "),
                        Text(widget.quatity.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Return Status : "),
                        Text(widget.returnstatus??''),
                      ],
                    )
                  ],
                ),

                InkWell(
                  onTap: widget.invoicedwnld,
                  child: Container(
                    height: 20.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: CustomColor.buttoniconColor)),
                    child: Center(child: Icon(Icons.download,color: Colors.black54,),),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: widget.ontapremove,
              child: Container(
                height: 30.h,
                width: 200.w,
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(color: Colors.purple)
                ),
                child: Center(child: Text(widget.text??"")),
              ),
            ),
          )

        ],
      ),
    );
  }
}






