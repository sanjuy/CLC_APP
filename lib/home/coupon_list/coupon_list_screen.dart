import 'package:clc_app/home/coupon_list/coupon_list_controller.dart';
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
  ValueNotifier<List<Reward>> rewards = ValueNotifier<List<Reward>>([]);

  @override
  void initState() {
    super.initState();
    getCoupon();
  }

  getCoupon() async {
    rewards.value = await CouponListController.couponsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          spacing: 5,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 3),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Image.asset("ads.png".directory(), fit: BoxFit.cover),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: rewards,
                  builder: (context, value, child) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              if (value[index].isPaid) {
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
                                        context: context,
                                        moveTo: CreditCardFormScreen());
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
                            child: RewardCard(reward: value[index]));
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
