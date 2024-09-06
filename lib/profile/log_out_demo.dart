//  AlertDialog(
//                         backgroundColor: Colors.white,
//                         title: Text(
//                           'Log Out',
//                           style: GoogleFonts.poppins(),
//                         ),
//                         content: Text(
//                           'If You Want To Log Out!!!',
//                           style: GoogleFonts.poppins(),
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Row(
//                               children: [
//                                 Container(
//                                   color: Colors.red,
//                                   padding: const EdgeInsets.all(14).w,
//                                   child: InkWell(
//                                     borderRadius: BorderRadius.circular(10).w,
//                                     child: Text(
//                                       'Yes!',
//                                       style: GoogleFonts.poppins(
//                                           color: Colors.red,
//                                           fontSize: 18.sp,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                     onTap: () {
//                                       Navigator.of(context)
//                                           .popUntil((route) => route.isFirst);
//                                       Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               FirstPage(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 Text("No")
//                               ],
//                             ),
//                           )
//                         ],
//                       ),



// // import 'package:flutter/material.dart';

// // class CustomAlertDialogExample extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Custom AlertDialog Example')),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () {
// //             showDialog(
// //               context: context,
// //               builder: (BuildContext context) {
// //                 return _buildCustomDialog(context);
// //               },
// //             );
// //           },
// //           child: Text('Show Dialog'),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildCustomDialog(BuildContext context) {
// //     return AlertDialog(
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(20), // Rounded corners
// //       ),
// //       contentPadding: EdgeInsets.zero, // Remove default padding
// //       content: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           // Icon at the top
// //           Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Icon(
// //               Icons.check_circle_outline,
// //               color: Colors.green,
// //               size: 60,
// //             ),
// //           ),
// //           // Title
// //           Text(
// //             "Are You Sure?",
// //             style: TextStyle(
// //               fontSize: 20,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           SizedBox(height: 10),
// //           // Content text
// //           Text(
// //             "Do you want to logout?",
// //             style: TextStyle(fontSize: 16, color: Colors.black54),
// //           ),
// //           SizedBox(height: 20),
// //           Divider(height: 1, color: Colors.grey),
// //           // Action buttons
// //           Row(
// //             children: [
// //               // No Button
// //               Expanded(
// //                 child: InkWell(
// //                   onTap: () {
// //                     Navigator.of(context).pop(); // Close dialog
// //                   },
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.only(
// //                         bottomLeft: Radius.circular(20),
// //                       ),
// //                       color: Colors.grey[200], // Background color
// //                     ),
// //                     padding: EdgeInsets.all(15),
// //                     alignment: Alignment.center,
// //                     child: Text(
// //                       "No",
// //                       style: TextStyle(fontSize: 18, color: Colors.black),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               // Yes Button
// //               Expanded(
// //                 child: InkWell(
// //                   onTap: () {
// //                     Navigator.of(context).pop(); // Confirm action and close dialog
// //                   },
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.only(
// //                         bottomRight: Radius.circular(20),
// //                       ),
// //                       color: Colors.green, // Background color
// //                     ),
// //                     padding: EdgeInsets.all(15),
// //                     alignment: Alignment.center,
// //                     child: Text(
// //                       "Yes",
// //                       style: TextStyle(fontSize: 18, color: Colors.white),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // void main() => runApp(MaterialApp(home: CustomAlertDialogExample()));
