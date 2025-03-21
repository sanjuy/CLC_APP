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
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      "$baseURLImg${reward.restaurantLogo.toString()}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  customText(
                      title: reward.restaurantName.toString(),
                      color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 175,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    maxLines: 2,
                    isSingleLine: true,
                    title: reward.title.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  customText(
                      title: reward.description.toString(),
                      fontSize: 14,
                      color: Colors.black54),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(3),
                    value: 0.0,
                    backgroundColor: reward.membershipType != "Free"
                        ? Colors.grey[300]
                        : primeColor,
                    minHeight: 6,
                  ),
                ],
              ),
            ),
            reward.membershipType != "Free"
                ? Image.asset("ribbon.png".directory(), scale: 20)
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
