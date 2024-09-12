// // // class SiginPage extends StatefulWidget {
// // //   SiginPage({super.key});

// // //   @override
// // //   State<SiginPage> createState() => _SiginPageState();
// // // }

// // // class _SiginPageState extends State<SiginPage> {
// // //   bool isLoading = false;

// // //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// // //   final TextEditingController forgotusernameController = TextEditingController();
// // //   final TextEditingController _usernameController = TextEditingController();
// // //   final TextEditingController _passwordController = TextEditingController();
// // //   String? _usernameError;
// // //   String? _passwordError;
// // //   bool _isPasswordVisible = false;

// // //   void _validateAndSubmit() {
// // //     setState(() {
// // //       _usernameError = _validateUsername(_usernameController.text);
// // //       _passwordError = _validatePassword(_passwordController.text);
// // //     });

// // //     if (_usernameError == null && _passwordError == null) {
// // //       _submitForm();
// // //     }
// // //   }

// // //   void _submitForm() {
// // //     BlocProvider.of<LoginnBloc>(context).add(
// // //       LoginButtonEvent(
// // //         username: _usernameController.text,
// // //         password: _passwordController.text,
// // //       ),
// // //     );
// // //   }

// // //   String? _validateUsername(String? value) {
// // //     if (value == null || value.isEmpty) {
// // //       return "Please enter a valid Username";
// // //     }
// // //     return null;
// // //   }

// // //   String? _validatePassword(String? value) {
// // //     if (value == null || value.isEmpty) {
// // //       return 'Please enter your password';
// // //     }
// // //     return null;
// // //   }

