import 'package:everlane/checkout/myorderitem.dart';
import 'package:everlane/checkout/myorders.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../bloc/cart/cart_bloc.dart';
import '../data/models/ordermodel.dart';
import '../data/navigation_provider/navigation_provider.dart';
import '../widgets/cutsofield_address.dart';
import '../widgets/orderdetailitem.dart';

class OrderDetails extends StatefulWidget {
   OrderDetails({super.key, this.title, this.status, this.paymentmethod, this.orders, this.image, this.quatity, this.orderid, this.retunstatus});
  final String? title;
  final String? image;
  final int? quatity;
  final int? orderid;
  final String? status;
  final String? retunstatus;
  final String? paymentmethod;
  final Order? orders;



  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late String returnStatus;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController returnreason = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  List<Item> items = [];
void _showModalSheet(BuildContext context)async {

   // List<UserAddress>useradress=[];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child:   MultiBlocListener(
              listeners: [
                // BlocListener<AddressBloc, AddressState>(
                //   listener: (context, state) {
                //     print(state);
                //     if (state is AddressLoading) {
                //       setState(() {
                //
                //       });
                //     }
                //     else if (state is AddressLoaded) {
                //       setState(() {
                //         //BlocProvider.of<AddressBloc>(context).add(FetchUserAddresses());
                //       });
                //       useradress = state.userAddresses;
                //       //final useraddress = state.userAddresses;
                //       print("adding to addresslist");
                //     }
                //     else if (state is DeleteAdresssuccess) {
                //       setState(() {
                //         useradress.removeWhere((item) => item.id == state.addressid);
                //       });
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text('Item deleted successfully')),
                //       );
                //
                //     }else if (state is AddressError) {
                //       // Dismiss loading indicator and show error message
                //       Navigator.pop(context);
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text(state.message)),
                //       );
                //     }
                //
                //   },
                // ),
              ],
              child:SingleChildScrollView(
                child: Column(

                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w),
                      child: Container(
                        height: 80.h,
                        width: 400.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ),
          );
        },
      ),
    ).whenComplete(() {
      setState(() {


      });
    },);
  }

  @override
  void initState() {
    returnStatus = widget.retunstatus ?? "NO_RETURN";
    items = widget.orders!.items;
    //BlocProvider.of<CartBloc>(context).add(ReturnOrder());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(80.h), child: CustomAppBar(
        text: 'OrderDetails',
        leading: InkWell(
          onTap: () {
            final navigationProvider =
            Provider.of<NavigationProvider>(context, listen: false);
            navigationProvider.updateScreenIndex(0);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyOrders()),
                  (Route<dynamic> route) => false,
            );
          },
          child: Icon(Icons.arrow_back),
        ),
      )),
      backgroundColor: Colors.white,


      body: MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              print(state);
              if (state is Returnloading) {
                // Handle loading state
              } else if (state is ReturnSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Return successful!')),
                );
              }


              else if (state is ReturnError) {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Already Requested')),
                );
              }
              else if (state is CancelorderLoaded) {
                setState(() {

                  items.removeWhere((item) => item.id == state.orderid);

                });
              }

            },
          ),
        ],
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w,),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: widget.orders?.items.length,
                      itemBuilder: (context,index){
                        final item = widget.orders?.items[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OrderDetailitem(
                            title: item?.productName??'',
                            orderstatus: widget.orders?.orderStatus,
                            image: item?.productImage,
                            type: widget.orders?.paymentMethod,
                            quatity: item?.quantity,
                            returnstatus: item?.orderitemstatus,
                            text: item?.orderitemstatus == "Canceled"
                                ? "Canceled"
                                : item?.orderitemstatus == "Completed"
                                ? "Cancel"
                                : item?.orderitemstatus == "Pending" || item?.orderitemstatus == "Processing"
                                ? "Request Return"
                                : item?.orderitemstatus == "Requested"
                                ? "Requested for Return"
                                : ""
                              ,
                            // text: item?.orderitemstatus == "Canceled"
                            //     ?"Canceled":"Cancel",

                                // : item?.orderitemstatus == "Completed"
                                // ? " Return"
                                // : "Return Requested",
                              ontapremove:  (){
                              if( item?.orderitemstatus == "Canceled"){
                                BlocProvider.of<CartBloc>(context).add(CancelOrderevent(items[index].id),);
                              }
                              else if(item?.orderitemstatus == "Pending" || item?.orderitemstatus == "Processing"){

                                final returnQuantity = int.tryParse(quantity.text);
                                context.read<CartBloc>().add(ReturnOrder(
                                  orderItemId: widget.orderid,
                                  returnQuantity: returnQuantity,
                                  returnReason: returnreason.text,
                                ));
                                Fluttertoast.showToast(
                                  msg: "${state.message}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }

                            }
                            //invoicedwnld: _launchURL,
                          ),
                        );
                      }),
                  // Container(
                  //   height: 400.h,
                  //   width: 400.w,
                  //   decoration: BoxDecoration(
                  //     color: Colors.black12,
                  //     image:DecorationImage(image: NetworkImage(widget.image??''),fit: BoxFit.cover),
                  //   ),
                  // ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(widget.title??"",style: CustomFont().subtitleText,),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Method of payment",style: CustomFont().subtitleText,),

                        SizedBox(height: 40.w,),
                        Text(widget.orders?.paymentMethod??"",style: CustomFont().bodyText,),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Status",style: CustomFont().subtitleText,),
                        Text(widget.orders?.paymentStatus??"",style: CustomFont().bodyText,),
                      ],
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Items",style: CustomFont().subtitleText,),
                        Text(widget.quatity.toString(),style: CustomFont().bodyText,),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: AdrressCustomField(
                      hinttext: 'Reason for return',
                      inputType: TextInputType.text,
                      controller: returnreason,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter reason for return';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: AdrressCustomField(
                      hinttext: 'return quantity',
                      inputType: TextInputType.number,
                      controller: quantity,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quantity';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 30.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.h),
                    child: InkWell(
                     onTap: (){

                       if (_formKey.currentState?.validate() ?? false){
                         final returnQuantity = int.tryParse(quantity.text);
                         context.read<CartBloc>().add(ReturnOrder(
                           orderItemId: widget.orderid,
                           returnQuantity: returnQuantity,
                           returnReason: returnreason.text,
                         ));
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

                      child: Container(
                        height: 50.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                          color: CustomColor.primaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(child: Text(returnStatus == 'NO_RETURN'
                            ? 'Return'
                            : returnStatus == 'PENDING'
                            ? 'Requested'
                            : 'Return',style: CustomFont().buttontext,)),
                      ),
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
}
