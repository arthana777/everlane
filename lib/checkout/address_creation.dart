import 'package:everlane/data/navigation_provider/navigation_provider.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../bloc/address/address_bloc.dart';
import '../data/models/addressmodel.dart';

import '../widgets/customcolor.dart';
import '../widgets/cutsofield_address.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

List<UserAddress> useradress = [];

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController houseNoController = TextEditingController();

  final TextEditingController pinCodeController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController landmarkController = TextEditingController();

  final TextEditingController receiverNameController = TextEditingController();

  final TextEditingController receiverPhoneController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _usernameError;
  String? _passwordError;
  String _mobileErrorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: CustomColor.primaryColor,
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Form is valid, proceed with action

            context.read<AddressBloc>().add(CreateAddress(
                  mobile: mobileController.text,
                  pincode: pinCodeController.text,
                  locality: localityController.text,
                  address: addressController.text,
                  city: cityController.text,
                  state: stateController.text,
                  landmark: landmarkController.text,
                  isDefault: true,
                  isActive: true,
                  isDeleted: false,
                ));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddressList(),
            //   ),
            // );
          } else {
            // Show toast if form is not valid
            Fluttertoast.showToast(
              msg: "Please fill out all fields.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0,
            );
          }
        },
        label: Container(
          height: 30.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: CustomColor.primaryColor,
          ),
          child: Center(
            child: Text("Proceed to Buy", style: CustomFont().buttontext),
          ),
        ),
        icon: Icon(
          Icons.shopping_bag_outlined,
          size: 20.sp,
          color: Colors.white,
        ),
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: "Create your Address",
            leading: InkWell(
                onTap: () {
                  final navigationProvider =
                      Provider.of<NavigationProvider>(context, listen: false);
                  navigationProvider.updateScreenIndex(0);
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back)),
          )),
      // body: MultiBlocListener(
      //   listeners: [
      //     BlocListener<AddressBloc, AddressState>(
      //     listener: (context, state) {
      //       print(state);
      //       if (state is AddressLoading) {
      //         showDialog(
      //           context: context,
      //           barrierDismissible: false,
      //           builder: (context) =>
      //               Center(child: CircularProgressIndicator()),
      //         );
      //       } else if (state is AddressCreationSuccess) {
      //         setState(() {
      //           Navigator.pop(context);
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             SnackBar(
      //                 content: Text('Adress created successfully!')),
      //           );
      //         });
      //
      //         //final useraddress = state.userAddresses;
      //         print("adding to addresslist");
      //       } else if (state is AddressError) {
      //         // Dismiss loading indicator and show error message
      //         Navigator.pop(context);
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(content: Text(state.message)),
      //         );
      //       }
      //
      //     },
      //   ),
      //   ],
      //   child: Padding(
      //     padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
      //     child: Form(
      //       key: _formKey,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //          // Container(
      //          //   height: 300,
      //          //   width: 200,
      //          //   color: Colors.purple,
      //          // ),
      //           Container(
      //             height: 50,
      //             width: 200,
      //             color: Colors.orangeAccent,
      //             child: AdrressCustomField(hinttext: 'House no/Flat no',
      //             inputType: TextInputType.text,
      //             //controller: houseNoController,
      //               // validator: (value) {
      //               //   if (value == null || value.isEmpty) {
      //               //     return 'Please enter the locality';
      //               //   }
      //               //   return null;
      //               // },
      //
      //             ),
      //           ),
      //           SizedBox(height: 20.h,),
      //           AdrressCustomField(hinttext: 'Pin Code',
      //             inputType: TextInputType.number,
      //             controller: pinCodeController,
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return 'Please enter the pin code';
      //               } else if (value.length != 6) {
      //                 return 'Pin code must be 6 digits';
      //               }
      //               return null;
      //             },
      //           ),
      //           SizedBox(height: 8.h,),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               AdrressCustomField(hinttext: 'City',width: 175.h,controller: cityController,inputType: TextInputType.text,
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return 'Please enter the city';
      //                   }
      //                   return null;
      //                 },
      //               ),
      //               AdrressCustomField(hinttext: 'State',width: 175.h,controller: stateController,inputType: TextInputType.text,
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return 'Please enter the state';
      //                   }
      //                   return null;
      //                 },),
      //
      //
      //             ],
      //           ),
      //           SizedBox(height: 8.h,),
      //           AdrressCustomField(hinttext: 'Landmark',controller: landmarkController,inputType: TextInputType.text,
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return 'Please enter the landmark';
      //               }
      //               return null;
      //             },),
      //           SizedBox(height: 20.h,),
      //           Text("Save as",style: CustomFont().titleText,),
      //           SizedBox(height: 10.h,),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               CustomAdressSelection(text: 'Home',),
      //               CustomAdressSelection(text: 'Work',),
      //               CustomAdressSelection(text: 'Friend',),
      //             ],
      //           ),
      //           SizedBox(height: 20.h,),
      //           AdrressCustomField(hinttext: 'Recievers Adress',controller: addressController,inputType: TextInputType.text,
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return 'Please enter the receiver\'s address';
      //               }
      //               return null;
      //             },
      //           ),
      //           SizedBox(height: 8.h,),
      //           AdrressCustomField(hinttext: 'Recievers Phone number',controller: mobileController,inputType: TextInputType.phone,
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return 'Please enter the phone number';
      //               } else if (value.length != 10) {
      //                 return 'Phone number must be 8 digits';
      //               }
      //               return null;
      //             },
      //               onchanged: (value){
      //                 setState(() {
      //                   if (value.length > 8) {
      //                     _mobileErrorMessage = 'Phone number cannot be more than 8 digits';
      //                   } else {
      //                     _mobileErrorMessage = '';
      //                   }
      //                 });
      //                 //String telNo = value==null?("+91" + value) :null
      //               },
      //             ),
      //           SizedBox(height: 8.h,),
      //           AdrressCustomField(hinttext: 'locality',controller: localityController,inputType: TextInputType.text,
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return 'Please enter the locality';
      //               }
      //               return null;
      //             },),
      //
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

      body: MultiBlocListener(
        listeners: [
          // BlocListener as you have it
          BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              print(state);
              if (state is AddressLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()),
                );
              } else if (state is AddressCreationSuccess) {
                setState(() {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Adress created successfully!')),
                  );
                });

                // final useraddress = state.userAddresses;
                print("adding to addresslist");
              } else if (state is AddressError) {
                // Dismiss loading indicator and show error message
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Purple Container
                        Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.purple,
                        ),
                        SizedBox(height: 20.h),
                        // Rest of the form fields
                        AdrressCustomField(
                          hinttext: 'House no/Flat no',
                          inputType: TextInputType.text,
                          controller: houseNoController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the locality';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        AdrressCustomField(
                          hinttext: 'Pin Code',
                          inputType: TextInputType.number,
                          controller: pinCodeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the pin code';
                            } else if (value.length != 6) {
                              return 'Pin code must be 6 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdrressCustomField(
                              hinttext: 'City',
                              width: 175.h,
                              controller: cityController,
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the city';
                                }
                                return null;
                              },
                            ),
                            AdrressCustomField(
                              hinttext: 'State',
                              width: 175.h,
                              controller: stateController,
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the state';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        AdrressCustomField(
                          hinttext: 'Landmark',
                          controller: landmarkController,
                          inputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the landmark';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        Text("Save as", style: CustomFont().titleText),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomAdressSelection(text: 'Home'),
                            CustomAdressSelection(text: 'Work'),
                            CustomAdressSelection(text: 'Friend'),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        AdrressCustomField(
                          hinttext: 'Recievers Adress',
                          controller: addressController,
                          inputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the receiver\'s address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8.h),
                        AdrressCustomField(
                          hinttext: 'Recievers Phone number',
                          controller: mobileController,
                          inputType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the phone number';
                            } else if (value.length != 10) {
                              return 'Phone number must be 8 digits';
                            }
                            return null;
                          },
                          onchanged: (value) {
                            setState(() {
                              if (value.length > 8) {
                                _mobileErrorMessage =
                                    'Phone number cannot be more than 8 digits';
                              } else {
                                _mobileErrorMessage = '';
                              }
                            });
                          },
                        ),
                        SizedBox(height: 8.h),
                        AdrressCustomField(
                          hinttext: 'locality',
                          controller: localityController,
                          inputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the locality';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
