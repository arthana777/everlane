import 'package:everlane/bloc/editprofile/bloc/editprofile_bloc.dart';
import 'package:everlane/bloc/editprofile/bloc/editprofile_event.dart';
import 'package:everlane/bloc/editprofile/bloc/editprofile_state.dart';
import 'package:everlane/profile/profile.dart';
import 'package:everlane/widgets/custom_textfield.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void _confirm() {
    if (_formKey.currentState!.validate()) {}
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  final firstnameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneNumberController = TextEditingController();

  bool _isButtonVisible = false;

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(_handleTextChange);
    emailController.addListener(_handleTextChange);
    lastNameController.addListener(_handleTextChange);
    usernameController.addListener(_handleTextChange);
    lastNameController.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    setState(() {
      _isButtonVisible = phoneNumberController.text.isNotEmpty;
      _isButtonVisible = emailController.text.isNotEmpty;
      _isButtonVisible = lastNameController.text.isNotEmpty;
      _isButtonVisible = usernameController.text.isNotEmpty;
      _isButtonVisible = firstnameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    firstnameController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  FocusNode fieldOne = FocusNode();
  FocusNode fieldTwo = FocusNode();
  FocusNode fieldThree = FocusNode();
  FocusNode fieldFour = FocusNode();
  FocusNode fieldFive = FocusNode();

  @override
  Widget build(BuildContext context) {
    final editProfileBloc = context.read<EditprofileBloc>();

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: CustomAppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          text: "Edit profile",
          color: Colors.transparent,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 70).r,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                CircleAvatar(
                  backgroundImage: const NetworkImage(
                    'https://i.pinimg.com/474x/8e/0c/fa/8e0cfaf58709f7e626973f0b00d033d0.jpg',
                  ),
                  backgroundColor: Colors.white,
                  maxRadius: 60.r,
                ),
                SizedBox(height: 30.h),
                CustomTextfield(
                  focusNode: fieldOne,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(fieldTwo);
                    return null;
                  },
                  controller: usernameController,
                  hintText: 'User name',
                  inputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextfield(
                  focusNode: fieldTwo,
                  onFieldSubmitted: (contex) {
                    FocusScope.of(context).requestFocus(fieldThree);
                    return null;
                  },
                  controller: firstnameController,
                  hintText: 'First Name',
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your  first name';
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
                  controller: lastNameController,
                  hintText: 'Last Name',
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
                  focusNode: fieldFour,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(fieldFive);
                    return null;
                  },
                  controller: emailController,
                  hintText: 'Email',
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a valid email Address";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email Address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextfield(
                  focusNode: fieldFive,
                  controller: phoneNumberController,
                  hintText: 'Mobile Number',
                  inputType: TextInputType.phone,
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
                SizedBox(height: 20.h),
                BlocListener<EditprofileBloc, EditprofileState>(
                  listener: (context, state) {
                    print("loadinggggg");
                    if (state is UserProfileLoading) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                      print("error${state}");
                    } else if (state is UserProfileUpdated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Profile Updated Successfully"),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ),
                      );
                    } else if (state is UserProfileError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("User Update Failed. Try Again"),
                        ),
                      );
                    }
                    ;
                  },
                  child: BlocBuilder<EditprofileBloc, EditprofileState>(
                    builder: (context, state) {
                      if (state is UserProfileLoading) {
                        return const CircularProgressIndicator();
                      }
                      return _isButtonVisible
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(690.w, 48.h),
                                backgroundColor: CustomColor.primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                ),
                              ),
                              onPressed: () {
                                final updatedData = {
                                  'username': usernameController.text,
                                  'first_name': firstnameController.text,
                                  'last_name': lastNameController.text,
                                  'email': emailController.text,
                                  'mobile': phoneNumberController.text,
                                };
                                if (_formKey.currentState!.validate()) {
                                  editProfileBloc
                                      .add(UpdateUserProfile(updatedData));
                                }
                              },
                              child: Text("Confirm",
                                  style: CustomFont().buttontext),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
                SizedBox(height: 20.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
