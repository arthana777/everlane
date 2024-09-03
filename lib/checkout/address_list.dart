import 'package:everlane/bloc/address/address_bloc.dart';
import 'package:everlane/checkout/address_creation.dart';
import 'package:everlane/checkout/payment.dart';
import 'package:everlane/data/navigation_provider/navigation_provider.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../btm_navigation/btm_navigation.dart';
import '../cartscreen/cartscreen.dart';
import '../data/models/addressmodel.dart';
import '../widgets/customcircularindicator.dart';


class AddressList extends StatefulWidget {
   AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  List<UserAddress>useradress=[];
  bool isLoading = true;
@override

  void initState() {
  BlocProvider.of<AddressBloc>(context).add(FetchUserAddresses());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(80.h), child: CustomAppBar(
        action: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressScreen()));
          }, icon: Icon(Icons.add,size: 25.sp,)),
        ],
        leading: InkWell(
            onTap: (){
              // final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
              // navigationProvider.updateScreenIndex(0);
             Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        text: "Select Address",
      )),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              print(state);
              if (state is AddressLoading) {
                setState(() {
                  isLoading = true;
                });
              }
              else if (state is AddressLoaded) {
                setState(() {
                  isLoading = false;
                });
                useradress = state.userAddresses;
                //final useraddress = state.userAddresses;
                print("adding to addresslist");
              }
              else if (state is DeleteAdresssuccess) {
                setState(() {
                  useradress.removeWhere((item) => item.id == state.addressid);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item deleted successfully')),
                );

              }else if (state is AddressError) {
                // Dismiss loading indicator and show error message
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }

            },
          ),
        ],
        child:isLoading
            ? CustomCircularProgressIndicator(): useradress.isEmpty?Center(child: Text("No address available"),):ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: useradress.length,
            itemBuilder: (context,index){
            print(useradress.length);
            print(useradress[index].address);
             // final address = state.userAddresses[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (Context)=>PaymentScreen(address: useradress[index])));
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
                                Text(useradress[index].address),
                                Text(useradress[index].state),
                                Text(useradress[index].city),
                                Text(useradress[index].pincode),
                                Text(useradress[index].mobile),
                                Text(useradress[index].locality),

                              ],
                            ),
                            IconButton(onPressed: (){
                              BlocProvider.of<AddressBloc>(context)
                                  .add(DeleteAddress(useradress[index].id),
                              );
                            }, icon: Icon(Icons.delete))
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