// // //   FocusNode fieldOne = FocusNode();
// // //   FocusNode fieldTwo = FocusNode();

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Stack(
// // //       children: [
// // //         // Your background image and Scaffold code remains unchanged.
// // //         Scaffold(
// // //           resizeToAvoidBottomInset: true,
// // //           appBar: AppBar(
// // //             backgroundColor: Colors.transparent,
// // //             leading: const BackButton(color: Colors.white),
// // //           ),
// // //           backgroundColor: Colors.transparent,
// // //           body: BlocListener<LoginnBloc, LoginnState>(
// // //             listener: (context, state) {
// // //               if (state is LoginnFailure) {
// // //                 Fluttertoast.showToast(
// // //                   msg: "Invalid username or password",
// // //                   toastLength: Toast.LENGTH_SHORT,
// // //                   gravity: ToastGravity.BOTTOM,
// // //                   backgroundColor: Colors.red,
// // //                   textColor: Colors.white,
// // //                   fontSize: 16.0,
// // //                 );
// // //               } else if (state is LoginnSuccess) {
// // //                 setState(() {
// // //                   isLoading = true;
// // //                 });

// // //                 // Show the loading screen for 1 second
// // //                 Future.delayed(const Duration(seconds: 1), () {
// // //                   setState(() {
// // //                     isLoading = false;
// // //                   });
// // //                   Navigator.push(
// // //                     context,
// // //                     MaterialPageRoute(
// // //                         builder: (context) => const BtmNavigation()),
// // //                   );
// // //                 });
// // //               }
// // //             },
// // //             child: Stack(
// // //               children: [
// // //                 // Your login form UI code remains unchanged here.
// // //                 Padding(
// // //                   padding: EdgeInsets.only(top: 100.h),
// // //                   child: Container(
// // //                     // The container and text field elements...
// // //                   ),
// // //                 ),
// // //                 // Add a loading screen overlay
// // //                 if (isLoading)
// // //                   Container(
// // //                     color: Colors.black.withOpacity(0.5),
// // //                     child: const Center(
// // //                       child: CircularProgressIndicator(
// // //                         color: Colors.white,
// // //                       ),
// // //                     ),
// // //                   ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }








// // class SiginPage extends StatefulWidget {
// //   SiginPage({super.key});

// //   @override
// //   State<SiginPage> createState() => _SiginPageState();
// // }

// // class _SiginPageState extends State<SiginPage> {
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //   final TextEditingController forgotusernameController = TextEditingController();
// //   final TextEditingController _usernameController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //   String? _usernameError;
// //   String? _passwordError;
// //   bool _isPasswordVisible = false;

// //   void _validateAndSubmit() {
// //     setState(() {
// //       _usernameError = _validateUsername(_usernameController.text);
// //       _passwordError = _validatePassword(_passwordController.text);
// //     });

// //     if (_usernameError == null && _passwordError == null) {
// //       _submitForm();
// //     }
// //   }

// //   void _submitForm() {
// //     BlocProvider.of<LoginnBloc>(context).add(
// //       LoginButtonEvent(
// //         username: _usernameController.text,
// //         password: _passwordController.text,
// //       ),
// //     );
// //   }

// //   String? _validateUsername(String? value) {
// //     if (value == null || value.isEmpty) {
// //       return "Please enter a valid Username";
// //     }
// //     return null;
// //   }

// //   String? _validatePassword(String? value) {
// //     if (value == null || value.isEmpty) {
// //       return 'Please enter your password';
// //     }
// //     return null;
// //   }

// //   FocusNode fieldOne = FocusNode();
// //   FocusNode fieldTwo = FocusNode();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: [
// //         // Background image
// //         SizedBox(
// //           height: double.infinity.h,
// //           width: double.infinity.w,
// //           child: Image.network(
// //             "https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //         Scaffold(
// //           resizeToAvoidBottomInset: true,
// //           appBar: AppBar(
// //             backgroundColor: Colors.transparent,
// //             leading: const BackButton(color: Colors.white),
// //           ),
// //           backgroundColor: Colors.transparent,
// //           body: BlocConsumer<LoginnBloc, LoginnState>(
// //             listener: (context, state) {
// //               if (state is LoginnFailure) {
// //                 Fluttertoast.showToast(
// //                   msg: "Invalid username or password",
// //                   toastLength: Toast.LENGTH_SHORT,
// //                   gravity: ToastGravity.BOTTOM,
// //                   backgroundColor: Colors.red,
// //                   textColor: Colors.white,
// //                   fontSize: 16.0,
// //                 );
// //               } else if (state is LoginnSuccess) {
// //                 Fluttertoast.showToast(
// //                   msg: "Login Successful",
// //                   toastLength: Toast.LENGTH_SHORT,
// //                   gravity: ToastGravity.BOTTOM,
// //                   backgroundColor: Colors.green,
// //                   textColor: Colors.white,
// //                   fontSize: 16.0,
// //                 );

// //                 // Add a delay before navigating to the next page
// //                 Future.delayed(const Duration(seconds: 1), () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => const BtmNavigation()),
// //                   );
// //                 });
// //               }
// //             },
// //             builder: (context, state) {
// //               return Stack(
// //                 children: [
// //                   // Form and UI elements
// //                   Padding(
// //                     padding: EdgeInsets.only(top: 100.h),
// //                     child: Container(
// //                       height: double.infinity.h,
// //                       width: double.infinity.w,
// //                       decoration: BoxDecoration(
// //                         color: const Color(0xFFF7F7F7).withOpacity(0.7),
// //                         borderRadius: const BorderRadius.only(
// //                           topLeft: Radius.circular(20),
// //                           topRight: Radius.circular(20),
// //                         ),
// //                       ),
// //                       child: Padding(
// //                         padding: EdgeInsets.only(
// //                           bottom: MediaQuery.of(context).viewInsets.top,
// //                         ),
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           crossAxisAlignment: CrossAxisAlignment.center,
// //                           children: [
// //                             Padding(
// //                               padding: EdgeInsets.only(left: 10.w, right: 10.w),
// //                               child: CustomTextfield(
// //                                 focusNode: fieldOne,
// //                                 onFieldSubmitted: (value) {
// //                                   FocusScope.of(context).requestFocus(fieldTwo);
// //                                   return null;
// //                                 },
// //                                 hintText: 'Enter your Username',
// //                                 controller: _usernameController,
// //                                 inputType: TextInputType.emailAddress,
// //                               ),
// //                             ),
// //                             if (_usernameError != null)
// //                               Text(
// //                                 _usernameError!,
// //                                 style: const TextStyle(color: Colors.red),
// //                               ),
// //                             SizedBox(height: 10.h),
// //                             Padding(
// //                               padding: EdgeInsets.only(left: 10.w, right: 10.w),
// //                               child: CustomTextfield(
// //                                 focusNode: fieldTwo,
// //                                 hintText: 'Enter Your Password',
// //                                 controller: _passwordController,
// //                                 inputType: TextInputType.emailAddress,
// //                                 icon: IconButton(
// //                                   icon: Icon(
// //                                     _isPasswordVisible
// //                                         ? Icons.visibility
// //                                         : Icons.visibility_off,
// //                                   ),
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _isPasswordVisible = !_isPasswordVisible;
// //                                     });
// //                                   },
// //                                 ),
// //                                 obscureText: !_isPasswordVisible,
// //                               ),
// //                             ),
// //                             if (_passwordError != null)
// //                               Text(
// //                                 _passwordError!,
// //                                 style: const TextStyle(color: Colors.red),
// //                               ),
// //                             SizedBox(height: 20.h),
// //                             InkWell(
// //                               onTap: _validateAndSubmit,
// //                               child: Center(
// //                                 child: Padding(
// //                                   padding: EdgeInsets.only(left: 10.w, right: 10.w),
// //                                   child: ElevatedButton(
// //                                     style: ElevatedButton.styleFrom(
// //                                       fixedSize: Size(690.w, 48.h),
// //                                       backgroundColor: CustomColor.primaryColor,
// //                                       shape: RoundedRectangleBorder(
// //                                         borderRadius: BorderRadius.circular(10.r),
// //                                       ),
// //                                     ),
// //                                     onPressed: _validateAndSubmit,
// //                                     child: Text(
// //                                       "Login",
// //                                       style: CustomFont().buttontext,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                             SizedBox(height: 7.h),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   // Loading overlay if LoginnLoading state is active
// //                   if (state is LoginnLoading)
// //                     Container(
// //                       color: Colors.black.withOpacity(0.5),
// //                       child: const Center(
// //                         child: CircularProgressIndicator(
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                     ),
// //                 ],
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }






