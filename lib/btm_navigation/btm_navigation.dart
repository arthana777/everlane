import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Home/homescreen.dart';
import '../cartscreen/cartscreen.dart';
import '../profile/profile.dart';
import '../widgets/customcolor.dart';

class BtmNavigation extends StatefulWidget {
  const BtmNavigation({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<BtmNavigation> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    Profile(),
    CartScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          iconSize: 26.0.sp,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              backgroundColor: const Color(0xFFF7F7F7),
              icon: Icon(
                
                shadows: const [
                  Shadow(
                      blurRadius: 2,
                      color: Colors.grey,
                      offset: Offset(0.6, 0.5))
                ],
                _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                color: CustomColor.primaryColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                shadows: const [
                  Shadow(
                      blurRadius: 2,
                      color: Colors.grey,
                      offset: Offset(0.6, 0.8))
                ],
                _currentIndex == 1
                    ? Icons.person
                    : Icons.person_outline_outlined,
                color: CustomColor.primaryColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                shadows: const [
                  Shadow(
                      blurRadius: 2,
                      color: Colors.grey,
                      offset: Offset(0.6, 0.8))
                ],
                _currentIndex == 2
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                color: CustomColor.primaryColor,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
