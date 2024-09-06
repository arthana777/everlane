import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_textbutton.dart';
import '../widgets/customfont.dart';

class CartItemCard extends StatefulWidget {
  CartItemCard({super.key, this.ontapremove, this.image, this.title, this.price, this.itemcount, this.increased, this.decreased, this.movetowish, this.size});
final String? image;
final String? itemcount;
final String? title;
final String? size;
final double? price;
  final VoidCallback? ontapremove;
  final VoidCallback? movetowish;
  final VoidCallback? increased;
  final VoidCallback? decreased;

  @override
  State<CartItemCard> createState() => _CartItemState();
}

class _CartItemState extends State<CartItemCard> {

  int itemCount = 1;
  @override
  void initState() {
    itemCount = int.parse(widget.itemcount ?? '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                        image: NetworkImage(widget.image ??
                            "https://plus.unsplash.com/premium_photo-1658506787944-7939ed84aaf8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bWVuJTIwZmFzaGlvbnxlbnwwfHwwfHx8MA%3D%3D"),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            widget.title??
                                "",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp)),
                          ),
                        ),
                        SizedBox(width: 30.w,),
                        Text(widget.size??'')
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.currency_rupee,
                          size: 14,
                        ),
                        Text(
                          widget.price.toString(),
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
                    Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(onPressed: widget.increased,
                              icon: Icon(Icons.remove,size: 20.sp,)),
                          Text(
                              widget.itemcount.toString(),
                            style: CustomFont().bodyText,
                          ),
                          IconButton(onPressed: widget.decreased,
                              icon: Icon(Icons.add,size: 20.sp,)),

                        ],
                      ),

                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: widget.movetowish,
                child: Container(
                  width: 180.w,
                  padding: EdgeInsets.all(15),
                  child: Center(
                      child: Text("Add to wishlist")),
                ),
              ),
              InkWell(
                onTap: widget.ontapremove,
                child: Container(
                  width: 168.w,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Center(child: Text("Remove")),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
