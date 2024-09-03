import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AdrressCustomField extends StatelessWidget {
  const AdrressCustomField({
    super.key,
    this.suffixIcon,
    this.boxShadow,
    this.hinttext,
    this.heigth,
    this.controller,
    this.inputType,
    this.onchanged,
    this.width,
    this.validator,
    this.borderColor = Colors.grey, // Added borderColor parameter
    this.borderRadius = 8.0,
    this.backgroundColor = Colors.white,// Added borderRadius parameter
  });

  final Widget? suffixIcon;
  final List<BoxShadow>? boxShadow;
  final String? hinttext;
  final double? heigth;
  final double? width;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Function(String)? onchanged;
  final String? Function(String?)? validator;
  final Color borderColor; // Border color
  final double borderRadius;
  final Color backgroundColor; // Border radius

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(borderRadius).r,
      ),
      child: TextFormField(
        onChanged: onchanged,
        controller: controller,
        maxLines: 1,
        keyboardType: inputType,
        style: const TextStyle(
          color: Colors.black54,
        ),
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.only(left: 5, bottom: 17).r,
          hintText: hinttext,
          hintStyle: GoogleFonts.quicksand(color: Colors.grey, fontSize: 12.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius).r,
            borderSide: BorderSide(
              color: borderColor,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius).r,
            borderSide: BorderSide(
              color: borderColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius).r,
            borderSide: BorderSide(
              color: borderColor,
              width: 2.0, // Slightly thicker border when focused
            ),
          ),
          filled: true, // Enables the background color
          fillColor: backgroundColor,
        ),
      ),
    );
  }
}


class CustomAdressSelection extends StatelessWidget {
  CustomAdressSelection({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 80.w,
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(20).w,
      ),
      child: Center(child: Text(text ?? "")),
    );
  }
}
