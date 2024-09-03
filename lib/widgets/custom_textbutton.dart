import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
   CustomTextButton({super.key, this.text, this.ontap});
  final String? text;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 180.w,
        padding: EdgeInsets.all(15),
        child: Center(
            child: Text(text??"")),
      ),
    );
  }
}
