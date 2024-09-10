import 'package:everlane/checkout/myorders.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../bloc/cart/cart_bloc.dart';
import '../btm_navigation/btm_navigation.dart';
import '../data/navigation_provider/navigation_provider.dart';

class SuccessScreen extends StatefulWidget {
  final String paymentId;
  final String payerId;
  final String token;


  const SuccessScreen({super.key, required this.paymentId, required this.payerId, required this.token, });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the payment execution when the screen loads
    BlocProvider.of<CartBloc>(context).add(
      ExecutePayment(widget.paymentId, widget.payerId, widget.token),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: CustomAppBar(
            leading: InkWell(
              onTap: () {
                final navigationProvider =
                Provider.of<NavigationProvider>(context, listen: false);
                navigationProvider.updateScreenIndex(0);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BtmNavigation()),
                      (Route<dynamic> route) => false,
                );
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is ExecutionLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ExecutionLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100.sp,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Payment Successful!',
                      style: GoogleFonts.questrial(
                        color: Colors.green,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Order ID: ${state.paymentResponse.data.orderCode}',
                      style: GoogleFonts.questrial(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders()));
                        // Navigate to another screen or perform another action
                      },
                      child: Text('Go to Orders'),
                    ),
                  ],
                ),
              );
            } else if (state is ExecutionError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 100.sp,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Payment Failed!',
                      style: GoogleFonts.questrial(
                        color: Colors.red,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      state.message,
                      style: GoogleFonts.questrial(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Unexpected State!',
                  style: GoogleFonts.questrial(
                    color: Colors.black,
                    fontSize: 18.sp,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
