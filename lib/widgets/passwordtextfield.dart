// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class PasswordTextfield extends StatelessWidget {
//    PasswordTextfield({super.key});
//    bool _isHidePassword=true;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//           suffixIcon: GestureDetector(
//             onTap: () {
//              // _togglePasswordVisibility();
//             },
//             child: Icon(
//               _isHidePassword ? Icons.visibility_off : Icons.visibility,
//               color: Colors.black,
//             ),
//           ),
//           errorText: _isPasswordValid ? null : _passwordValidMsg,
//           errorStyle: TextStyle(color: constant.colorWhite),
//           labelStyle: TextStyle(color: constant.colorWhite),
//           errorBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: constant.colorWhite),
//           ),
//           focusedErrorBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: constant.colorWhite),
//           ),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: constant.colorWhite),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: constant.colorWhite),
//           )),
//       style: TextStyle(color: constant.colorWhite),
//       obscureText: _isHidePassword,
//       controller: _passwordSignUpController,
//     )
//   }
// }
