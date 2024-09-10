import 'package:everlane/bloc/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:everlane/bloc/forgot_password/bloc/forgot_password_event.dart';
import 'package:everlane/bloc/forgot_password/bloc/forgot_password_state.dart';
import 'package:everlane/bloc/loginn/loginn_bloc.dart';
import 'package:everlane/btm_navigation/btm_navigation.dart';
import 'package:everlane/data/datasources/forgot_password_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everlane/widgets/custom_textfield.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';

class SiginPage extends StatefulWidget {
  SiginPage({super.key});

  @override
  State<SiginPage> createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController forgotusernameController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;
  bool _isPasswordVisible = false;

  void _validateAndSubmit() {
    setState(() {
      _usernameError = _validateUsername(_usernameController.text);
      _passwordError = _validatePassword(_passwordController.text);
    });

    if (_usernameError == null && _passwordError == null) {
      _submitForm();
    }
  }

  void _submitForm() {
    BlocProvider.of<LoginnBloc>(context).add(
      LoginButtonEvent(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid Username";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  FocusNode fieldOne = FocusNode();
  FocusNode fieldTwo = FocusNode();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    Color colorWithOpacity;

    return Stack(
      children: [
        SizedBox(
          height: double.infinity.h,
          width: double.infinity.w,
          child: Image.network(
            "https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: const BackButton(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          body: BlocListener<LoginnBloc, LoginnState>(
            listener: (context, state) {
              if (state is LoginnFailure) {
                Fluttertoast.showToast(
                  msg: "Invalid username or password",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else if (state is LoginnSuccess) {
                Fluttertoast.showToast(
                  msg: "Login Successful",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BtmNavigation()),
                );
              }
            },
            child: Padding(
              padding:  EdgeInsets.only(top: 100.h),
              child: Container(
                height: double.infinity.h,
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: colorWithOpacity =
                      const Color(0xFFF7F7F7).withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.top,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 10.w, right: 10.w),
                        child: CustomTextfield(
                          focusNode: fieldOne,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldTwo);
                            return null;
                          },
                          hintText: 'Enter your Username',
                          controller: _usernameController,
                          inputType: TextInputType.emailAddress,
                        ),
                      ),
                      if (_usernameError != null)
                        Text(
                          _usernameError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding:  EdgeInsets.only(left: 10.w, right: 10.w),
                        child: CustomTextfield(
                          focusNode: fieldTwo,
                          hintText: 'Enter Your Password',
                          controller: _passwordController,
                          inputType: TextInputType.emailAddress,
                          icon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          obscureText: !_isPasswordVisible,
                        ),
                      ),
                      if (_passwordError != null)
                        Text(
                          _passwordError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor:
                                    const Color.fromARGB(255, 241, 241, 241),
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) => ForgotPasswordBloc(
                                        authRepository:
                                            ForgotPasswordService()),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: SizedBox(
                                        height: 300.h,
                                        child: Form(
                                          key: _formKey,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                       EdgeInsets.only(
                                                              top: 15.h,
                                                              left: 15.w,
                                                              right: 15.w)
                                                          .r,
                                                  child: Text(
                                                    "Forgot Password",
                                                    style: GoogleFonts.poppins(
                                                      color: CustomColor
                                                          .primaryColor,
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                          left: 15.w, right: 15.w)
                                                      .r,
                                                  child: Text(
                                                    "Enter your username and click confirm. The new password will be sent to your email.",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12.sp),
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                                Padding(
                                                  padding:
                                                       EdgeInsets.only(
                                                              left: 10.w,
                                                              right: 10.w),
                                                  child: CustomTextfield(
                                                    controller:
                                                        forgotusernameController,
                                                    hintText:
                                                        'Enter Your Valid Username',
                                                    inputType: TextInputType
                                                        .emailAddress,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Please enter a valid Username";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                                BlocListener<ForgotPasswordBloc,
                                                    ForgotPasswordState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is ForgotPasswordSuccess) {
                                                      Fluttertoast.showToast(
                                                        msg: state.message,
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.green,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0.sp,
                                                      );
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 2));
                                                      Navigator.pop(context);
                                                    } else if (state
                                                        is ForgotPasswordFailure) {
                                                      Fluttertoast.showToast(
                                                        msg: state.message,
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0.sp,
                                                      );
                                                    }
                                                  },
                                                  child: BlocBuilder<
                                                      ForgotPasswordBloc,
                                                      ForgotPasswordState>(
                                                    builder: (context, state) {
                                                      if (state
                                                          is ForgotPasswordLoading) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      }
                                                      return Padding(
                                                        padding:
                                                             EdgeInsets
                                                                    .only(
                                                                    left: 13.w,
                                                                    right: 13.w,
                                                                    top: 15.h)
                                                                .r,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            fixedSize: Size(
                                                                690.w, 48.h),
                                                            backgroundColor:
                                                                CustomColor
                                                                    .primaryColor,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                          .circular(
                                                                              10.r)
                                                                      ,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              BlocProvider.of<
                                                                          ForgotPasswordBloc>(
                                                                      context)
                                                                  .add(
                                                                ForgotPasswordRequested(
                                                                  forgotusernameController
                                                                      .text,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            "Confirm",
                                                            style: CustomFont()
                                                                .buttontext,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 255, 26, 10),
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: _validateAndSubmit,
                        child: Center(
                          child: Padding(
                            padding:
                                 EdgeInsets.only(left: 10.w, right: 10.w),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(690.w, 48.h),
                                backgroundColor: CustomColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onPressed: _validateAndSubmit,
                              child: Text(
                                "Login",
                                style: CustomFont().buttontext,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
