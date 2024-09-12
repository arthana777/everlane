import 'package:everlane/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../bloc/address/address_bloc.dart';
import '../data/navigation_provider/navigation_provider.dart';
import '../widgets/customfont.dart';

class MyDonations extends StatefulWidget {
  const MyDonations({super.key});

  @override
  State<MyDonations> createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  @override
  void initState() {
    BlocProvider.of<AddressBloc>(context).add(fetchMydonations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomAppBar(
          text: 'My Donations',
          leading: InkWell(
            onTap: () {
              final navigationProvider =
                  Provider.of<NavigationProvider>(context, listen: false);
              navigationProvider.updateScreenIndex(0);
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is MydonationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MydonationError) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 160),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 200.w,
                      height: 200.h,
                      child: Image.network(
                        "https://i.pinimg.com/564x/82/ff/bb/82ffbbef2f477445b44a96512ee27975.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text("No Donations yet", style: CustomFont().titleText),
                  SizedBox(
                    height: 11.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "You have no Donation right now.\nCome back later..",
                    style: GoogleFonts.poppins(
                        color: Colors.grey, fontSize: 13.sp),
                  ),
                ],
              ),
            );
          } else if (state is MydonationLoaded) {
            final mydonations = state.mydonations;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Row(
                      children: [
                        Text(
                          "Donations",
                          style: CustomFont().subtitleText,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                              child: Text(
                            mydonations.length.toString(),
                            style: CustomFont().subtitleText,
                          )),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: mydonations.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: InkWell(
                          onTap: () {
                            // Handle tap event
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 150.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mydonations[index].disasterName,
                                  style: CustomFont().subtitleText,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.black12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Men: ",
                                      style: CustomFont().subtitleText,
                                    ),
                                    Text(mydonations[index]
                                        .menDresses
                                        .toString()),
                                    SizedBox(
                                      height: 75.h,
                                      child: VerticalDivider(
                                        thickness: 2,
                                        color: Colors.black12,
                                      ),
                                    ),
                                    Text(
                                      "Women: ",
                                      style: CustomFont().subtitleText,
                                    ),
                                    Text(mydonations[index]
                                        .womenDresses
                                        .toString()),
                                    SizedBox(
                                        height: 75.h,
                                        child: VerticalDivider(
                                          thickness: 2,
                                          color: Colors.black26,
                                        )),
                                    Text(
                                      "Kids: ",
                                      style: CustomFont().subtitleText,
                                    ),
                                    Text(mydonations[index]
                                        .kidsDresses
                                        .toString()),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is MydonationError) {
            return Center(
              child: Text("Error: ${state.message}"),
            );
          }

          return Container();
        },
      ),
    );
  }
}
