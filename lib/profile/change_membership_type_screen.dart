import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class ChangeMembershipTypeScreen extends StatefulWidget {
  const ChangeMembershipTypeScreen({super.key});

  @override
  State<ChangeMembershipTypeScreen> createState() =>
      _ChangeMembershipTypeScreenState();
}

class _ChangeMembershipTypeScreenState
    extends State<ChangeMembershipTypeScreen> {
  TextEditingController nameController = TextEditingController(text: "Free");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change Membership Type"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              spacing: 8,
              children: [
                generalTextField(
                  icon: (Icons.card_membership),
                  label: "Current Membership Type",
                  readOnly: true,
                  controller: nameController,
                ),
                dropDownTextField(
                  icon: (Icons.card_membership),
                  title: "Membership Type",
                  lt: [
                    "ChowLucky - Free",
                    "ChowLucky Plus",
                  ],
                  onSelected: (p0) {},
                ),
                SizedBox(height: 20),
                FullWidthAction(
                  title: "Change Membership Type",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
