import 'package:clc_app/1admin/create_coupons_screen.dart';
import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/custom_widget/custom_image_view.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class CreateRestaurantsScreen extends StatefulWidget {
  const CreateRestaurantsScreen({super.key});

  @override
  State<CreateRestaurantsScreen> createState() =>
      _CreateRestaurantsScreenState();
}

class _CreateRestaurantsScreenState extends State<CreateRestaurantsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create Restaurants"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              generalTextField(
                label: "Name",
                controller: nameController,
              ),
              generalTextField(
                label: "Mobile Number",
                controller: mobileController,
              ),
              generalTextField(
                label: "Email",
                controller: emailController,
              ),
              generalTextField(
                label: "Address",
                controller: addressController,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  spacing: 5,
                  children: [
                    customText(
                        title: "Restaurant Logo", fontWeight: FontWeight.bold),
                    CustomImageView(),
                  ],
                ),
              ),
              SizedBox(height: 30),
              FullWidthAction(
                title: "Create Restaurant",
                onPressed: () {
                  Navigation.push(
                      context: context, moveTo: CreateCouponsScreen());
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
