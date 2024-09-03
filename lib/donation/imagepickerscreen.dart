import 'dart:io';
import 'package:everlane/widgets/cutsofield_address.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:everlane/data/models/disastermodel.dart';
import 'package:everlane/data/navigation_provider/navigation_provider.dart';
import 'package:everlane/donation/upload_clothes.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/address/address_bloc.dart';
import '../btm_navigation/btm_navigation.dart';


import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../data/models/pickupmodel.dart';
import '../widgets/customcircularindicator.dart';


class ImagePickerScreen extends StatefulWidget {
  final Disaster? disaster;
  final PickupLocation? pickuplocation;
  final String? location;

  ImagePickerScreen({super.key,  this.disaster, this.location, this.pickuplocation,});
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  List<File> images = [];
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController menController = TextEditingController();
  final TextEditingController womenController = TextEditingController();
  final TextEditingController kidsController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }
  Future<void> _uploadFromGallery() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();  // Pick multiple images
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        images.addAll(pickedFiles.map((file) => File(file.path)).toList());  // Add all selected images to the list
      });
    }
  }


  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }
  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100.h,
          child:
            // ListTile(
            //   leading: Icon(Icons.add_a_photo),
            //   title: Text('Add Image'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     _pickImage();
            //   },
            // ),
            Center(
              child: ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Upload from Gallery',style: CustomFont().subtitleText,),
                onTap: () {
                  Navigator.of(context).pop();
                  _uploadFromGallery();
                },
              ),
            ),

        );
      },
    );
  }

  final List<String> item1 = [
    "kochi",
    'calicut',
    'tirur',
    'kannur',
    'malappuram',
  ];
  late  String dropedownvalue1;


  @override
  void initState() {
    setState(() {
      isLoading=false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AddressBloc>(context).add(Fetchpickuplocations());
    });
    if (pickuplocations.isNotEmpty) {
      selectedLocation = pickuplocations.first;
    }
    super.initState();
  }


  Future<XFile?> compressImage(File file) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final compressedFilePath = path.join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}_compressed.jpg');
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.path,
        compressedFilePath,
        quality: 88,
      );
      return compressedFile != null ? XFile(compressedFilePath) : null;
    } catch (e) {
      print('Error compressing image: $e');
      return null;
    }
  }


  void _uploadImages() {
    print(widget.disaster?.id);
    if (images.isNotEmpty) {

      context.read<AddressBloc>().add(uploadclothes(

        disasterId: widget.disaster?.id??0,
        //images: images,
        images: images,
          men: menController.text.isNotEmpty ? int.tryParse(menController.text) : null,
          women: womenController.text.isNotEmpty ? int.tryParse(womenController.text):null,
          kids:kidsController.text.isNotEmpty ? int.tryParse(kidsController.text):null,
        pickup: selectedLocation?.id,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select images')),
      );
    }
  }


  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();
  List<PickupLocation>pickuplocations=[];
  PickupLocation? selectedLocation;
  //List<DropdownMenuItem<PickupLocation>>pickuplocations=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: CustomColor.primaryColor,
        onPressed: (){
          if (_formKey.currentState?.validate() ?? false){
            _uploadImages();
            Fluttertoast.showToast(
              msg: "uploaded succesfully.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0,
            );
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
          decoration: BoxDecoration(
            color: CustomColor.primaryColor,
          ),
          child: Center(
            child: Text("Donate", style: CustomFont().buttontext),
          ),
        ),

      ),
      appBar:PreferredSize(preferredSize: Size.fromHeight(80.h), child: CustomAppBar(
        text: "Upload clothes",
        leading: InkWell(
            onTap: (){
              final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
              navigationProvider.updateScreenIndex(0);
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      action: [
        IconButton(onPressed: () => _showMenu(context), icon: Icon(Icons.add,size: 30.sp,))
      ],),),
      body: MultiBlocListener(
        listeners: [

          BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              print(state);
              if (state is Pickuploading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()),
                );
              }
              else if (state is Pickuploaded) {
               print(state);
                pickuplocations = state.pickuplocations;
                setState(() {

                });
                //final useraddress = state.userAddresses;
                print("adding to pickuplocations");
                print("Pickuploaded state received with ${pickuplocations.length} locations");
              }

            },
          ),
          BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              print(state);
              if (state is AddressLoading) {
               setState(() {
                 isLoading=true;
               });
              } else if (state is uploadclothesuccess) {
                setState(() {
                  isLoading=false;
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Upload successful')),
                );

                print("image uploading");
              }
              else if (state is AddressError) {
                setState(() {
                  isLoading=false;
                });
                // Dismiss loading indicator and show error message
                Navigator.pop(context);
                Fluttertoast.showToast(
                  msg: "Please upload valid image!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                print('Error: ${state.message}');
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text(state.message)),
                // );
              }

            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child:isLoading
    ? Padding(
    padding:  EdgeInsets.symmetric(vertical: 300.h),
    child: CustomCircularProgressIndicator(),): Form(
              key: _formKey,
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: images.isEmpty
                        ? Center(child: Text('No images selected.'))
                        : SizedBox(
                      height: 400.h,  // Adjust height as needed
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 200.w,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Stack(
                              children: [
                                Container(
                                  height: 400.h,
                                  width: double.infinity,
                                  child: Image.file(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 5.w,
                                  top: 5.h,
                                  child: InkWell(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      height: 20.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.r),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.delete,
                                          size: 15.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              SizedBox(height: 50.h,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Text("Choose pickup location", style: CustomFont().subtitleText,),
                  ),


                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose Pickup location"),
                          DropdownButton<PickupLocation>(
                            value: selectedLocation,
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            underline: SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: pickuplocations.map((PickupLocation location) {
                              return DropdownMenuItem<PickupLocation>(
                                value: location,
                                child: Text(location.city),
                              );
                            }).toList(),
                            onChanged: (PickupLocation? newValue) {
                              setState(() {
                                selectedLocation = newValue!;
                              });
                            },
                          ),
                        ],
                      )
                    ),
                  ),


              SizedBox(height: 50.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Text(" Selected Disaster :   ",style: CustomFont().subtitleText,),
                        Text(widget.disaster?.name??"jjj",style: CustomFont().bodyText,),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h,),


                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: AdrressCustomField(
                      controller: menController,
                      hinttext: 'Required Dresses for Men',
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the data';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: AdrressCustomField(
                      controller: womenController,
                      hinttext: 'Required Dresses for Women',
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the data';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: AdrressCustomField(
                      controller: kidsController,
                      hinttext: 'Required Dresses for Kids',
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the data';
                        }
                        return null;
                      },
                    ),
                  )



                ],
              ),
    ),
          ),
        ),
      ),
    );
  }
  // Future<String?> getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? stringValue = prefs.getString('auth_token');
  //   print("stringvalueee${stringValue}");
  //   return stringValue;
  // }




}
