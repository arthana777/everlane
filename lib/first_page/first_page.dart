import 'package:everlane/sigin_page/sigin_page.dart';
import 'package:everlane/signup_page/signup.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatelessWidget {
  FirstPage({super.key});
  final nameController = TextEditingController();
  final enailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Image.network(
          "https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          fit: BoxFit.cover,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  "You Want\nAuthentic,here\nyou go!",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500),
                ),
                 SizedBox(
                  height: 350.h,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SiginPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 20.w),
                    height: 55.h,
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        const Radius.circular(8).w,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.person,size: 20.sp,color: Colors.black,),
                        SizedBox(width: 100.w,),
                        Text(
                          "Sign In ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: (){
                    Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Siginup()),
                            );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 20.w),
                    height: 55.h,
                    // width: double.infinity.w,
                    decoration: BoxDecoration(
                      color: CustomColor.primaryColor,
                      borderRadius: BorderRadius.all(
                        const Radius.circular(8).w,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Icon(Icons.call_outlined,size: 20.sp,color: Colors.white,),
                    SizedBox(width: 100.w,),
                    Text(
                          "Sign Up ",
                          style: CustomFont().buttontext,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
