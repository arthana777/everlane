import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTextfield extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileTextfield(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 0.8).w,
        padding: EdgeInsets.all(16.0).w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0).r,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 1),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: CustomColor.primaryColor,
                ),
                SizedBox(width: 16.w),
                Text(title, style: CustomFont().hintText),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: CustomColor.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
