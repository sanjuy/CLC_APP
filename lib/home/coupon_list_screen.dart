import 'package:clc_app/home/coupon_redeem_popup.dart';
import 'package:clc_app/home/credit_card_screen.dart';
import 'package:clc_app/home/reward_card_view.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:flutter/material.dart';

class CouponListScreen extends StatefulWidget {
  const CouponListScreen({super.key});

  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {
  final List<Reward> rewards = [
    Reward(
      imageUrl: 'logo.png'.directory(),
      title: 'Get 100 points to get 10% off on your next meal',
      description: 'A maximum of 200 points can be redeemed at one time.',
      subtitle: 'Selera Delight',
      progress: 0.0,
      maxPoints: 100,
      currentPoints: 0,
      isPaid: true,
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
      isPaid: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 8, right: 8),
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  if (rewards[index].isPaid) {
                    showCustomDialog(
                      barrierDismissible: true,
                      context: context,
                      titleOK: "UPGRADE",
                      titleCancel: "Cancel",
                      msg:
                          "Upgrade Plan Inspirational designs,illustrations, and graphic elements from the world's best designers. Want more inspiration? msgBrowse our search results.",
                      title: "UPGRADE PLAN",
                      onAccepted: () {
                        Navigation.push(
                            context: context, moveTo: CreditCardFormScreen());
                      },
                    );
                  } else {
                    showCustomDialog(
                      barrierDismissible: true,
                      context: context,
                      titleOK: "Redeem Now",
                      titleCancel: "NO",
                      msg:
                          "To redeem this coupon, you must be inside the restaurant. The coupon will expire 10 minutes after you click Redeem Now.",
                      title: "INSTRUCTIONS",
                      onAccepted: () {
                        showBoardingPassDialog(context);
                      },
                    );
                  }
                },
                child: RewardCard(reward: rewards[index]));
          },
        ),
      ),
    );
  }
}
