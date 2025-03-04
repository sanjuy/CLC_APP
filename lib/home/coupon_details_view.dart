import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
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
              // Business Name & Location
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
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    customText(
                      title: "COUPON CODE",
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 5),
                    customText(
                      title: "CLC2638MKQ10",
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
              FullWidthAction(
                title: "REDEEM NOW",
                onPressed: () {},
              ),
              // const SizedBox(height: 10),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: DottedDivider(),
              // ),
              const SizedBox(height: 10),
              // QR Code Section
              const Text(
                "SCAN QR CODE",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: QrImageView(
                  data: "CLC2638MKQ10",
                  version: QrVersions.auto,
                  size: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
