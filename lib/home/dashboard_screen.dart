import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/home/coupon_list_screen.dart';
import 'package:clc_app/home/coupon_redeem_history_screen.dart';
import 'package:clc_app/profile/profile_screen.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String screenTitle = "Coupons List";

  final List<Widget> _screens = [
    CouponListScreen(),
    CouponRedeemHistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        screenTitle = "Coupons List";
      }
      if (index == 1) {
        screenTitle = "Redeemed Coupons List";
      }
      if (index == 2) {
        screenTitle = "My Profile";
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: screenTitle),
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              color: _selectedIndex != 0 ? Colors.white : primeColor,
              width: MediaQuery.of(context).size.width / 3,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2,
                children: [
                  Icon(Icons.local_offer),
                  customText(
                    title: "Coupon",
                    color: _selectedIndex != 0 ? Colors.grey : Colors.white,
                  )
                ],
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              color: _selectedIndex != 1 ? Colors.white : primeColor,
              width: MediaQuery.of(context).size.width / 3,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2,
                children: [
                  Icon(Icons.history),
                  customText(
                    title: "History",
                    color: _selectedIndex != 1 ? Colors.grey : Colors.white,
                  ),
                ],
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              color: _selectedIndex != 2 ? Colors.white : primeColor,
              width: MediaQuery.of(context).size.width / 3,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2,
                children: [
                  Icon(Icons.person),
                  customText(
                    title: "Profile",
                    color: _selectedIndex != 2 ? Colors.grey : Colors.white,
                  ),
                ],
              ),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