// // if (state is LoginnLoading)
// //                     Container(
// //                       color: Colors.black.withOpacity(0.5),
// //                       child: const Center(
// //                         child: CircularProgressIndicator(
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                     ),




// class SiginPage extends StatefulWidget {
//   SiginPage({super.key});

//   @override
//   State<SiginPage> createState() => _SiginPageState();
// }

// class _SiginPageState extends State<SiginPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController forgotusernameController =
//       TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String? _usernameError;
//   String? _passwordError;
//   bool _isPasswordVisible = false;

//   void _validateAndSubmit() {
//     setState(() {
//       _usernameError = _validateUsername(_usernameController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//     });

//     if (_usernameError == null && _passwordError == null) {
//       _submitForm();
//     }
//   }

//   void _submitForm() {
//     BlocProvider.of<LoginnBloc>(context).add(
//       LoginButtonEvent(
//         username: _usernameController.text,
//         password: _passwordController.text,
//       ),
//     );
//   }

//   String? _validateUsername(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Please enter a valid Username";
//     }
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your password';
//     }
//     return null;
//   }

//   FocusNode fieldOne = FocusNode();
//   FocusNode fieldTwo = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background image
//         SizedBox(
//           height: double.infinity.h,
//           width: double.infinity.w,
//           child: Image.network(
//             "https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//             fit: BoxFit.cover,
//           ),
//         ),
//         Scaffold(
//           resizeToAvoidBottomInset: true,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             leading: const BackButton(color: Colors.white),
//           ),
//           backgroundColor: Colors.transparent,
//           body: BlocConsumer<LoginnBloc, LoginnState>(
//             listener: (context, state) {
//               if (state is LoginnFailure) {
//                 Fluttertoast.showToast(
//                   msg: "Invalid username or password",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   backgroundColor: Colors.red,
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );
//               } else if (state is LoginnSuccess) {
//                 Fluttertoast.showToast(
//                   msg: "Login Successful",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   backgroundColor: Colors.green,
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );

//                 // Add a delay before navigating to the next page
//                 Future.delayed(const Duration(seconds: 1), () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const BtmNavigation()),
//                   );
//                 });
//               }
//             },
//             builder: (context, state) {
//               return Stack(
//                 children: [
//                   // Form and UI elements
//                   Padding(
//                     padding: EdgeInsets.only(top: 100.h),
//                     child: Container(
//                       height: double.infinity.h,
//                       width: double.infinity.w,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF7F7F7).withOpacity(0.7),
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           bottom: MediaQuery.of(context).viewInsets.top,
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(left: 10.w, right: 10.w),
//                               child: CustomTextfield(
//                                 focusNode: fieldOne,
//                                 onFieldSubmitted: (value) {
//                                   FocusScope.of(context).requestFocus(fieldTwo);
//                                   return null;
//                                 },
//                                 hintText: 'Enter your Username',
//                                 controller: _usernameController,
//                                 inputType: TextInputType.emailAddress,
//                               ),
//                             ),
//                             if (_usernameError != null)
//                               Text(
//                                 _usernameError!,
//                                 style: const TextStyle(color: Colors.red),
//                               ),
//                             SizedBox(height: 10.h),
//                             Padding(
//                               padding: EdgeInsets.only(left: 10.w, right: 10.w),
//                               child: CustomTextfield(
//                                 focusNode: fieldTwo,
//                                 hintText: 'Enter Your Password',
//                                 controller: _passwordController,
//                                 inputType: TextInputType.emailAddress,
//                                 icon: IconButton(
//                                   icon: Icon(
//                                     _isPasswordVisible
//                                         ? Icons.visibility
//                                         : Icons.visibility_off,
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isPasswordVisible = !_isPasswordVisible;
//                                     });
//                                   },
//                                 ),
//                                 obscureText: !_isPasswordVisible,
//                               ),
//                             ),
//                             if (_passwordError != null)
//                               Text(
//                                 _passwordError!,
//                                 style: const TextStyle(color: Colors.red),
//                               ),
//                             SizedBox(height: 20.h),
//                             InkWell(
//                               onTap: _validateAndSubmit,
//                               child: Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 10.w, right: 10.w),
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       fixedSize: Size(690.w, 48.h),
//                                       backgroundColor: CustomColor.primaryColor,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10.r),
//                                       ),
//                                     ),
//                                     onPressed: _validateAndSubmit,
//                                     child: Text(
//                                       "Login",
//                                       style: CustomFont().buttontext,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 7.h),
//                           ],
//                         ),
//                       ),
//                     ),
//                  ),
//                   // Show loading spinner when LoginnLoading state is active
//                  if (state is LoginnLoading)
//                     Container(
//                       color: Colors.black.withOpacity(0.5),
//                       child: const Center(
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
