import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              spacing: 8,
              children: [
                generalTextField(
                  icon: (Icons.account_circle),
                  label: "Name",
                  controller: nameController,
                ),
                generalTextField(
                  icon: (Icons.contact_phone),
                  label: "Contact No.",
                  controller: mobileController,
                ),
                generalTextField(
                  icon: (Icons.location_city),
                  label: "Address",
                  controller: addressController,
                ),
                SizedBox(height: 20),
                FullWidthAction(
                  title: "UPDATE",
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
