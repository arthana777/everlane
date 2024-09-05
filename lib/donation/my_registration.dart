import 'package:everlane/data/models/disastermodel.dart';
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

class MyRegistration extends StatefulWidget {
  const MyRegistration({super.key});

  @override
  State<MyRegistration> createState() => _MyRegistrationState();
}

class _MyRegistrationState extends State<MyRegistration> {
  List<Disaster>myRegistrations=[];
  bool isLoading = false;
  @override
  void initState() {
    BlocProvider.of<AddressBloc>(context).add(fetchmyRegistrations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: PreferredSize(preferredSize: Size.fromHeight(80.h), child: CustomAppBar(
        text: 'MyRegistrations',
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
              if (state is MyRegistarionLoading) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is MyRegistrationLoaded) {
                setState(() {
                  isLoading = false;
                });
                myRegistrations = state.myRegistrations;
                print(myRegistrations);
                print("myRegistrations List Length: ${myRegistrations.length}");
                print("myRegistrations List: $myRegistrations");
                //final useraddress = state.userAddresses;
                print("adding to myRegistrations");
              }
              else if (state is MyRegistrationError) {
                // Dismiss loading indicator and show error message
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }

            },
          ),
        ],
        child:myRegistrations.isEmpty?
        Center(child: Text('"No Donations"',style: CustomFont().subtitleText,)): Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: Row(
                children: [
                  Text("MyRegistrations",style: CustomFont().subtitleText,),
                  SizedBox(width: 8.w,),
                  Container(
                    height: 20.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(child: Text(myRegistrations.length.toString(),style: CustomFont().subtitleText,)),
                  ),
                ],
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:myRegistrations.length,
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
                          height: 200.h,
                          decoration: BoxDecoration(
                            color:  Colors.white,
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(myRegistrations[index].name,style: CustomFont().subtitleText,),
                              Text(myRegistrations[index].location,style: CustomFont().bodyText,),
                              SizedBox(height: 15.h,),
                              Text("Requirements"),
                              Divider(thickness: 2,color: Colors.black12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Men: ",style: CustomFont().subtitleText,),
                                  Text(myRegistrations[index].fulfilledMenDresses.toString()),
                                  Text("/"),
                                  Text(myRegistrations[index].requiredMenDresses.toString()),
                                  SizedBox(
                                      height:75.h,
                                      child: VerticalDivider(thickness: 2,color: Colors.black12,)),

                                  Text("Women: ",style: CustomFont().subtitleText,),
                                  Text(myRegistrations[index].fulfilledWomenDresses.toString()),
                                  Text("/"),
                                  Text(myRegistrations[index].requiredWomenDresses.toString()),
                                  SizedBox(
                                      height:75.h,
                                      child: VerticalDivider(thickness: 2,color: Colors.black26,)),
                                  Text("Kidds: ",style: CustomFont().subtitleText,),
                                  Text(myRegistrations[index].fulfilledKidsDresses.toString()),
                                  Text("/"),
                                  Text(myRegistrations[index].requiredKidsDresses.toString()),

                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  );
                }
            ),
          ],
        )
      ),
    );
  }
}
