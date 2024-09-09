import 'package:everlane/bloc/editprofile/bloc/editprofile_bloc.dart';
import 'package:everlane/bloc/editprofile/bloc/editprofile_event.dart';
import 'package:everlane/bloc/editprofile/bloc/editprofile_state.dart';
import 'package:everlane/data/models/userprofile.dart';
import 'package:everlane/profile/profile.dart';
import 'package:everlane/widgets/custom_textfield.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfile extends StatefulWidget {
  final Userprofile userProfile;

  EditProfile({super.key, required this.userProfile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void _confirm() {
    if (_formKey.currentState!.validate()) {}
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController usernameController;
  late TextEditingController firstnameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;

  bool _isButtonVisible = false;

  @override
  void initState() {
    super.initState();

    usernameController =
        TextEditingController(text: widget.userProfile.username);
    firstnameController =
        TextEditingController(text: widget.userProfile.firstName);
    lastNameController =
        TextEditingController(text: widget.userProfile.lastName);
    emailController = TextEditingController(text: widget.userProfile.email);
    phoneNumberController =
        TextEditingController(text: widget.userProfile.mobile);

    usernameController.addListener(_handleTextChange);
    firstnameController.addListener(_handleTextChange);
    lastNameController.addListener(_handleTextChange);
    emailController.addListener(_handleTextChange);
    phoneNumberController.addListener(_handleTextChange);
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
    usernameController.dispose();
    firstnameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
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
          text: "Edit Profile",
          color: Colors.transparent,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 70),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  backgroundImage: const NetworkImage(
                    'https://i.pinimg.com/474x/8e/0c/fa/8e0cfaf58709f7e626973f0b00d033d0.jpg',
                  ),
                  backgroundColor: Colors.white,
                  maxRadius: 60,
                ),
                SizedBox(height: 30),
                CustomTextfield(
                  controller: usernameController,
                  hintText: 'Enter your username',
                  inputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  controller: firstnameController,
                  hintText: 'Enter your first name',
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  controller: lastNameController,
                  hintText: 'Enter your last name',
                  inputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  controller: emailController,
                  hintText: 'Enter your email',
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a valid email address";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  controller: phoneNumberController,
                  hintText: 'Enter your mobile number',
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
                SizedBox(height: 20),
                BlocListener<EditprofileBloc, EditprofileState>(
                  listener: (context, state) {
                    print("loadinggggg");
                    if (state is UserProfileLoading) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                      print("error${state}");
                    } else if (state is UserProfileUpdated) {
                      Fluttertoast.showToast(
                        backgroundColor: Colors.green,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.white,
                        msg: "Password Updated Successfully",
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ),
                      );
                    } else if (state is UserProfileError) {
                      Fluttertoast.showToast(
                        backgroundColor: Colors.red,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.white,
                        msg: "User Update Failed. Try Again",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
