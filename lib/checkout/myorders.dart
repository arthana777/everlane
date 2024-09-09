import 'package:everlane/bloc/cart/cart_bloc.dart';
import 'package:everlane/checkout/orderdetails.dart';
import 'package:everlane/data/models/ordermodel.dart';
import 'package:everlane/data/navigation_provider/navigation_provider.dart';
import 'package:everlane/profile/profile.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'myorderitem.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<Order> orders = [];

  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(fetchOrders());
    super.initState();
  }

  final String invoiceUrl =
      "http://18.143.206.136/media/invoices/invoice_D83A32A692.pdf";
  Future<void> _launchURL() async {
    final Uri url = Uri.parse(
        "http://18.143.206.136/media/invoices/invoice_D83A32A692.pdf");
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomAppBar(
          text: 'My Orders',
          leading: InkWell(
            onTap: () {
              final navigationProvider =
                  Provider.of<NavigationProvider>(context, listen: false);
              navigationProvider.updateScreenIndex(0);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
                (Route<dynamic> route) => false,
              );
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is OrderLoading) {

          } else if (state is OrderLoaded) {

            setState(() {
              orders = state.orders;
            });
          }
        },
        child: orders.isEmpty
            ? Center(child: Text("No orders found"))
        //     : ListView.builder(
        //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        //   itemCount: orders.length,
        //   itemBuilder: (context, index) {
        //     final order = orders[index];
        //
        //     // Check if the order has at least one item
        //     if (order.items.isNotEmpty) {
        //       final item = order.items[0];
        //
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: InkWell(
        //           onTap: (){
        //             Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails(image: item.productImage,
        //               orders: order,title: item.productName,quatity:item.quantity,orderid:item.id,retunstatus: item.returnStatus,)));
        //           },
        //           child: Myorderitem(
        //             title: item.productName,
        //             orderstatus: order.orderStatus,
        //             image: item.productImage,
        //             type: order.paymentMethod,
        //             invoicedwnld:  _launchURL,
        //             quatity: item.quantity,
        //             returnstatus: item.returnStatus,
        //           ),
        //         ),
        //       );
        //     } else {
        //       // Handle the case where there are no items in the order
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: ListTile(
        //           title: Text("No items available for this order"),
        //           subtitle: Text("Order Status: ${order.orderStatus}"),
        //         ),
        //       );
        //     }
        //   },
        // ),
        :ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];

            // Check if the order has items
            if (order.items.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (order.items.isNotEmpty) // Check if the order has at least one item
                        Myorderitem(
                          title: order.items[0].productName, // Show only the first product
                          orderstatus: order.orderStatus,
                          image: order.items[0].productImage,
                          type: order.paymentMethod,
                          invoicedwnld: _launchURL,
                          quatity: order.items[0].quantity,
                          returnstatus: order.items[0].returnStatus,
                          ordercode: order.orderCode,
                          viewmore: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetails(
                                  image: order.items[0].productImage,
                                  orders: order,
                                  title: order.items[0].productName,
                                  quatity: order.items[0].quantity,
                                  orderid: order.items[0].id,
                                  retunstatus: order.items[0].returnStatus,
                                ),
                              ),
                            );
                          },
                        ),
                      // Add a "View More" button or indicator if the order has more than one item
                      if (order.items.length > 1)
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetails(
                                  image: order.items[0].productImage,
                                  orders: order,
                                  title: order.items[0].productName,
                                  quatity: order.items[0].quantity,
                                  orderid: order.items[0].id,
                                  retunstatus: order.items[0].returnStatus,
                                ),
                              ),
                            );
                          },
                          child: Text("View more items (${order.items.length - 1} more)"),
                        ),
                      SizedBox(height: 10), // Add spacing between orders
                    ],
                  ),

                ),
              );
            } else {
              // Handle case where there are no items in the order
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text("No items available for this order"),
                  subtitle: Text("Order Status: ${order.orderStatus}"),
                ),
              );
            }
          },
        ),

      ),
    );
  }
}
