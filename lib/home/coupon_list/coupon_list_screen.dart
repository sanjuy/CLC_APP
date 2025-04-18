import 'package:clc_app/apis_services/apis_endpoints.dart';
import 'package:clc_app/authentication/login/login_screen.dart';
import 'package:clc_app/home/coupon_list/coupon_list_controller.dart';
import 'package:clc_app/home/coupon_list/coupon_list_model.dart';
import 'package:clc_app/home/redeem/coupon_redeem_popup.dart';
import 'package:clc_app/home/reward_card_view.dart';
import 'package:clc_app/profile/change_membership/membership_controller.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/url_launcher.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:clc_app/subscription_plans/subscription_controller.dart';
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

class _CouponListScreenState extends State<CouponListScreen>
    with WidgetsBindingObserver {
  ValueNotifier<List<AllCouponsList>> rewards =
      ValueNotifier<List<AllCouponsList>>([]);
  ValueNotifier<Ads> ads = ValueNotifier<Ads>(Ads());
  String membershipType = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getCoupon();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkForActivePlan();
    }
  }

  getCoupon() async {
    if (await UserDetail.getUserLoggedIn ?? false) {
      rewards.value = await CouponListController.couponsList();
    } else {
      rewards.value = await CouponListController.couponsListWithoutLogin();
    }
    ads.value.image = await UserDetail.getListAd ?? "";
    ads.value.url = await UserDetail.getListAdUrl ?? "";
    membershipType = await UserDetail.getMembershipType ?? "";
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
                  return value.image != null && value.image != ""
                      ? InkWell(
                          child: Image.network(
                            value.image ?? "",
                            fit: BoxFit.fitWidth,
                          ),
                          onTap: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              launchURL("${value.url}");
                            });
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
                            onTap: () async {
                              if (await UserDetail.getUserLoggedIn ?? false) {
                                if (value[index].membershipType != chowLucky &&
                                    membershipType != chowLuckyPlus) {
                                  upgradeAlert();
                                } else {
                                  redeemAlert(value[index]);
                                }
                              } else {
                                loginAlert();
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

  upgradeAlert() {
    showCustomDialog(
      barrierDismissible: true,
      context: context,
      titleOK: "Right Now",
      titleCancel: "Not Now",
      msg:
          "Unlock more with Chow Luck Card! Upgrade to a ChowLucky Plus membership and enjoy exclusive perks.",
      title: "UPGRADE PLAN",
      onAccepted: () {
        Navigation.push(
          context: context,
          moveTo: SubscriptionPlansScreen(
            onSuccess: () {
              MembershipController.changeMembershipType(
                context: context,
                membershipType: chowLuckyPlus,
                onCompletion: () {
                  getCoupon();
                },
              );
            },
          ),
        );
      },
    );
  }

  checkForActivePlan() async {
    if (await UserDetail.getUserLoggedIn ?? false) {
      bool isActive =
          await SubscriptionController.instance.checkSubscriptionStatus();
      if (isActive == false && mounted) {
        MembershipController.changeMembershipType(
          context: context,
          isShowLoader: false,
          membershipType: chowLucky,
          onCompletion: () {},
        );
      }
    }
  }

  redeemAlert(AllCouponsList obj) {
    showCustomDialog(
      barrierDismissible: true,
      context: context,
      titleOK: "Redeem Now",
      titleCancel: "Not Now",
      msg:
          "To redeem this coupon, show this to the wait staff. This coupon will expire in 10 minutes after you click Redeem Now.",
      title: "INSTRUCTIONS",
      onAccepted: () {
        showBoardingPassDialog(context, obj, () => getCoupon());
      },
    );
  }

  loginAlert() {
    showCustomDialog(
      barrierDismissible: true,
      context: context,
      titleOK: "Login",
      titleCancel: "Cancel",
      msg:
          "To proceed with coupon redemption, \nplease log in to your account.",
      title: "Login",
      onAccepted: () {
        Navigation.push(context: context, moveTo: const LoginScreen());
      },
    );
  }
}
