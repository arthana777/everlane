// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../bloc/forgot_password/bloc/forgot_password_bloc.dart';
// import '../bloc/forgot_password/bloc/forgot_password_event.dart';
// import '../bloc/forgot_password/bloc/forgot_password_state.dart';
// import '../data/datasources/forgot_password_service.dart';
// import '../widgets/custom_textfield.dart';
// import '../widgets/customcolor.dart';
// import '../widgets/customfont.dart';

// class ForgotPaswordScreen extends StatefulWidget {
//   const ForgotPaswordScreen({super.key});

//   @override
//   State<ForgotPaswordScreen> createState() => _ForgotPaswordScreenState();
// }

// class _ForgotPaswordScreenState extends State<ForgotPaswordScreen> {
//   final usernameController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           ForgotPasswordBloc(authRepository: ForgotPasswordService()),
//       child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
//         listener: (context, state) {
//           if (state is ForgotPasswordSuccess) {
//             Fluttertoast.showToast(
//                 backgroundColor: Colors.white,
//                 gravity: ToastGravity.SNACKBAR,
//                 timeInSecForIosWeb: 7,
//                 textColor: Colors.green,
//                 msg: "Password send to your Email");

//             Navigator.pop(context);
//           } else if (state is ForgotPasswordFailure) {
//             Fluttertoast.showToast(
//                 backgroundColor: Colors.white,
//                 gravity: ToastGravity.SNACKBAR,
//                 textColor: Colors.red,
//                 msg: 'Failed: Enter Valid User Name');
//           }
//         },
//         builder: (context, state) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 20, left: 15, right: 15).r,
//                     child: Text(
//                       "Forgot Password",
//                       style: GoogleFonts.poppins(
//                         color: CustomColor.primaryColor,
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w500,
//                         shadows: const [
//                           BoxShadow(
//                             color: Colors.white30,
//                             offset: Offset(0, 1),
//                             blurRadius: 2.0,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15, right: 15).r,
//                     child: Text(
//                       "Enter your user in it and click the confirm button and the new password will be sent to the email",
//                       style: GoogleFonts.poppins(fontSize: 12.sp),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30.h,
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 20, left: 15, right: 15).r,
//                     child: CustomTextfield(
//                       controller: usernameController,
//                       hintText: 'Enter Your Valid Username',
//                       inputType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter a valid Username";
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 20, left: 15, right: 15).r,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         fixedSize: const Size(350, 48),
//                         backgroundColor: CustomColor.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10).w,
//                         ),
//                       ),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           BlocProvider.of<ForgotPasswordBloc>(context).add(
//                             ForgotPasswordRequested(usernameController.text),
//                           );
//                         }
//                       },
//                       child: state is ForgotPasswordLoading
//                           ? CircularProgressIndicator(
//                               color: Colors.white,
//                             )
//                           : Text(
//                               "Confirm",
//                               style: CustomFont().buttontext,
//                             ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
