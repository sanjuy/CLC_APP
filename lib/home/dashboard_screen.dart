import 'dart:async';

import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/home/ads/ads_controller.dart';
import 'package:clc_app/home/coupon_list/coupon_list_screen.dart';
import 'package:clc_app/home/history/coupon_redeem_history_screen.dart';
import 'package:clc_app/home/redeem/web_view_screen.dart';
import 'package:clc_app/profile/enquiry_screen.dart';
import 'package:clc_app/profile/profile_screen.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
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
  final ValueNotifier<bool> isHideAd = ValueNotifier<bool>(true);
  final ValueNotifier<Ads> ads = ValueNotifier<Ads>(Ads());
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
    Future.delayed(Duration(seconds: 5), () {
      getAds();
    });
  }

  getAds() {
    AdsController.getAds(() async {
      isHideAd.value = false;
      ads.value.image = await UserDetail.getFullAd ?? "";
      ads.value.url = await UserDetail.getFullAdUrl ?? "";
      _startTimer();
    });
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
        screenTitle = "Coupon List";
      }
      if (index == 1) {
        screenTitle = "Redeemed Coupon List";
      }
      if (index == 2) {
        screenTitle = "My Profile";
      }
      _selectedIndex = index;
    });
  }

  void _startTimer() {
    _secondsRemaining.value = 3;

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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              // decoration: BoxDecoration(color: Colors.blue),
              child: Image.asset("logo.png".directory()),
            ),
            buildListTile(Icons.help_outline, 'Restaurant Enquiry', '', () {
              Navigator.pop(context);
              Navigation.push(
                context: context,
                moveTo: EnquiryScreen(),
              );
            }),
            const SizedBox(height: 4),
            buildListTile(Icons.privacy_tip, 'Privacy Policy', '', () {
              Navigator.pop(context);
              Navigation.push(
                context: context,
                moveTo: WebViewScreen(
                  url:
                      'https://drive.google.com/file/d/1ZABD_MptkFiZrJd3UJJkVrlBsA3WD6w9/view',
                  title: 'Privacy Policy',
                ),
              );
            }),
          ],
        ),
      ),
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
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ValueListenableBuilder(
                              valueListenable: ads,
                              builder: (context, value, child) {
                                return value.image != null
                                    ? Center(
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  100,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  400,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigation.push(
                                                    context: context,
                                                    moveTo: WebViewScreen(
                                                      title: "Ad",
                                                      url: "${value.url}",
                                                    ),
                                                  );
                                                },
                                                child: Image.network(
                                                  value.image.toString(),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: ValueListenableBuilder(
                                                valueListenable: isShowAd,
                                                builder: (context, v, child) {
                                                  return !v
                                                      ? IconButton(
                                                          onPressed: () =>
                                                              isHideAd.value =
                                                                  true,
                                                          icon: Icon(
                                                            Icons.cancel,
                                                            color: Colors.black,
                                                          ))
                                                      : SizedBox();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox();
                              },
                            ),
                            // /*
                            // Positioned(
                            //   top: 0,
                            //   left: 0,
                            //   child: ValueListenableBuilder<int>(
                            //     valueListenable: _secondsRemaining,
                            //     builder: (context, value, child) {
                            //       return customText(
                            //           title: "Skip Ad in $value seconds",
                            //           fontSize: 16,
                            //           color: Colors.white);
                            //     },
                            //   ),
                            // ),
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
              height: 51,
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
              height: 51,
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
              height: 51,
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
