import 'package:everlane/checkout/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../bloc/address/address_bloc.dart';
import '../data/models/pickupmodel.dart';
import '../data/navigation_provider/navigation_provider.dart';
import '../widgets/customappbar.dart';

class  Pickuplocations extends StatefulWidget {
  const  Pickuplocations({super.key});

  @override
  State<Pickuplocations> createState() => _PickuplocationsState();
}

class _PickuplocationsState extends State<Pickuplocations> {
  List<PickupLocation>pickuplocations=[];


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AddressBloc>(context).add(Fetchpickuplocations());
    });
   // BlocProvider.of<AddressBloc>(context).add(Fetchpickuplocations(),
   // context.read<AddressBloc>().add(Fetchpickuplocations()
    //);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(80.h), child: CustomAppBar(
        leading: InkWell(
            onTap: (){
              final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
              navigationProvider.updateScreenIndex(0);
              Navigator.pop(context, {
                'name': pickuplocations[0].address,
                'location': pickuplocations[0].city,
              });
              // Navigator.pop(
              //   context,
              //   MaterialPageRoute(builder: (context) => PaymentScreen()),
              //
              // );
            },
            child: Icon(Icons.arrow_back)),
        text: "PickUplocations",
      )),
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
                setState(() {

                });
                pickuplocations = state.pickuplocations;
                //final useraddress = state.userAddresses;
                print("adding to pickuplocations");
                print("Pickuploaded state received with ${pickuplocations.length} locations");
              }

              else if (state is AddressError) {
                // Dismiss loading indicator and show error message
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }

            },
          ),
        ],
        child: pickuplocations.isEmpty?Center(child: Text("No address available"),):ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: pickuplocations.length,
            itemBuilder: (context,index){
              print("pickupllengthhh${pickuplocations.length}");
              print(pickuplocations[index].city);
              // final address = state.userAddresses[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (Context)=>PaymentScreen(pickupLocation: pickuplocations[index],)));
                    },
                    child: Container(
                      height: 150.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween
                          ,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(pickuplocations[index].address),
                                Text(pickuplocations[index].city),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
