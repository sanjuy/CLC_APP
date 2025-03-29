import 'dart:async';

import 'package:clc_app/home/coupon_list/coupon_list_model.dart';
import 'package:clc_app/home/coupon_list/coupon_list_screen.dart';
import 'package:clc_app/home/redeem/redeem_controller.dart';
import 'package:clc_app/home/redeem/web_view_screen.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

void showBoardingPassDialog(
  BuildContext context,
  AllCouponsList obj,
  Function() onRedeemed,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        child: RewardsScreen(
          obj: obj,
          onRedeemed: () => onRedeemed(),
        ),
      );
    },
  );
}

// ignore: must_be_immutable
class RewardsScreen extends StatefulWidget {
  AllCouponsList? obj;
  Function() onRedeemed;
  RewardsScreen({super.key, this.obj, required this.onRedeemed});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  Timer? _timer;
  final ValueNotifier<int> _remainingTime = ValueNotifier<int>(600);
  ValueNotifier<Ads> ads = ValueNotifier<Ads>(Ads());

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--;
      } else {
        redeem();
        timer.cancel();
        // Navigation.pop(context: context);
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int sec = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    startTimer();
    super.initState();
    getAds();
  }

  getAds() async {
    ads.value.image = await UserDetail.getPopupAd ?? "";
    ads.value.url = await UserDetail.getPopupAdUrl ?? "";
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.cancel, color: Colors.black),
            onPressed: () {
              showCustomDialog(
                barrierDismissible: false,
                context: context,
                titleOK: "OK",
                titleCancel: "NO",
                msg:
                    "Do you want to cancel this coupon ?. \n If you cancel this coupon, you will not get the benefit of this and coupon will expire",
                title: "Alert",
                onAccepted: () {
                  redeem();
                },
              );
              // Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: widget.obj?.restaurantLogo != null
                        ? Image.network(
                            "${widget.obj?.restaurantLogo.toString()}",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "logo.png".directory(),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(height: 10),
                  customText(
                    title: widget.obj?.restaurantName ?? "",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigation.push(
                        context: context,
                        moveTo: WebViewScreen(
                          title: widget.obj?.restaurantName ?? "",
                          url: "${widget.obj?.url}",
                        ),
                      );
                    },
                    child: customText(
                      title: "Read More",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Points Balance Section
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        customText(
                          title: "Specials",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 5),
                        customText(
                          title: "${widget.obj?.discountValue}%",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Rewards Information
                  Align(
                    alignment: Alignment.centerLeft,
                    child: customText(
                      title: "Description of the coupon",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: customText(
                        title: widget.obj?.description ?? "",
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  // Instructions Section
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Instructions:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customText(
                      title: "1. ${widget.obj?.ins1}\n"
                          "2. ${widget.obj?.ins2}\n"
                          "3. ${widget.obj?.ins3}\n",
                      color: Colors.grey,
                    ),
                  ),
                  // const SizedBox(height: 10),
                  ValueListenableBuilder(
                    valueListenable: _remainingTime,
                    builder: (context, value, child) {
                      return FullWidthAction(
                        title: "Time Remaining: ${formatTime(value)}",
                        onPressed: () {},
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
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
                            child: Image.network(value.image.toString(),
                                fit: BoxFit.cover),
                            onTap: () {
                              Navigation.push(
                                context: context,
                                moveTo: WebViewScreen(
                                  title: "Ad",
                                  url: "${value.url}",
                                ),
                              );
                            },
                          )
                        : SizedBox();
                  }),
            )
          ],
        ),
      ),
    );
  }

  redeem() {
    RedeemController.redeemNow(
      context: context,
      couponID: widget.obj?.couponId ?? "",
      onRedeem: () => widget.onRedeemed(),
    );
  }
}
