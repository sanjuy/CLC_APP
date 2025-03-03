import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class CouponRedeemHistoryScreen extends StatefulWidget {
  const CouponRedeemHistoryScreen({super.key});

  @override
  State<CouponRedeemHistoryScreen> createState() =>
      _CouponRedeemHistoryScreenState();
}

class _CouponRedeemHistoryScreenState extends State<CouponRedeemHistoryScreen> {
  final List<Map<String, dynamic>> offers = [
    {
      "logo": "logo.png".directory(),
      "title": "EXTRA 5% OFF",
      "subtitle": "on Zomato",
      "status": "Claimed",
      "statusColor": Colors.grey[200],
    },
    {
      "logo": "logo.png".directory(),
      "title": "EXTRA 4% OFF",
      "subtitle": "on Swiggy",
      "status": "Claimed",
      "statusColor": Colors.grey[200],
    },
    {
      "logo": "logo.png".directory(),
      "title": "EXTRA 5% OFF",
      "subtitle": "on Nykaa",
      "status": "Claimed",
      "statusColor": Colors.grey[200],
    },
    {
      "logo": "logo.png".directory(),
      "title": "6% OFF",
      "subtitle": "on Myntra",
      "status": "Claimed",
      "statusColor": Colors.grey[200],
    },
    {
      "logo": "logo.png".directory(),
      "title": "EXTRA 1.5% OFF",
      "subtitle": "on Flipkart",
      "status": "Claimed",
      "statusColor": Colors.grey[200],
    },
    {
      "logo": "logo.png".directory(),
      "title": "Get ₹280 Off",
      "subtitle": "On Park+ Micro Fibre Cloth",
      "status": "Claimed",
      "statusColor": Colors.grey[200],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Coupon Redeem History"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            spacing: 8,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: customText(
                  title: "List of Redeemed Coupons",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1, // Aspect ratio of grid items
                  ),
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    final offer = offers[index];
                    return InkWell(
                      onTap: () {
                        // showCouponDetailsDialog(context: context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(offer["logo"]),
                              radius: 30,
                            ),
                            customText(
                              title: offer["title"],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customText(
                                  title: offer["subtitle"],
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                const Icon(Icons.arrow_forward, size: 16),
                              ],
                            ),
                            Spacer(),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: offer["statusColor"],
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(8),
                                ),
                              ),
                              child: customText(
                                title: offer["status"],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
