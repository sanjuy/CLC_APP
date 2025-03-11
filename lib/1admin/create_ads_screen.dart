import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/custom_widget/custom_image_view.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class CreateAdsScreen extends StatefulWidget {
  const CreateAdsScreen({super.key});

  @override
  State<CreateAdsScreen> createState() => _CreateAdsScreenState();
}

class _CreateAdsScreenState extends State<CreateAdsScreen> {
  TextEditingController businessNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Ads Creatives"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              generalTextField(
                label: "Name of Business",
                controller: businessNameController,
              ),
              SizedBox(height: 8),
              dropDownTextField(
                title: "Ad type",
                lt: ["Fixed", "Circulations / Dynamic Display"],
                onSelected: (p0) {},
              ),
              SizedBox(height: 8),
              dropDownTextField(
                title: "Ad Placements",
                lt: [
                  "Full Screen",
                  "Popups",
                  "Banners",
                ],
                onSelected: (p0) {},
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  spacing: 5,
                  children: [
                    customText(
                        title: "Ads Creatives Image",
                        fontWeight: FontWeight.bold),
                    CustomImageView(
                      // imagePath: "ads.png",
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              FullWidthAction(
                title: "Create Coupon",
                onPressed: () {
                  // Navigation.push(
                  //     context: context,
                  //     moveTo: RegistrationScreen(emailId: widget.emailId));
                },
              ),
              Spacer(),
              Image.asset("clc.png".directory(), scale: 10),
            ],
          ),
        ),
      ),
    );
  }
}
