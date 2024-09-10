import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customfont.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key, this.text, this.action, this.color, this.leading});

  final String? text;
  final Color? color;
  final List<Widget>? action;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 5,
      centerTitle: false,
      backgroundColor: color ?? Colors.white,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: leading,
      leadingWidth: 50.w,
      surfaceTintColor: Colors.white,
      toolbarHeight: 70.h,
      //leadingWidth: 20,
      title: Text(text ?? "", style: CustomFont().appbarText),
      actions: action,
    );
  }
}