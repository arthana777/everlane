import 'dart:async';
import 'dart:io';

import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/customcolor.dart';

class UploadClothes extends StatefulWidget {
  const UploadClothes({super.key});

  @override
  State<UploadClothes> createState() => _UploadClothesState();
}

class _UploadClothesState extends State<UploadClothes> {
  double _progress = 0.0;
  Timer? _timer;
  File? _image;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }
  void _startTimer() {
    const duration = Duration(milliseconds: 100);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _timer?.cancel();
        }
      });
    });
  }
@override
  void dispose() {
  _timer?.cancel();
    super.dispose();
  }
  void _uploadClothes() {
    if (_image != null) {
     // context.read<AddressBloc>().add(uploadclothes(image: _image!));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50.h), child: CustomAppBar(text:"Upload your clothes",)),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: CustomColor.primaryColor,
        onPressed: () {
          _uploadClothes;
        },
        label: Container(
          height: 30.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: CustomColor.primaryColor,
          ),
          child: Center(
            child: Text("Register", style: CustomFont().buttontext),
          ),
        ),

      ),
      backgroundColor: Colors.white,
      body: MultiBlocListener(
        listeners: [

        ],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 300.h,
                      width: 700.w,  // Changed from 700.h to 700.w
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(
                            color: Colors.black26,
                            style: BorderStyle.solid,
                            width: 2),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://media.istockphoto.com/id/1695262506/photo/clothes-in-cardboard-box-on-blue-background.webp?b=1&s=170667a&w=0&k=20&c=0iWyzbsSQ_xLdWhqsjksnR7DNBuZXNGr9k7S765cGNk=",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80.h,
                      child: Container(
                        height: 150.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: Column(
                            children: [
                              Icon(
                                Icons.add,
                                size: 30.sp,
                              ),
                              Text("Upload your clothes"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                Text(
                  "Quality Checking..",
                 // style: CustomFont().subtitleText,
                ),
                SizedBox(height: 10.h),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 400.w,
                  height: 40.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      //value: 0.7,
                      value: _progress,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF973d93),),
                      backgroundColor: Colors.grey,
                    ),
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
