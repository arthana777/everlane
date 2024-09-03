import 'package:everlane/bloc/loginn/loginn_bloc.dart';
import 'package:everlane/btm_navigation/btm_navigation.dart';
import 'package:everlane/forgot_password/forgot_bottomsheet.dart';
import 'package:everlane/questionnaire/qstmodalbottomsheet.dart';
import 'package:everlane/signup_page/signup.dart';
import 'package:everlane/widgets/custom_textfield.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SiginPage extends StatefulWidget {
  SiginPage({super.key});

  @override
  State<SiginPage> createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;
  bool _isPasswordVisible = false;
  @override
  void _validateFields() {
    setState(() {
      _usernameError = _validateUsername(_usernameController.text);
      _passwordError = _validatePassword(_passwordController.text);
    });
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginnBloc>(context).add(
        LoginButtonEvent(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid Username";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid Username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  FocusNode fieldOne = FocusNode();
  FocusNode fieldTwo = FocusNode();

  @override
  Widget build(BuildContext context) {
    Color colorWithOpacity;
    return Stack(children: [
      SizedBox(
        height: double.infinity.h,
        width: double.infinity.w,
        child: Image.network(
          "https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          fit: BoxFit.cover,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocListener<LoginnBloc, LoginnState>(
          listener: (context, state) {
            if (state is LoginnFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Login failed, please try again."),
                ),
              );
            } else if (state is LoginnSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Successful!'),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const BtmNavigation()),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 220).r,
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
                padding: const EdgeInsets.only(top: 70, left: 10, right: 10).r,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextfield(
                        focusNode: fieldOne,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(fieldTwo);
                        },
                        hintText: 'Enter your Username',
                        controller: _usernameController,
                        inputType: TextInputType.emailAddress,
                        onChanged: (value) => _validateFields(),
                      ),
                      if (_usernameError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _usernameError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomTextfield(
                        focusNode: fieldTwo,
                        hintText: 'Enter Your Password',
                        controller: _passwordController,
                        inputType: TextInputType.text,
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
                        onChanged: (value) => _validateFields(),
                      ),
                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                             ForgotBottomsheet.moreModalBottomSheet(context);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                  fontSize: 13.sp),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BtmNavigation()),
                          );
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(350, 48),
                                backgroundColor: CustomColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<LoginnBloc>(context).add(
                                  LoginButtonEvent(
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: CustomFont().buttontext,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
