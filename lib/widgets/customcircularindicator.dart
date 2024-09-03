import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;
  final Color? backgroundColor;

  CustomCircularProgressIndicator({
    Key? key,
    this.size = 50.0,
    this.color = Colors.purple,
    this.strokeWidth = 4.0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomCircularProgressIndicator(
        size: 80.0,
        color: Colors.green,
        strokeWidth: 6.0,
        backgroundColor: Colors.white,
      ),
    ),
  ));
}
