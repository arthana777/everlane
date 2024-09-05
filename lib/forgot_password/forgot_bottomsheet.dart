// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../widgets/customcolor.dart';
// import 'forgot_pasword_screen.dart';

// class ForgotBottomsheet {
//   static void moreModalBottomSheet(context) {
//     showModalBottomSheet(
//         backgroundColor: Colors.red,
//         isScrollControlled: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(40.0).w,
//         ),
//         context: context,
//         builder: (BuildContext bc) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(
//               height: 300,
//               decoration: BoxDecoration(
//                 color: CustomColor.backgroundColor,
//                 borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(20.0),
//                   topLeft: Radius.circular(20.0),
//                 ).w,
//               ),
//               child: ListView(
//                 physics: const ClampingScrollPhysics(),
//                 children: const [ForgotPaswordScreen()],
//               ),
//             ),
//           );
//         });
//   }
// }
