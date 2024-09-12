import 'package:everlane/data/models/disastermodel.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../bloc/address/address_bloc.dart';
import '../data/navigation_provider/navigation_provider.dart';
import '../widgets/customfont.dart';

class MyRegistration extends StatefulWidget {
  const MyRegistration({super.key});

  @override
  State<MyRegistration> createState() => _MyRegistrationState();
}

class _MyRegistrationState extends State<MyRegistration> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressBloc>(context).add(fetchmyRegistrations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomAppBar(
          text: 'MyRegistrations',
          leading: InkWell(
            onTap: () {
              final navigationProvider =
                  Provider.of<NavigationProvider>(context, listen: false);
              navigationProvider.updateScreenIndex(0);
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is MyRegistarionLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MyRegistrationError) {
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
                        "https://i.pinimg.com/736x/04/e7/39/04e739d95a80015f15e66e7f76395fd4.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text("No Registration found", style: CustomFont().titleText),
                  SizedBox(height: 11.h),
                  Text(
                    textAlign: TextAlign.center,
                    "You have no registration right now.\nCome back later..",
                    style: GoogleFonts.poppins(
                        color: Colors.grey, fontSize: 13.sp),
                  ),
                ],
              ),
            );
          } else if (state is MyRegistrationLoaded) {
            final myRegistrations = state.myRegistrations;
            return Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Row(
                    children: [
                      Text(
                        "MyRegistrations",
                        style: CustomFont().subtitleText,
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(
                          child: Text(
                            myRegistrations.length.toString(),
                            style: CustomFont().subtitleText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: myRegistrations.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: InkWell(
                        onTap: () {
                          // Handle onTap action if needed
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                myRegistrations[index].name,
                                style: CustomFont().subtitleText,
                              ),
                              Text(
                                myRegistrations[index].location,
                                style: CustomFont().bodyText,
                              ),
                              SizedBox(height: 15.h),
                              Text("Requirements"),
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
                                  Text(myRegistrations[index]
                                      .fulfilledMenDresses
                                      .toString()),
                                  Text("/"),
                                  Text(myRegistrations[index]
                                      .requiredMenDresses
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
                                  Text(myRegistrations[index]
                                      .fulfilledWomenDresses
                                      .toString()),
                                  Text("/"),
                                  Text(myRegistrations[index]
                                      .requiredWomenDresses
                                      .toString()),
                                  SizedBox(
                                    height: 75.h,
                                    child: VerticalDivider(
                                      thickness: 2,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  Text(
                                    "Kids: ",
                                    style: CustomFont().subtitleText,
                                  ),
                                  Text(myRegistrations[index]
                                      .fulfilledKidsDresses
                                      .toString()),
                                  Text("/"),
                                  Text(myRegistrations[index]
                                      .requiredKidsDresses
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
            );
          } else if (state is MyRegistrationError) {
            return Center(
              child: Text("Error:${state.message}"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
