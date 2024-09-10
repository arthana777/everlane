import 'package:everlane/btm_navigation/btm_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Donationsuccess extends StatelessWidget {
  const Donationsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 100.sp,
          ),
          SizedBox(height: 20.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              'Thank you for your kindness!',
              style: GoogleFonts.questrial(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Text("Your donation has been successfully recieved"),
          Text(" we are excited to prepare it for pickup"),

          SizedBox(height: 20.h,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BtmNavigation()));
            },
            child: Container(
              height: 40.h,
              width: 200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(color: Colors.purple)
              ),
              child: Center(child: Text("Go to Home")),
            ),
          )
        ],
      ),
    );
  }
}
