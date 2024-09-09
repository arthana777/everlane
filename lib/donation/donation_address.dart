
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


import '../bloc/address/address_bloc.dart';
import '../data/models/userprofile.dart';
import '../data/navigation_provider/navigation_provider.dart';
import '../widgets/customcolor.dart';
import '../widgets/cutsofield_address.dart';

class DisasterRegistration extends StatefulWidget {
  DisasterRegistration({super.key, this.userProfile});
  final  Userprofile? userProfile;
  @override
  State<DisasterRegistration> createState() => _DisasterRegistrationState();
}

class _DisasterRegistrationState extends State<DisasterRegistration> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController disatertypeController = TextEditingController();

  final TextEditingController adharController = TextEditingController();

  final TextEditingController landmarkController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController requiredWomenDressesController = TextEditingController();

  final TextEditingController requiredMenDressesController = TextEditingController();

  final TextEditingController requiredKidsDressesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? selectedDisasterType;
  bool isNameFilled = false;
  bool isLocationFilled = false;
  bool isAadharFilled = false;
  bool isLandmarkFilled = false;
  bool isDescriptionFilled = false;
  //bool isButtonEnabled = true;


  void _validateForm() {
    setState(() {
      nameController.text.isNotEmpty &&
          locationController.text.isNotEmpty &&
          disatertypeController.text.isNotEmpty &&
          adharController.text.isNotEmpty &&
          adharController.text.length == 12 && // Ensure Aadhar is 12 digits
          landmarkController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          requiredWomenDressesController.text.isNotEmpty &&
          requiredMenDressesController.text.isNotEmpty &&
          requiredKidsDressesController.text.isNotEmpty;
    });
  }
  @override
  void initState() {
    nameController.addListener(_validateForm);
    locationController.addListener(_validateForm);
    disatertypeController.addListener(_validateForm);
    adharController.addListener(_validateForm);
    landmarkController.addListener(_validateForm);
    descriptionController.addListener(_validateForm);
    requiredWomenDressesController.addListener(_validateForm);
    requiredMenDressesController.addListener(_validateForm);
    requiredKidsDressesController.addListener(_validateForm);
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    disatertypeController.dispose();
    adharController.dispose();
    landmarkController.dispose();
    descriptionController.dispose();
    requiredWomenDressesController.dispose();
    requiredMenDressesController.dispose();
    requiredKidsDressesController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: CustomColor.primaryColor,
        onPressed: () {
    if (_formKey.currentState?.validate() ?? false) {
    context.read<AddressBloc>().add(DisasterReg(
    name: nameController.text,
    location: locationController.text,
    adhar: adharController.text,
    description: descriptionController.text,
    landmark: landmarkController.text,
    requiredMenDresses: int.tryParse(requiredMenDressesController.text) ?? 0,
    requiredWomenDresses: int.tryParse(requiredWomenDressesController.text) ?? 0,
    requiredKidsDresses: int.tryParse(requiredKidsDressesController.text) ?? 0,

    ));

    Fluttertoast.showToast(
    msg: "Disaster Registerd Successfully",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.white,
    textColor: Colors.black,
    fontSize: 16.0,
    );

    nameController.clear();
    locationController.clear();
    adharController.clear();
    landmarkController.clear();
    descriptionController.clear();
    requiredWomenDressesController.clear();
    requiredMenDressesController.clear();
    requiredKidsDressesController.clear();
    setState(() {
    selectedDisasterType = null;
    });
    }
    else {
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

          child: Center(
            child: Text("Register", style: CustomFont().buttontext),
          ),
        ),

      ),
      appBar: PreferredSize(preferredSize: Size.fromHeight(50.h), child: CustomAppBar(
        text: "Register Disaster",
        leading: InkWell(
            onTap: (){
              final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
              navigationProvider.updateScreenIndex(0);
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),

      )),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "${widget.userProfile?.username ?? 'N/A'}",
                //   style: CustomFont().subtitleText,
                // ),
                AdrressCustomField(
                  hinttext: widget.userProfile?.username?.isNotEmpty == true
                      ? widget.userProfile?.username
                      : 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h,),
                AdrressCustomField(hinttext: 'Place of Disaster',controller: nameController,
                  validator: (value) {
                    if (isNameFilled || (value != null && value.isNotEmpty)) {
                      isNameFilled = true; // Mark as filled
                      return null;
                    }
                    return 'Please enter Place of Disaster';
                  },),
                SizedBox(height: 15.h,),
                AdrressCustomField(hinttext: 'location',controller: locationController,
                  validator: (value) {
                    if (isLocationFilled || (value != null && value.isNotEmpty)) {
                      isLocationFilled = true; // Mark as filled
                      return null;
                    }
                    return 'Please enter location';
                  },
                ),
                SizedBox(height: 15.h,),
                AdrressCustomField(
                  inputType: TextInputType.number,
                  hinttext: 'Adhar id',controller: adharController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid Aadhar Id';
                    } else if (value.length != 12) {
                      return 'Aadhar number must be exactly 12 digits';
                    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Aadhar number should only contain digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h,),
                AdrressCustomField(hinttext: 'Landmark',controller: landmarkController,
                  validator: (value) {
                    if (isLandmarkFilled || (value != null && value.isNotEmpty)) {
                      isLandmarkFilled = true; // Mark as filled
                      return null;
                    }
                    return 'Please enter landmark';
                  },
                ),
                SizedBox(height: 15.h,),
                AdrressCustomField(hinttext: 'Description',heigth: 100.h,controller: descriptionController,
                  validator: (value) {
                    if (isDescriptionFilled || (value != null && value.isNotEmpty)) {
                      isDescriptionFilled = true; // Mark as filled
                      return null;
                    }
                    return 'Please enter Description';
                  },
                ),
                SizedBox(height: 25.h,),
                Text("Type of Disaster",style: CustomFont().subtitleText,),
                SizedBox(height: 15.h,),
                AdrressCustomField(hinttext: 'Type of Disaster',inputType: TextInputType.text,
                controller: disatertypeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter disater type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h,),
                Text("Requirements",style: CustomFont().subtitleText,),
                AdrressCustomField(hinttext: ' No of women clothes',inputType: TextInputType.number,controller: requiredWomenDressesController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the data';
                    }
                    return null;
                  },),
                SizedBox(height: 15.h,),
                AdrressCustomField(hinttext: 'No of men clothes',inputType: TextInputType.number,controller: requiredMenDressesController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the data';
                    }
                    return null;
                  },),
                SizedBox(height: 15.h,),
                AdrressCustomField(hinttext: 'No of kidd clothes',inputType: TextInputType.number,controller: requiredKidsDressesController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the data';
                    }
                    return null;
                  },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
