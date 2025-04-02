import 'package:clc_app/apis_services/apis_endpoints.dart';
import 'package:clc_app/home/coupon_list/coupon_list_model.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class RewardCard extends StatelessWidget {
  final AllCouponsList reward;

  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 4,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: reward.restaurantLogo != null
                            ? Image.network(
                                reward.restaurantLogo.toString(),
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
                      reward.restaurantName != null
                          ? customText(
                              title: reward.restaurantName.toString(),
                              alignment: TextAlign.center,
                              color: Colors.grey)
                          : SizedBox()
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 175,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        maxLines: 10,
                        isSingleLine: true,
                        title: reward.title.toString(),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                          ),
                          customText(
                            maxLines: 10,
                            isSingleLine: true,
                            title: reward.location.toString(),
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(3),
                        value: 0.0,
                        backgroundColor: reward.usageStatus == "Unused"
                            ? Colors.grey[300]
                            : primeColor,
                        minHeight: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        reward.membershipType == chowLuckyPlus
            ? Positioned(
                right: 0,
                child: Image.asset(
                  "ribbon.png".directory(),
                  scale: 40,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
