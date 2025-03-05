import 'dart:async';

import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

void showBoardingPassDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        child: RewardsScreen(),
      );
    },
  );
}

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  Timer? _timer;
  final ValueNotifier<int> _remainingTime = ValueNotifier<int>(600);

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--;
      } else {
        timer.cancel();
        Navigation.pop(context: context);
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
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'logo.png'.directory(),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            customText(
              title: "Mang Joe's Chicken Inasal NZ",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            customText(
              title: "Auckland",
              fontSize: 14,
              color: Colors.grey,
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
                    title: "Discount",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 5),
                  customText(
                    title: "5%",
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
                title: "Description of the COUPON",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: customText(
                  title:
                      """This document outlines the business requirements for the development of a mobile
      application.and non-functional requirements necessary.""",
                  color: Colors.grey),
            ),
            const SizedBox(height: 10),
            // Instructions Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Instructions:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            customText(
              title: "1. Offer only valid on Zomato vouchers\n"
                  "2. This code can be used twice per day\n"
                  "3. This offer cannot be clubbed with any other offer\n",
              color: Colors.grey,
            ),
            // const SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: _remainingTime,
                builder: (context, value, child) {
                  return FullWidthAction(
                    title: "Time Remaining: ${formatTime(value)}",
                    onPressed: () {},
                  );
                }),
          ],
        ),
      ),
    );
  }
}
