import 'package:clc_app/home/coupon_list/coupon_list_controller.dart';
import 'package:clc_app/home/coupon_list/coupon_list_model.dart';
import 'package:clc_app/home/redeem/coupon_redeem_popup.dart';
import 'package:clc_app/home/redeem/web_view_screen.dart';
import 'package:clc_app/home/reward_card_view.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:clc_app/subscription_plans/subscription_plans_screen.dart';
import 'package:flutter/material.dart';

class Ads {
  String? image;
  String? url;
  Ads({this.image, this.url});
}

class CouponListScreen extends StatefulWidget {
  const CouponListScreen({super.key});

  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {
  ValueNotifier<List<AllCouponsList>> rewards =
      ValueNotifier<List<AllCouponsList>>([]);
  ValueNotifier<Ads> ads = ValueNotifier<Ads>(Ads());

  @override
  void initState() {
    super.initState();
    getCoupon();
  }

  getCoupon() async {
    rewards.value = await CouponListController.couponsList();
    ads.value.image = await UserDetail.getListAd ?? "";
    ads.value.url = await UserDetail.getListAdUrl ?? "";
    setState(() {});
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
              child: ValueListenableBuilder(
                valueListenable: ads,
                builder: (context, value, child) {
                  return value.image != null
                      ? InkWell(
                          child: Image.network(value.image ?? "",
                              fit: BoxFit.cover),
                          onTap: () {
                            Navigation.push(
                              context: context,
                              moveTo: WebViewScreen(
                                title: "Ad",
                                url: "https://${value.url}",
                              ),
                            );
                          },
                        )
                      : SizedBox();
                },
              ),
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
                              if (value[index].membershipType != "Free") {
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
                                        moveTo: SubscriptionPlansScreen());
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
                                    showBoardingPassDialog(
                                        context, value[index]);
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
