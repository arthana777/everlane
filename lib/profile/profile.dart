import 'package:everlane/bloc/change_password/bloc/change_password_bloc.dart';
import 'package:everlane/bloc/change_password/bloc/change_password_event.dart';
import 'package:everlane/bloc/change_password/bloc/change_password_state.dart';
import 'package:everlane/btm_navigation/btm_navigation.dart';
import 'package:everlane/checkout/myorders.dart';
import 'package:everlane/data/datasources/change_password_repo.dart';
import 'package:everlane/donation/mydonations.dart';
import 'package:everlane/notification/notification_screen.dart';
import 'package:everlane/whishlist/whishlist.dart';
import 'package:everlane/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:everlane/bloc/userprofile/bloc/profile_bloc.dart';
import 'package:everlane/bloc/userprofile/bloc/profile_event.dart';
import 'package:everlane/bloc/userprofile/bloc/profile_state.dart';
import 'package:everlane/data/datasources/profileservice.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/first_page/first_page.dart';
import 'package:everlane/profile/edit_profile.dart';
import 'package:everlane/data/models/userprofile.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:everlane/widgets/profile_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../donation/my_registration.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: BtmNavigation(),
                          type: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 230))
                      // MaterialPageRoute(builder: (context) => const BtmNavigation()),
                      );
                },
                icon: const Icon(Icons.arrow_back)),
            text: "Profile",
            color: const Color(0xFFF7F7F7),
          ),
        ),
        body: BlocProvider(
          create: (context) =>
              ProfileBloc(ProfileService())..add(FetchUserProfile()),
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.purple,
                  ));
                } else if (state is ProfileLoaded) {
                  return ProfileDetails(userProfile: state.userProfile);
                } else if (state is ProfileError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(
                    child: Text('Please log in to view your profile.'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDetails extends StatefulWidget {
  final Userprofile userProfile;

  const ProfileDetails({super.key, required this.userProfile});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  void _confirm() {
    if (_formKey.currentState!.validate()) {}
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final new_PassController = TextEditingController();

  final old_passwordController = TextEditingController();
  FocusNode fieldOne = FocusNode();
  FocusNode fieldTwo = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10).r,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: const NetworkImage(
                    'https://i.pinimg.com/474x/8e/0c/fa/8e0cfaf58709f7e626973f0b00d033d0.jpg',
                  ),
                  backgroundColor: Colors.white,
                  maxRadius: 60.r,
                ),
                SizedBox(height: 10.h),
                Text('${widget.userProfile.username}',
                    style: CustomFont().titleText),
                SizedBox(height: 4.h),
                Text('${widget.userProfile.email}',
                    style: GoogleFonts.poppins()),
                SizedBox(height: 4.h),
                Text("${widget.userProfile.mobile}",
                    style: CustomFont().subText),
                SizedBox(height: 10.h),
                ProfileTextfield(
                  icon: Icons.favorite,
                  title: "Wishlist",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Whishlist(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.h),
                ProfileTextfield(
                  icon: Icons.handshake_outlined,
                  title: "MyDonations",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyDonations(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.h),
                ProfileTextfield(
                  icon: Icons.app_registration,
                  title: "My Registrations",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyRegistration(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 5.h),
                ProfileTextfield(
                  icon: Icons.shopping_cart,
                  title: "My Orders",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyOrders(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 5.h),
                ProfileTextfield(
                  icon: Icons.notifications_active,
                  title: "Notifications",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 5.h),
                ProfileTextfield(
                  icon: Icons.person_2_sharp,
                  title: "Edit Profile",
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: EditProfile(),
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 220)));
                  },
                ),
                SizedBox(height: 5.h),
                ProfileTextfield(
                  icon: Icons.person_2_sharp,
                  title: "Change password",
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: const Color(0xFFEBEBEB),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return BlocProvider(
                          create: (context) => ChangePasswordBloc(
                            changePasswordRepo: ChangePasswordRepo(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SizedBox(
                              height: 320.h,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10)
                                    .w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Change Your Password",
                                      style: GoogleFonts.poppins(
                                        color: CustomColor.primaryColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Enter your current password and new password",
                                      style:
                                          GoogleFonts.poppins(fontSize: 14.sp),
                                    ),
                                    SizedBox(height: 15.h),
                                    CustomTextfield(
                                      focusNode: fieldOne,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context)
                                            .requestFocus(fieldTwo);
                                      },
                                      controller: old_passwordController,
                                      hintText: 'Enter Your Old Password',
                                      inputType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your old  password";
                                        }

                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomTextfield(
                                      focusNode: fieldTwo,
                                      controller: new_PassController,
                                      hintText: 'Enter Your New Password',
                                      inputType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a valid password";
                                        }
                                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                            .hasMatch(value)) {
                                          return 'Please enter a  password';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 25.h),
                                    BlocListener<ChangePasswordBloc,
                                        ChangePasswordState>(
                                      listener: (context, state) async {
                                        print("State is  loading = ${state}");
                                        if (state is ChangePasswordSucces) {
                                          Fluttertoast.showToast(
                                            backgroundColor: Colors.green,
                                            gravity: ToastGravity.BOTTOM,
                                            textColor: Colors.white,
                                            msg:
                                                "Password Updated Successfully",
                                          );
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          Navigator.pop(context);

                                          print("   = ${state}");
                                        } else if (state
                                            is ChangePasswordFailure) {
                                          Fluttertoast.showToast(
                                            backgroundColor: Colors.green,
                                            gravity: ToastGravity.BOTTOM,
                                            textColor: Colors.white,
                                            msg: "Enter Password Wrong",
                                          );
                                        }
                                      },
                                      child: BlocBuilder<ChangePasswordBloc,
                                          ChangePasswordState>(
                                        builder: (context, state) {
                                          if (state is ChangePasswordLoading) {
                                            return const CircularProgressIndicator();
                                          }
                                          return ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size(370.w, 48.h),
                                              backgroundColor:
                                                  CustomColor.primaryColor,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10).w,
                                              ),
                                            ),
                                            onPressed: () {
                                              print("State 10= ${state}");
                                              if (new_PassController
                                                      .text.isEmpty ||
                                                  old_passwordController
                                                      .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    backgroundColor:
                                                        Colors.white,
                                                    gravity:
                                                        ToastGravity.SNACKBAR,
                                                    textColor: Colors.red,
                                                    msg:
                                                        "Please fill in all fields");
                                              } else {
                                                context
                                                    .read<ChangePasswordBloc>()
                                                    .add(ChangePasswordSubmitted(
                                                        old_passwordController
                                                            .text,
                                                        new_PassController
                                                            .text));
                                              }
                                            },
                                            child: Text(
                                              "Confirm",
                                              style: CustomFont().buttontext,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(350.w, 48.h),
                    backgroundColor: CustomColor.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10).w,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.zero,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.logout_rounded,
                                color: CustomColor.primaryColor,
                                size: 60,
                              ),
                            ),
                            // Title
                            Text(
                              "Are You Sure?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Content text
                            Text(
                              "Do you want to logout?",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            SizedBox(height: 20),
                            Divider(height: 1, color: Colors.grey),
                            // Action buttons
                            Row(
                              children: [
                                // No Button
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pop(); // Close dialog
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          color: Colors.white),
                                      padding: EdgeInsets.all(15),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                // Yes Button
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              FirstPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                        ),
                                        color: CustomColor.primaryColor,
                                      ),
                                      padding: EdgeInsets.all(15),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text("Logout", style: CustomFont().buttontext),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
