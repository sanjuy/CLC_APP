import 'package:clc_app/home/coupon_list/coupon_list_model.dart';
import 'package:clc_app/home/history/history_controller.dart';
import 'package:clc_app/home/reward_card_view.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class CouponRedeemHistoryScreen extends StatefulWidget {
  const CouponRedeemHistoryScreen({super.key});

  @override
  State<CouponRedeemHistoryScreen> createState() =>
      _CouponRedeemHistoryScreenState();
}

class _CouponRedeemHistoryScreenState extends State<CouponRedeemHistoryScreen> {
  ValueNotifier<List<AllCouponsList>> rewards =
      ValueNotifier<List<AllCouponsList>>([]);

  @override
  void initState() {
    super.initState();
    getCouponHistory();
  }

  getCouponHistory() async {
    rewards.value = await HistoryController.redeemedCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: rewards,
          builder: (context, value, child) {
            return value.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return RewardCard(reward: value[index]);
                    },
                  )
                : Center(
                    child: customText(
                        title: "No History Data Found",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  );
          },
        ),
      ),
    );
  }
}
