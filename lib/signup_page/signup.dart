import 'package:everlane/bloc_signup/bloc/signup_bloc.dart';
import 'package:everlane/bloc_signup/bloc/signup_event.dart';
import 'package:everlane/bloc_signup/bloc/signup_state.dart';
import 'package:everlane/sigin_page/sigin_page.dart';
import 'package:everlane/data/datasources/signuprepository.dart';
import 'package:everlane/data/models/userregistration.dart';
import 'package:everlane/widgets/custom_textfield.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final SignupRepository signupRepository = SignupRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(signupRepository),
      child: Siginup(),
    );
  }
}

class Siginup extends StatefulWidget {
  @override
  State<Siginup> createState() => _SiginupState();
}

class _SiginupState extends State<Siginup> {
  void _confirm() {
    if (_formKey.currentState!.validate()) {}
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passController = TextEditingController();

  final confirmpassController = TextEditingController();

  final lastNameController = TextEditingController();

  final userNameController = TextEditingController();

  final _mobileController = TextEditingController();

  bool passwordVisible = true;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != confirmpassController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  FocusNode fieldOne = FocusNode();
  FocusNode fieldTwo = FocusNode();
  FocusNode fieldThree = FocusNode();
  FocusNode fieldFour = FocusNode();
  FocusNode fieldFive = FocusNode();
  FocusNode fieldSix = FocusNode();
  FocusNode fieldSeven = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.network(
          "https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          fit: BoxFit.cover,
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 140).r,
            child: Container(
              height: double.infinity.h,
              width: double.infinity.w,
              decoration:  BoxDecoration(
                  color: Colors.white70,
                  borderRadius:  const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)).r),
              child: Padding(
                padding: const EdgeInsets.only(top: 70, left: 10, right: 10).r,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextfield(
                          focusNode: fieldOne,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldTwo);
                          },
                          controller: nameController,
                          hintText: "Firstname",
                          inputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextfield(
                          focusNode: fieldTwo,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldThree);
                          },
                          controller: lastNameController,
                          hintText: 'Enter Last Name',
                          inputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Last name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextfield(
                          focusNode: fieldThree,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldFour);
                          },
                          controller: emailController,
                          hintText: 'Enter Your Email',
                          inputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid email Address";
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email Address';
                            }
                            return null;
                          },
                          // textCapitalization: TextCapitalization.words,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextfield(
                          focusNode: fieldFour,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldFive);
                          },
                          controller: userNameController,
                          hintText: 'Enter UserName',
                          inputType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextfield(
                          focusNode: fieldFive,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldSix);
                          },
                          controller: _mobileController,
                          hintText: 'Enter mobile number',
                          inputType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'Please enter a valid 10-digit mobile number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5).r,
                          child: TextFormField(
                            focusNode: fieldSix,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(fieldSeven);
                            },
                            controller: passController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintStyle: CustomFont().hintText,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8).w,
                              ),
                              fillColor: const Color(0xFFFFFFFF),
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.only(left: 10, top: 15).r,
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5).r,
                          child: TextFormField(
                            focusNode: fieldSeven,
                            controller: confirmpassController,
                            obscureText: _obscureConfirmPassword,
                            decoration: InputDecoration(
                              hintStyle: CustomFont().hintText,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8).r,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.only(left: 10, top: 10).r,
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(_obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            validator: _validateConfirmPassword,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        BlocConsumer<RegistrationBloc, SignupState>(
                            listener: (context, state) {
                          if (state is RegistrationSuccess) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SiginPage(),
                                ));

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("RegistrationSuccessfull"),
                              ),
                            );
                          } else if (state is RegistrationFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("RegistrationFailed"),
                              ),
                            );
                          }
                        }, builder: (context, state) {
                          if (state is RegistrationLoading) {
                            return const CircularProgressIndicator();
                          }
                          return Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 5).r,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(350, 48),
                                  backgroundColor: CustomColor.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<RegistrationBloc>(context)
                                      .add(
                                    RegisterUser(
                                      Userregistration(
                                        username: userNameController.text,
                                        confirmPassword: passController.text,
                                        email: emailController.text,
                                        mobile: _mobileController.hashCode,
                                        password: passController.text,
                                        firstName: nameController.text,
                                        lastName: lastNameController.text,
                                      ),
                                    ),
                                  );
                                  if (_formKey.currentState!.validate()) {}
                                },
                                child: Text(
                                  "Confirm",
                                  style: CustomFont().buttontext,
                                ),
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 20.sp,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
