import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomFont {
  CustomFont();
  final TextStyle appbarText = GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600));
  final TextStyle labelText = GoogleFonts.poppins(color: Colors.white);
  final TextStyle bodyText = GoogleFonts.questrial(
      textStyle: TextStyle(color: Colors.black, fontSize: 12.sp));
  final TextStyle subtitleText = GoogleFonts.questrial(
      textStyle: TextStyle(
    color: Colors.black,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  ));
  final TextStyle buttontext = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600));
  final TextStyle hintText = GoogleFonts.poppins(color: Colors.black);
  final TextStyle titleText = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp));
  final TextStyle subText = GoogleFonts.roboto(
      textStyle: const TextStyle(color: Colors.black, fontSize: 15));
}

class CustomSize {
  CustomSize();
  static double iconSize = 20.0.sp;
}
