
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../data/navigation_provider/navigation_provider.dart';
import 'disaster_list.dart';
import 'donation_address.dart';

class DonationHomeScreen extends StatelessWidget {
  const DonationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(100.h), child: CustomAppBar(
        color: Colors.transparent,
        text: "Donate here",
        leading: InkWell(
            onTap: (){
              final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
              navigationProvider.updateScreenIndex(0);
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      )),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
         // crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 844.h,
                  width: 390.w,
                 decoration: BoxDecoration(
                   color: Colors.grey,
                   image: DecorationImage(
                       image: NetworkImage("https://images.unsplash.com/photo-1562157873-818bc0726f68?q=80&w=1854&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                   fit: BoxFit.cover,opacity: 0.6)
                 ),
                ),
                Positioned(
                  top: 400.h,
        
                  child:   InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisasterRegistration(),
                      ),
                    );
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 50.w,vertical: 10.h),
                    child: Container(
                      // padding: EdgeInsets.,
                      height: 50.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                          color: CustomColor.primaryColor,
                          border: Border.all(color: Colors.black26,),
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Center(child: Text("Disaster Registration",style: CustomFont().buttontext,)),
                    ),
                  ),
                ),),
                Positioned(
                  top: 500.h,
                  child:  InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisasterList(),
                      ),
                    );
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 50.w,vertical: 10.h),
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 30),
                      height: 50.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                          color: CustomColor.primaryColor,
                          border: Border.all(color: Colors.black26,),
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Center(child: Text("Donate ",style: CustomFont().buttontext,)),
                    ),
                  ),
                ),)
        
              ],
            ),
        
        
        
            SizedBox(height: 80.h,),
        
          ],
        ),
      ),
    );
  }
}
