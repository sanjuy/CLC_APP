import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/profile/change_membership/membership_controller.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/user_detail.dart';
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
  TextEditingController nameController = TextEditingController();
  String typeStr = "";
  @override
  void initState() {
    super.initState();
    currentMembershipType();
  }

  currentMembershipType() async {
    nameController.text = await UserDetail.getMembershipType ?? "";
  }

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
                  lt: ["Free", "Paid"],
                  onSelected: (p0) {
                    typeStr = p0;
                  },
                ),
                SizedBox(height: 20),
                FullWidthAction(
                  title: "Change Membership Type",
                  onPressed: () {
                    MembershipController.changeMembershipType(
                        context: context, membershipType: typeStr);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
