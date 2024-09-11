import 'package:everlane/checkout/myorderitem.dart';
import 'package:everlane/checkout/myorders.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../bloc/cart/cart_bloc.dart';
import '../data/models/ordermodel.dart';
import '../data/navigation_provider/navigation_provider.dart';
import '../widgets/cutsofield_address.dart';
import '../widgets/orderdetailitem.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails(
      {super.key,
      this.title,
      this.status,
      this.paymentmethod,
      this.orders,
      this.image,
      this.quatity,
      this.orderid,
      this.retunstatus});
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
  void _showModalSheet(BuildContext context) async {
    // List<UserAddress>useradress=[];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        widget.title ?? "",
                        style: CustomFont().subtitleText,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Method of payment",
                            style: CustomFont().subtitleText,
                          ),
                          SizedBox(
                            height: 40.w,
                          ),
                          Text(
                            widget.orders?.paymentMethod ?? "",
                            style: CustomFont().bodyText,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Status",
                            style: CustomFont().subtitleText,
                          ),
                          Text(
                            widget.orders?.orderStatus ?? "",
                            style: CustomFont().bodyText,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Items",
                            style: CustomFont().subtitleText,
                          ),
                          Text(
                            widget.quatity.toString(),
                            style: CustomFont().bodyText,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final returnQuantity = int.tryParse(quantity.text);
                            context.read<CartBloc>().add(ReturnOrder(
                                  orderItemId: widget.orderid,
                                  returnQuantity: returnQuantity,
                                  returnReason: returnreason.text,
                                ));
                          } else {
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
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: CustomColor.primaryColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                              child: Text(
                            returnStatus == 'NO_RETURN'
                                ? 'Return'
                                : returnStatus == 'PENDING'
                                    ? 'Requested'
                                    : 'Return',
                            style: CustomFont().buttontext,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ).whenComplete(
      () {
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    returnStatus = widget.retunstatus ?? "NO_RETURN";
    items = widget.orders!.items;
    print(widget.orders!.items);
    //BlocProvider.of<CartBloc>(context).add(ReturnOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: CustomAppBar(
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
              } else if (state is ReturnError) {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Already Requested')),
                );
              } else if (state is CancelorderLoaded) {
                setState(() {
                  items.removeWhere((item) => item.id == state.orderid);
                });
              }
            },
          ),
        ],
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10 .w,
          ),
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
                      itemBuilder: (context, index) {
                        final item = widget.orders?.items[index];
                        print("orderstatus ${item?.orderitemstatus}");
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OrderDetailitem(
                            title: item?.productName ?? '',
                            orderstatus: widget.orders?.orderStatus,
                            image: item?.productImage,
                            type: widget.orders?.paymentMethod,
                            quatity: item?.quantity,
                            returnstatus: item?.orderitemstatus,

                            // Determine button text based on item order status
                            text: () {
                              switch (item?.orderitemstatus) {
                                case "Pending":
                                case "Processing":
                                  return "Cancel"; // Both Pending and Processing should show "Cancel"
                                case "Completed":
                                  return "Return"; // Completed should show "Return"
                                case "Requested":
                                  return "Requested for Return"; // Show "Requested for Return" for Requested status
                                case "Cancelled":
                                  return "Cancelled"; // Cancelled should show "Cancelled"
                                default:
                                  return "Cancelled"; // Default to an empty string if no other status matches
                              }
                            }(),

                            ontapremove: () {
                              switch (item?.orderitemstatus) {
                                case "Pending":
                                case "Processing":
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Icon(
                                              Icons.logout_rounded,
                                              color: CustomColor.primaryColor,
                                              size: 60,
                                            ),
                                          ),
                                          Text(
                                            "Are You Sure?",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Do you want to cancel this item?",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                          SizedBox(height: 20),
                                          Divider(
                                              height: 1, color: Colors.grey),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    padding: EdgeInsets.all(15),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<CartBloc>(
                                                            context)
                                                        .add(
                                                      CancelOrderevent(
                                                          item?.id ?? 0),
                                                    );
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog after the event
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      color: CustomColor
                                                          .primaryColor,
                                                    ),
                                                    padding: EdgeInsets.all(15),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  break;

                                case "Completed":
                                  // For Completed status, trigger return process
                                  _showModalSheet(context);
                                  print("shgasdjh");
                                  break;

                                case "Requested":
                                  // No action needed, return already requested
                                  break;

                                default:
                                  // Default or no action
                                  break;
                              }
                            },
                          ),

                          // child: OrderDetailitem(
                          //   title: item?.productName??'',
                          //   orderstatus: widget.orders?.orderStatus,
                          //   image: item?.productImage,
                          //   type: widget.orders?.paymentMethod,
                          //   quatity: item?.quantity,
                          //   returnstatus: item?.orderitemstatus,
                          //   text: item?.orderitemstatus == "Pending"
                          //       ? "Cancel"
                          //       : item?.orderitemstatus == "Completed"
                          //       ? "Return"
                          //       : item?.orderitemstatus == "Pending" || item?.orderitemstatus == "Processing"
                          //       ? "Cancel"
                          //       : item?.orderitemstatus == "Requested"
                          //       ? "Requested for Return"
                          //       : ""
                          //     ,
                          //   // text: item?.orderitemstatus == "Canceled"
                          //   //     ?"Canceled":"Cancel",
                          //
                          //       // : item?.orderitemstatus == "Completed"
                          //       // ? " Return"
                          //       // : "Return Requested",
                          //
                          //
                          //   ontapremove: item?.orderitemstatus == "Pending" || item?.orderitemstatus == "Processing"
                          //       ? ()
                          //   {
                          //     _showModalSheet(context);
                          //     // final returnQuantity = int.tryParse(quantity.text);
                          //     //     context.read<CartBloc>().add(ReturnOrder(
                          //     //       orderItemId: widget.orderid,
                          //     //       returnQuantity: returnQuantity,
                          //     //       returnReason: returnreason.text,
                          //     //     ));
                          //   }
                          //       : item?.orderitemstatus == "Completed"
                          //       ? ()
                          //   {
                          //    // _showModalSheet(context);
                          //   }
                          //       : item?.orderitemstatus == "Completed"
                          //       ? ()
                          //   {
                          //     showDialog(
                          //       context: context,
                          //       builder: (context) => AlertDialog(
                          //         backgroundColor: Colors.white,
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10).w,
                          //         ),
                          //         contentPadding: EdgeInsets.zero,
                          //         content: Column(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(16.0).w,
                          //               child: Icon(
                          //                 Icons.logout_rounded,
                          //                 color: CustomColor.primaryColor,
                          //                 size: 60.sp,
                          //               ),
                          //             ),
                          //             // Title
                          //             Text(
                          //               "Are You Sure?",
                          //               style: TextStyle(
                          //                 fontSize: 20.sp,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             ),
                          //             SizedBox(height: 10.h),
                          //             // Content text
                          //             Text(
                          //               "Do you want to logout?",
                          //               style: TextStyle(
                          //                   fontSize: 16.sp, color: Colors.black54),
                          //             ),
                          //             SizedBox(height: 20.h),
                          //             Divider(height: 1, color: Colors.grey),
                          //             // Action buttons
                          //             Row(
                          //               children: [
                          //                 // No Button
                          //                 Expanded(
                          //                   child: InkWell(
                          //                     onTap: () {
                          //                       Navigator.of(context)
                          //                           .pop(); // Close dialog
                          //                     },
                          //                     child: Container(
                          //                       decoration: BoxDecoration(
                          //                           borderRadius: BorderRadius.only(
                          //                             bottomLeft: Radius.circular(20),
                          //                           ),
                          //                           color: Colors.white),
                          //                       padding: EdgeInsets.all(15),
                          //                       alignment: Alignment.center,
                          //                       child: Text(
                          //                         "No",
                          //                         style: TextStyle(
                          //                             fontSize: 18, color: Colors.black),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 // Yes Button
                          //                 Expanded(
                          //                   child: InkWell(
                          //                     onTap: () {
                          //                       BlocProvider.of<CartBloc>(context).add(CancelOrderevent(items[index].id),);
                          //
                          //                     },
                          //                     child: Container(
                          //                       decoration: BoxDecoration(
                          //                         borderRadius: BorderRadius.only(
                          //                           bottomRight: Radius.circular(10),
                          //                         ),
                          //                         color: CustomColor.primaryColor,
                          //                       ),
                          //                       padding: EdgeInsets.all(15),
                          //                       alignment: Alignment.center,
                          //                       child: Text(
                          //                         "Yes",
                          //                         style: TextStyle(
                          //                             fontSize: 18, color: Colors.white),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //   }
                          //       : item?.orderitemstatus == "Requested"
                          //       ? ()
                          //   {
                          //
                          //   }
                          //       : ()
                          //   {
                          //
                          //   },
                          //
                          //   //   ontapremove:  (){
                          //   //   if( item?.orderitemstatus == "Canceled"){
                          //   //     BlocProvider.of<CartBloc>(context).add(CancelOrderevent(items[index].id),);
                          //   //   }
                          //   //   else if(item?.orderitemstatus == "Pending" || item?.orderitemstatus == "Processing"){
                          //   //
                          //   //     final returnQuantity = int.tryParse(quantity.text);
                          //   //     context.read<CartBloc>().add(ReturnOrder(
                          //   //       orderItemId: widget.orderid,
                          //   //       returnQuantity: returnQuantity,
                          //   //       returnReason: returnreason.text,
                          //   //     ));
                          //   //     // Fluttertoast.showToast(
                          //   //     //   msg: "${state.message}",
                          //   //     //   toastLength: Toast.LENGTH_SHORT,
                          //   //     //   gravity: ToastGravity.BOTTOM,
                          //   //     //   backgroundColor: Colors.green,
                          //   //     //   textColor: Colors.white,
                          //   //     //   fontSize: 16.0,
                          //   //     // );
                          //   //   }
                          //   //
                          //   // }
                          //   //invoicedwnld: _launchURL,
                          // ),
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

                  // SizedBox(height: 10.h,),
                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: Text(widget.title??"",style: CustomFont().subtitleText,),
                  // ),
                  // SizedBox(height: 10.h,),
                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text("Method of payment",style: CustomFont().subtitleText,),
                  //
                  //       SizedBox(height: 40.w,),
                  //       Text(widget.orders?.paymentMethod??"",style: CustomFont().bodyText,),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text("Order Status",style: CustomFont().subtitleText,),
                  //       Text(widget.orders?.paymentStatus??"",style: CustomFont().bodyText,),
                  //     ],
                  //   ),
                  // ),
                  //
                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text("Items",style: CustomFont().subtitleText,),
                  //       Text(widget.quatity.toString(),style: CustomFont().bodyText,),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 20.h,),
                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: AdrressCustomField(
                  //     hinttext: 'Reason for return',
                  //     inputType: TextInputType.text,
                  //     controller: returnreason,
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Please enter reason for return';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  // SizedBox(height: 20.h,),
                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: AdrressCustomField(
                  //     hinttext: 'return quantity',
                  //     inputType: TextInputType.number,
                  //     controller: quantity,
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Please enter quantity';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 30.h,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 30.h),
                  //   child: InkWell(
                  //    onTap: (){
                  //
                  //      if (_formKey.currentState?.validate() ?? false){
                  //        final returnQuantity = int.tryParse(quantity.text);
                  //        context.read<CartBloc>().add(ReturnOrder(
                  //          orderItemId: widget.orderid,
                  //          returnQuantity: returnQuantity,
                  //          returnReason: returnreason.text,
                  //        ));
                  //      }
                  //      else {
                  //        // Show toast if form is not valid
                  //        Fluttertoast.showToast(
                  //          msg: "Please fill out all fields.",
                  //          toastLength: Toast.LENGTH_SHORT,
                  //          gravity: ToastGravity.BOTTOM,
                  //          backgroundColor: Colors.white,
                  //          textColor: Colors.black,
                  //          fontSize: 16.0,
                  //        );
                  //      }
                  //    },
                  //
                  //     child: Container(
                  //       height: 50.h,
                  //       width: 200.w,
                  //       decoration: BoxDecoration(
                  //         color: CustomColor.primaryColor,
                  //         borderRadius: BorderRadius.circular(5.r),
                  //       ),
                  //       child: Center(
                  //           child: Text(
                  //         returnStatus == 'NO_RETURN'
                  //             ? 'Return'
                  //             : returnStatus == 'PENDING'
                  //                 ? 'Requested'
                  //                 : 'Return',
                  //         style: CustomFont().buttontext,
                  //       )),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
