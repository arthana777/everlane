import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBanner extends StatelessWidget {
  CategoryBanner({super.key, this.image, this.title});
  final String? image;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 0,
          child: Container(
            height: 215.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(image ?? "Networkimg"),
                  fit: BoxFit.cover,
                ),),
          ),
        ),
        Container(
          height: 215.h,
          decoration: BoxDecoration(color: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 30),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? "",
                  style: CustomFont().appbarText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
