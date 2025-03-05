import 'package:clc_app/authentication/otp_screen.dart';
import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/custom_widget/custom_image_view.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ValueNotifier<bool> isObscure = ValueNotifier<bool>(true);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Registration"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 18),
            child: Column(
              spacing: 8,
              children: [
                CustomImageView(shap: BoxShape.circle),
                SizedBox(height: 8),
                generalTextField(
                  icon: (Icons.account_circle),
                  label: "Name",
                  controller: nameController,
                ),
                generalTextField(
                  icon: (Icons.email),
                  label: "Email Address",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                generalTextField(
                  icon: (Icons.contact_phone),
                  label: "Contact No.",
                  controller: mobileController,
                ),
                ValueListenableBuilder(
                  valueListenable: isObscure,
                  builder: (context, value, child) {
                    return passwordTextField(
                      icon: (Icons.password),
                      label: "Password",
                      isObscure: isObscure.value,
                      controller: passwordController,
                      onPressed: () => isObscure.value = !isObscure.value,
                    );
                  },
                ),
                // SizedBox(height: 8),
                dropDownTextField(
                  icon: (Icons.wc),
                  title: "Gender",
                  lt: [
                    "Male",
                    "Female",
                    "Others",
                  ],
                  onSelected: (p0) {},
                ),
                // SizedBox(height: 8),
                dropDownTextField(
                  icon: (Icons.card_membership),
                  title: "Membership Type",
                  lt: [
                    "ChowLucky - Free",
                    "ChowLucky Plus",
                  ],
                  onSelected: (p0) {},
                ),
                generalTextField(
                  icon: (Icons.location_city),
                  label: "Address",
                  controller: addressController,
                ),
                SizedBox(height: 20),
                FullWidthAction(
                  title: "Registration",
                  onPressed: () {
                    showCustomDialog(
                      context: context,
                      msg:
                          "When customers register, they will get a disclaimer popup and they accept it before proceeding to the app.",
                      title: "Disclaimer",
                      onAccepted: () {
                        Navigation.pop(context: context);
                        Navigation.push(
                            context: context,
                            moveTo: OtpScreen(emailId: emailController.text));
                      },
                    );
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
