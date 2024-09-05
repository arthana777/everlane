import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Widget? prefix;
  final FocusNode? focusNode;
  final String hintText;
  final onChanged;
  final bool isPassword;
  final IconButton? icon;
  final bool obscureText;
  final bool obscureText2;
  final TextCapitalization textCapitalization;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onFieldSubmitted;

  CustomTextfield({
    Key? key,
    this.prefix,
    required this.controller,
    this.onChanged,
    this.isPassword = true,
    required this.hintText,
    this.focusNode,
    this.obscureText = false,
    this.obscureText2 = false,
    this.textCapitalization = TextCapitalization.none,
    this.inputType,
    this.onFieldSubmitted,
    this.validator,
    this.icon,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5).r,
      child: TextFormField(
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.controller,
        textCapitalization: widget.textCapitalization,
        maxLength: 32,
        maxLines: 1,
        obscureText: widget.obscureText,
        keyboardType: widget.inputType,
        onChanged: widget.onChanged,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefix: widget.prefix,
          contentPadding: const EdgeInsets.only(
            left: 10,
            top: 10,
          ).r,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: widget.hintText,
          hintStyle: CustomFont().hintText,
          suffixIcon: widget.icon,
          counterText: '',
          fillColor: Colors.white,
          filled: true,
        ),
        validator: widget.validator,
        textAlign: TextAlign.start,
      ),
    );
  }
}
