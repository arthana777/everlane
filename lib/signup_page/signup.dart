import 'package:country_picker/country_picker.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

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
  String? selectedCountryCode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///971 575868374
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final _mobileController = TextEditingController();

  bool passwordVisible = true;
  bool _isButtonVisible = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _handleTextChange() {
    setState(() {
      _isButtonVisible = _mobileController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          userNameController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          passController.text.isNotEmpty &&
          confirmpassController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _mobileController.addListener(_handleTextChange);
    emailController.addListener(_handleTextChange);
    lastNameController.addListener(_handleTextChange);
    userNameController.addListener(_handleTextChange);
    nameController.addListener(_handleTextChange);
    passController.addListener(_handleTextChange);
    confirmpassController.addListener(_handleTextChange);
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    } else if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      return 'Password must contain at least one letter';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    print("Password: ${passController.text}, Confirm Password: $value");
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passController.text) {
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

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          selectedCountryCode = "+${country.phoneCode}";
        });
        print("Selected country: ${country.name} (${country.phoneCode})");
      },
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ).r,
        inputDecoration: InputDecoration(
          iconColor: Colors.black,
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
        searchTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  void _confirm() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<RegistrationBloc>(context).add(
        RegisterUser(
          Userregistration(
            username: userNameController.text,
            confirmPassword: passController.text,
            email: emailController.text,
            mobile: int.tryParse(_mobileController.text) ?? 0,
            password: passController.text,
            firstName: nameController.text,
            lastName: lastNameController.text,
            countrycode: selectedCountryCode?.replaceAll(
                '+', ''), // Remove "+" before sending
          ),

        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            "https://images.unsplash.com/photo-1532453288672-3a27e9be9efd?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: const BackButton(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 20).r,
            child: Container(
              height: double.infinity.h,
              width: double.infinity.w,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ).r,
              ),
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
                            return null;
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
                        SizedBox(height: 10.h),
                        CustomTextfield(
                          focusNode: fieldTwo,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldThree);
                            return null;
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
                        SizedBox(height: 10.h),
                        CustomTextfield(
                          focusNode: fieldThree,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldFour);
                            return null;
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
                        ),
                        SizedBox(height: 10.h),
                        CustomTextfield(
                          focusNode: fieldFour,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldFive);
                            return null;
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
                        SizedBox(height: 10.h),
                        CustomTextfield(
                          focusNode: fieldFive,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldSix);
                            return null;
                          },
                          controller: _mobileController,
                          hintText: 'Enter mobile number',
                          prefix: GestureDetector(
                            onTap: _showCountryPicker,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(selectedCountryCode ?? ""),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                          inputType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: fieldSix,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldSeven);
                          },
                          controller: passController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 17.0.h, horizontal: 10.0.w),
                            hintStyle: CustomFont().hintText,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8).w,
                            ),
                            fillColor: const Color(0xFFFFFFFF),
                            filled: true,
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20.sp,
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
                        SizedBox(height: 10.h),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: fieldSeven,
                          controller: confirmpassController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 17.0.h, horizontal: 10.0.w),
                            hintStyle: CustomFont().hintText,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8).r,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20.sp,
                              ),
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
                        SizedBox(height: 35.h),
                        BlocConsumer<RegistrationBloc, SignupState>(
                          listener: (context, state) {
                            if (state is RegistrationSuccess) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SiginPage(),
                                ),
                              );
                              Fluttertoast.showToast(
                                msg: "${state.message}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else if (state is RegistrationFailed) {
                              Fluttertoast.showToast(
                                msg: "${state.message}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is RegistrationLoading) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: CircularProgressIndicator(),
                              );
                            }

                            return _isButtonVisible
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, right: 5)
                                            .r,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(690.w, 48.h),
                                        backgroundColor:
                                            CustomColor.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10).w,
                                        ),
                                      ),
                                      onPressed: _confirm,
                                      child: Text(
                                        "Confirm",
                                        style: CustomFont().buttontext,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        SizedBox(height: 20.sp),
                      ],
                    ),
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
