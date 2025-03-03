import 'package:clc_app/1admin/create_ads_screen.dart';
import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class CreateCouponsScreen extends StatefulWidget {
  const CreateCouponsScreen({super.key});

  @override
  State<CreateCouponsScreen> createState() => _CreateCouponsScreenState();
}

class _CreateCouponsScreenState extends State<CreateCouponsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController restaurantController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create Coupons"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              generalTextField(
                label: "Title",
                controller: titleController,
              ),
              generalTextField(
                label: "Restaurant Name (foreign Key)",
                controller: restaurantController,
              ),
              multiLineTextField(
                label: "Description",
                controller: descriptionController,
              ),
              SizedBox(height: 8),
              dropDownTextField(
                title: "Coupon Type",
                lt: ["One time use", "Recurring use"],
                onSelected: (p0) {},
              ),
              SizedBox(height: 8),
              dropDownTextField(
                title: "Membership Type",
                lt: [
                  "ChowLucky - (Free)",
                  "ChowLucky Plus (Paid) - BitePass, Foodie Plus,",
                  "Both",
                ],
                onSelected: (p0) {},
              ),
              SizedBox(height: 8),
              dropDownTextField(
                title: "Discount Type",
                lt: ["%", "Fixed", "Free Item"],
                onSelected: (p0) {},
              ),
              generalTextField(
                label: "Discount Value",
                controller: discountValueController,
              ),
              SizedBox(height: 8),
              dropDownTextField(
                title: "Coupon Status",
                lt: ["Activate", "Inactivate"],
                onSelected: (p0) {},
              ),
              SizedBox(height: 30),
              FullWidthAction(
                title: "Create Coupon",
                onPressed: () {
                  Navigation.push(context: context, moveTo: CreateAdsScreen());
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
