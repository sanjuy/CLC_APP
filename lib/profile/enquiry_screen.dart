import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({super.key});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Restaurants Enquiry"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              spacing: 8,
              children: [
                generalTextField(
                  icon: (Icons.account_circle),
                  label: "Restaurant Name",
                  controller: nameController,
                ),
                generalTextField(
                  icon: (Icons.email),
                  label: "Email-ID.",
                  controller: emailController,
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
                generalTextField(
                  icon: (Icons.comment),
                  label: "Comments",
                  controller: commentsController,
                ),
                SizedBox(height: 20),
                FullWidthAction(
                  title: "Send",
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
