// import 'package:everlane/bloc/cart/cart_bloc.dart';
// import 'package:everlane/checkout/orderdetails.dart';
// import 'package:everlane/data/models/ordermodel.dart';
// import 'package:everlane/data/navigation_provider/navigation_provider.dart';
// import 'package:everlane/profile/profile.dart';
// import 'package:everlane/widgets/customappbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'myorderitem.dart';

// class MyOrders extends StatefulWidget {
//   const MyOrders({super.key});

//   @override
//   State<MyOrders> createState() => _MyOrdersState();
// }

// class _MyOrdersState extends State<MyOrders> {
//   final String invoiceUrl =
//       "http://18.143.206.136/media/invoices/invoice_D83A32A692.pdf";

//   Future<void> _launchURL() async {
//     final Uri url = Uri.parse(invoiceUrl);
//     if (!await launchUrl(url)) {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<CartBloc>(context).add(fetchOrders());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFEFEF),
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(80.h),
//         child: CustomAppBar(
//           text: 'My Orders',
//           leading: InkWell(
//             onTap: () {
//               final navigationProvider =
//                   Provider.of<NavigationProvider>(context, listen: false);
//               navigationProvider.updateScreenIndex(0);
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Profile()),
//                 (Route<dynamic> route) => false,
//               );
//             },
//             child: const Icon(Icons.arrow_back),
//           ),
//         ),
//       ),
//       body: BlocBuilder<CartBloc, CartState>(
//         builder: (context, state) {
//           if (state is OrderLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is OrderLoaded) {
//             final orders = state.orders;

//             return ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 final order = orders[index];

//                 if (order.items.isNotEmpty) {
//                   return Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: InkWell(
//                       onTap: () {},
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Myorderitem(
//                             title: order.items[0].productName,
//                             image: order.items[0].productImage,
//                             type: order.paymentMethod,
//                             invoicedwnld: _launchURL,
//                             quatity: order.items[0].quantity,
//                             returnstatus: order.items[0].returnStatus,
//                             ordercode: order.orderCode,
//                             viewmore: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => OrderDetails(
//                                     image: order.items[0].productImage,
//                                     orders: order,
//                                     title: order.items[0].productName,
//                                     quatity: order.items[0].quantity,
//                                     orderid: order.items[0].id,
//                                     retunstatus: order.items[0].returnStatus,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           if (order.items.length > 1)
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => OrderDetails(
//                                       image: order.items[0].productImage,
//                                       orders: order,
//                                       title: order.items[0].productName,
//                                       quatity: order.items[0].quantity,
//                                       orderid: order.items[0].id,
//                                       retunstatus: order.items[0].returnStatus,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                   "View more items (${order.items.length - 1} more)"),
//                             ),
//                           const SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ListTile(
//                       title: const Text("No items available for this order"),
//                       subtitle: Text("Order Status: ${order.orderStatus}"),
//                     ),
//                   );
//                 }
//               },
//             );
//           } else {
//             return const Center(child: Text('Failed to load orders.'));
//           }
//         },
//       ),
//     );
//   }
// }
