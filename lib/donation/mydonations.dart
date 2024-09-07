import 'package:everlane/widgets/customappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../bloc/address/address_bloc.dart';
import '../data/models/mydonationsmodel.dart';
import '../data/navigation_provider/navigation_provider.dart';
import '../widgets/customcircularindicator.dart';
import '../widgets/customfont.dart';

class MyDonations extends StatefulWidget {
  const MyDonations({super.key});

  @override
  State<MyDonations> createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  List<Donation>mydonations=[];
  bool isLoading = false;
  @override
  void initState() {
    BlocProvider.of<AddressBloc>(context).add(fetchMydonations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: PreferredSize(preferredSize: Size.fromHeight(80.h), child: CustomAppBar(
        text: 'MyDonations',
        leading: InkWell(
            onTap: (){
              final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
              navigationProvider.updateScreenIndex(0);
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),

      )),
      body:  MultiBlocListener(
        listeners: [
          BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              print(state);
              if (state is MydonationLoading) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is MydonationLoaded) {
                setState(() {
                  isLoading = false;
                });
                mydonations = state.mydonations;
                print(mydonations);
                print("mydonations List Length: ${mydonations.length}");
                print("mydonations List: $mydonations");
                //final useraddress = state.userAddresses;
                print("adding to mydonations");
              }
              else if (state is MydonationError) {
                // Dismiss loading indicator and show error message
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }

            },
          ),
        ],
        child:mydonations.isEmpty?
        Center(child: Text('"No Donations"',style: CustomFont().subtitleText,)):
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                child: Row(
                  children: [
                    Text("Donations",style: CustomFont().subtitleText,),
                    SizedBox(width: 8.w,),
                    Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Center(child: Text(mydonations.length.toString(),style: CustomFont().subtitleText,)),
                    ),
                  ],
                ),
              ),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:mydonations.length,
              itemBuilder: (context, index) {
                return  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: InkWell(
                      onTap: (){
                        setState(() {
          
                        });
          
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        height: 150.h,
                        decoration: BoxDecoration(
                          color:  Colors.white,
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mydonations[index].disasterName,style: CustomFont().subtitleText,),
                            // Text(disaster[index].location,style: CustomFont().bodyText,),
                            SizedBox(height: 15.h,),
          
                            Divider(thickness: 2,color: Colors.black12,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Men: ",style: CustomFont().subtitleText,),
                              Text(mydonations[index].menDresses.toString()),
                                SizedBox(
                                    height:75.h,
                                    child: VerticalDivider(thickness: 2,color: Colors.black12,)),
          
                               Text("Women: ",style: CustomFont().subtitleText,),
                               // Text(disaster[index].requiredWomenDresses.toString()),
                                Text(mydonations[index].womenDresses.toString()),
                               // Text(disaster[index].fulfilledWomenDresses.toString()),
                                SizedBox(
                                    height:75.h,
                                    child: VerticalDivider(thickness: 2,color: Colors.black26,)),
                                Text("Kidds: ",style: CustomFont().subtitleText,),
                                //Text(disaster[index].requiredKidsDresses.toString()),
                                Text(mydonations[index].kidsDresses.toString()),
                               // Text(disaster[index].fulfilledKidsDresses.toString()),
          
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                );
              }
          ),
                ]
          ),
        )
      ),
    );
  }
}
