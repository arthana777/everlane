import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: CustomAppBar(
            color: Colors.transparent,
            leading: InkWell(
                onTap: () {
                  final navigationProvider =
                      Provider.of<NavigationProvider>(context, listen: false);
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
                          image: NetworkImage(
                            "https://media.istockphoto.com/id/840639252/photo/hands-holding-heart.jpg?s=612x612&w=0&k=20&c=PMqtQ5bbe4d4s1fYcNUSAZyEQBeDqumymuyZC3PRt-Y="
                             //"https://plus.unsplash.com/premium_photo-1661904004367-7f73cb7e6e03?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEyfHx8ZW58MHx8fHx8"
                              //"https://img.freepik.com/free-photo/young-peeple-red-packing-cardboards-with-humanitarian-help_259150-57380.jpg?ga=GA1.1.1985107230.1716028092&semt=ais_hybrid"
                            //"https://img.freepik.com/free-photo/volunteer-helping-with-donation-box_23-2149230501.jpg?ga=GA1.1.1985107230.1716028092",
                          ),
                          fit: BoxFit.cover,
                          opacity: 0.5)),
                ),
                Positioned(
                  top: 200.h,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisasterRegistration(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10.h),
                      child: Container(
                        // padding: EdgeInsets.,
                        height: 50.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                            color: CustomColor.primaryColor.withOpacity(0.8),
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                            child: Text(
                          "Help us to keep track",
                          style: CustomFont().buttontext,
                        )),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 300.h,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisasterList(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10.h),
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 30),
                        height: 50.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                            color: CustomColor.primaryColor.withOpacity(0.8),
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                            child: Text(
                          "Donate now! ",
                          style: CustomFont().buttontext,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      ),
    );
  }
}
