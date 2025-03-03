import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showCouponDetailsDialog({
  required BuildContext context,
  Function()? onRedeemClicked,
}) async {
  showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Offer Header
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("logo.png".directory()),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "EXTRA 5% OFF",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "on Zomato",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: customText(
                      title: "Description",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  customText(
                    title:
                        """This document outlines the business requirements for the development of a mobile
application. The purpose of this document is to gather and define the functional and
non-functional requirements necessary for the successful execution of the project.""",
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: customText(
                      title: "Instructions",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  customText(
                    title: "1. Offer only valid on Zomato vouchers\n"
                        "2. This code can be used twice per day\n"
                        "3. This offer cannot be clubbed with any other offer\n"
                        "4. Park+ reserves the right to alter any terms and conditions of the offer without prior notice",
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                            title: "ZOMATO6",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                const ClipboardData(text: "ZOMATO6"));
                            showInSnackBar(
                                context: context,
                                message: "Coupon Code Copied!");
                          },
                          child: const Icon(Icons.copy, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Redeem Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF5A2DB3), // Purple Button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => onRedeemClicked!(),
                      child: customText(
                        title: "Redeem now",
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

/*
class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Semi-transparent Background
          Container(
            color: Colors.black.withOpacity(0.5), // Adjust opacity here
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () => Navigation.pop(context: context),
              ),
            ),
          ),
          // Offer Card UI
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, // Offer card should be solid
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Offer Header
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              const AssetImage("assets/zomato.png"),
                          radius: 20,
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EXTRA 5% OFF",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "on Zomato",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Terms & Conditions
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Terms and conditions:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "1. Offer only valid on Zomato vouchers\n"
                      "2. This code can be used twice per day\n"
                      "3. This offer cannot be clubbed with any other offer\n"
                      "4. Park+ reserves the right to alter any terms and conditions of the offer without prior notice",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 15),

                    // Coupon Code Box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ZOMATO6",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  const ClipboardData(text: "ZOMATO6"));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Coupon Code Copied!")),
                              );
                            },
                            child: const Icon(Icons.copy, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Expiry Date
                    const Text(
                      "Valid till Mar 31, 2025 9:00 AM",
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    const SizedBox(height: 15),

                    // Redeem Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF5A2DB3), // Purple Button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Redeem now",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
/*
class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Purple background
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () => Navigation.pop(context: context),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Offer Header
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              const AssetImage("assets/zomato.png"),
                          radius: 20,
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EXTRA 5% OFF",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "on Zomato",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Terms & Conditions
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Terms and conditions:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "1. Offer only valid on Zomato vouchers\n"
                      "2. This code can be used twice per day\n"
                      "3. This offer cannot be clubbed with any other offer\n"
                      "4. Park+ reserves the right to alter any terms and conditions of the offer without prior notice",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 15),

                    // Coupon Code Box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ZOMATO6",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  const ClipboardData(text: "ZOMATO6"));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Coupon Code Copied!")),
                              );
                            },
                            child: const Icon(Icons.copy, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Expiry Date
                    const Text(
                      "Valid till Mar 31, 2025 9:00 AM",
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    const SizedBox(height: 15),

                    // Redeem Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF5A2DB3), // Purple Button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Redeem now",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
