import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/home/coupon_list_screen.dart';
import 'package:clc_app/home/coupon_redeem_history_screen.dart';
import 'package:clc_app/profile/profile_screen.dart';
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
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.local_offer),
            label: "Coupons",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}


/*
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Reward> rewards = [
    Reward(
      imageUrl: 'logo.png'.directory(),
      title: 'Get 100 points to get 10% off on your next meal',
      description: 'A maximum of 200 points can be redeemed at one time.',
      subtitle: 'Selera Delight',
      progress: 0.0,
      maxPoints: 100,
      currentPoints: 0,
      isFree: true,
    ),
    Reward(
      imageUrl: 'logo.png'.directory(),
      title: 'Free 4oz Creamy Ube Ice Cream or Classic Taho',
      description: 'For Every \$25 spent, free 4oz Creamy Ube Ice Cream',
      subtitle: 'Tinapay Atbp',
      progress: 0.0,
      maxPoints: 25,
      currentPoints: 0,
    ),
    Reward(
      imageUrl: 'logo.png'.directory(),
      title: '10% Discount',
      description: '10% Discount for every purchase of cheesecake worth \$50',
      subtitle: 'Cremefusion',
      progress: 0.0,
      maxPoints: 100,
      currentPoints: 10,
      isFree: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: CustomAppBar(title: "Dashboard", isShowProfile: true),
          body: TabBarView(
            children: [
              Center(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  itemCount: rewards.length,
                  itemBuilder: (context, index) {
                    return RewardCard(reward: rewards[index]);
                  },
                ),
              ),
              Center(child: CouponRedeemHistoryScreen()),
              Center(child: ProfileScreen()),
            ],
          ),
          bottomNavigationBar: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Coupon List"),
              Tab(icon: Icon(Icons.search), text: "History"),
              Tab(icon: Icon(Icons.person), text: "My Profile"),
            ],
          )),
    );
  }
}
*/