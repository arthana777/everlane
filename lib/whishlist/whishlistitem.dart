import 'package:everlane/bloc/whishlist/whishlist_bloc.dart';
import 'package:everlane/bloc/whishlist/whishlist_event.dart';
import 'package:everlane/bloc/whishlist/whishlist_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class WhishlistItem extends StatefulWidget {
  WhishlistItem({super.key, this.saveontap, this.removeonTap,  this.text, this.image, this.price, this.description});
  final VoidCallback? saveontap;
  final VoidCallback? removeonTap;
  final String? text;
  final String? image;
  final double? price;
  final String? description;

  @override
  State<WhishlistItem> createState() => _WhishlistItemState();
}

class _WhishlistItemState extends State<WhishlistItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                      widget.text??"",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp)),
                    ),
                    SizedBox(
                      width: 210.w,
                      child: Text(
                        widget.description??"Apple fifteen pro max",
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp)),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        InkWell(child: Icon(Icons.currency_rupee)),
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
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CustomTextButton(text: "Save for later",ontap: (){},),
              // CustomTextButton(text: "Remove",ontap: (){
              //   BlocProvider.of<WhishlistBloc>(context)
              //       .add(Removefromwishlist(whishlist[index]));
              // }),
              InkWell(
                //onTap: saveontap,
                child: Container(
                  width: 180.w,
                  padding: EdgeInsets.all(15),
                  child: Center(child: Text("Addto Cart")),
                ),
              ),
              InkWell(
                onTap: widget.removeonTap,
                child: Container(
                  width: 180.w,
                  padding: EdgeInsets.all(15),
                  child: Center(child: Text("Remove")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
