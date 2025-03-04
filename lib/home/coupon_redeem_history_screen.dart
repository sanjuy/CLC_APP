import 'package:clc_app/home/reward_card_view.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:flutter/material.dart';

class CouponRedeemHistoryScreen extends StatefulWidget {
  const CouponRedeemHistoryScreen({super.key});

  @override
  State<CouponRedeemHistoryScreen> createState() =>
      _CouponRedeemHistoryScreenState();
}

class _CouponRedeemHistoryScreenState extends State<CouponRedeemHistoryScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 8, right: 8),
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            return RewardCard(reward: rewards[index]);
          },
        ),
      ),
    );
  }
}
