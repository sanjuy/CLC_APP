import 'dart:async';

import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/home/coupon_list/coupon_list_screen.dart';
import 'package:clc_app/home/coupon_redeem_history_screen.dart';
import 'package:clc_app/profile/profile_screen.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ValueNotifier<int> _secondsRemaining = ValueNotifier<int>(0);
  final ValueNotifier<bool> isShowAd = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isHideAd = ValueNotifier<bool>(false);
  Timer? _timer;

  int _selectedIndex = 0;
  String screenTitle = "Coupons List";

  final List<Widget> _screens = [
    CouponListScreen(),
    CouponRedeemHistoryScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _secondsRemaining.dispose();
    isHideAd.dispose();
    isShowAd.dispose();
  }

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

  void _startTimer() {
    _secondsRemaining.value = 10;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value--;
      } else {
        isShowAd.value = false;
        _timer?.cancel();
      }
    });
  }

  // bool isShowAd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: screenTitle),
      body: SafeArea(
        child: Stack(
          children: [
            _screens[_selectedIndex],
            ValueListenableBuilder(
              valueListenable: isHideAd,
              builder: (context, value, child) {
                return value
                    ? SizedBox()
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 5),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              "ads.png".directory(),
                              fit: BoxFit.cover,
                            ),
                            ValueListenableBuilder<int>(
                              valueListenable: _secondsRemaining,
                              builder: (context, value, child) {
                                return customText(
                                    title: "Skip Ad in $value seconds",
                                    fontSize: 16,
                                    color: Colors.black);
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: ValueListenableBuilder(
                                valueListenable: isShowAd,
                                builder: (context, v, child) {
                                  return !v
                                      ? IconButton(
                                          onPressed: () =>
                                              isHideAd.value = true,
                                          icon: Icon(Icons.cancel))
                                      : SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
              },
            )
          ],
        ),
      ),
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
