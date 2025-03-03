import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/custom_widget/custom_image_view.dart';
import 'package:clc_app/profile/change_membership_type_screen.dart';
import 'package:clc_app/profile/coupon_redeem_history_screen.dart';
import 'package:clc_app/profile/reset_password_screen.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile", isEditProfile: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              CustomImageView(
                shap: BoxShape.circle,
              ),
              TextButton(
                onPressed: () {},
                child: customText(
                    title: "Change Profile Image", color: Colors.blue),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRowView(label: "Name", value: "John Jack"),
                        CustomRowView(
                            label: "Phone number", value: "8130686230"),
                        CustomRowView(
                            label: "Email-Id", value: "john.jack@gmail.com"),
                        CustomRowView(label: "Gender", value: "Male"),
                        CustomRowView(label: "Membership Type", value: "Free"),
                        CustomRowView(label: "Address", value: "Noida UP"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        arrowButton(
                          title: "Coupon Redeem History",
                          onPressed: () {
                            Navigation.push(
                              context: context,
                              moveTo: CouponRedeemHistoryScreen(),
                            );
                          },
                        ),
                        arrowButton(
                          title: "Change Membership Type",
                          onPressed: () {
                            Navigation.push(
                              context: context,
                              moveTo: ChangeMembershipTypeScreen(),
                            );
                          },
                        ),
                        arrowButton(
                          title: "Reset Password",
                          onPressed: () {
                            Navigation.push(
                              context: context,
                              moveTo: ResetPasswordScreen(),
                            );
                          },
                        ),
                        arrowButton(
                          title: "Delete Account",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
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
