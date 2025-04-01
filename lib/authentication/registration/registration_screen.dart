import 'dart:io';

import 'package:clc_app/apis_services/apis_endpoints.dart';
import 'package:clc_app/authentication/registration/registration_controller.dart';
import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/custom_widget/custom_image_view.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:clc_app/subscription_plans/subscription_plans_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  ValueNotifier<bool> isObscure = ValueNotifier<bool>(true);

  String gender = "";
  String membershipType = "";

  final ValueNotifier<File?> _image = ValueNotifier<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _mobileFocus.dispose();
    _passwordFocus.dispose();
    _addressFocus.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
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
                InkWell(
                  onTap: () => showImagePickerDialog(context, (source) {
                    _pickImage(source);
                  }),
                  child: ValueListenableBuilder(
                      valueListenable: _image,
                      builder: (context, value, child) {
                        return CustomImageView(
                          shap: BoxShape.circle,
                          imagePath: value,
                        );
                      }),
                ),
                SizedBox(height: 8),
                generalTextField(
                  icon: (Icons.account_circle),
                  label: "Name",
                  controller: _nameController,
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () =>
                      FocusScope.of(context).requestFocus(_emailFocus),
                ),
                generalTextField(
                  icon: (Icons.email),
                  label: "Email Address",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () =>
                      FocusScope.of(context).requestFocus(_mobileFocus),
                ),
                generalTextField(
                  icon: (Icons.contact_phone),
                  label: "Contact No.",
                  controller: _mobileController,
                  focusNode: _mobileFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () =>
                      FocusScope.of(context).requestFocus(_passwordFocus),
                ),
                ValueListenableBuilder(
                  valueListenable: isObscure,
                  builder: (context, value, child) {
                    return passwordTextField(
                      icon: (Icons.password),
                      label: "Password",
                      isObscure: isObscure.value,
                      controller: _passwordController,
                      onPressed: () => isObscure.value = !isObscure.value,
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.next,
                      onSubmitted: () =>
                          FocusScope.of(context).requestFocus(_addressFocus),
                    );
                  },
                ),
                generalTextField(
                  icon: (Icons.location_city),
                  label: "Address",
                  controller: _addressController,
                  focusNode: _addressFocus,
                  textInputAction: TextInputAction.done,
                  onSubmitted: () => _addressFocus.unfocus(),
                ),
                // SizedBox(height: 8),
                dropDownTextField(
                  icon: (Icons.wc),
                  title: "Gender",
                  lt: ["Male", "Female", "Others"],
                  onSelected: (p0) {
                    gender = p0;
                  },
                ),
                // SizedBox(height: 8),
                dropDownTextField(
                  icon: (Icons.card_membership),
                  title: "Membership Type",
                  lt: [chowLucky, chowLuckyPlus],
                  onSelected: (p0) {
                    membershipType = p0;
                  },
                ),
                SizedBox(height: 20),
                FullWidthAction(
                  title: "Registration",
                  onPressed: () {
                    if (_nameController.text == "") {
                      showInSnackBar(
                          context: context, message: "Please Enter Full Name");
                      return;
                    }
                    if (_emailController.text == "") {
                      showInSnackBar(
                          context: context,
                          message: "Please Enter Correct Email Address");
                      return;
                    }
                    if (_mobileController.text == "") {
                      showInSnackBar(
                          context: context,
                          message: "Please Enter Contact No.");
                      return;
                    }
                    if (_passwordController.text == "") {
                      showInSnackBar(
                          context: context, message: "Please Enter Password");
                      return;
                    }
                    // if (_addressController.text == "") {
                    //   showInSnackBar(
                    //       context: context, message: "Please Enter Address");
                    //   return;
                    // }
                    if (gender == "") {
                      showInSnackBar(
                          context: context, message: "Please Select Gender");
                      return;
                    }
                    if (membershipType == "") {
                      showInSnackBar(
                          context: context,
                          message: "Please Select Membership TYpe");
                      return;
                    }
                    showCustomDialog(
                      context: context,
                      msg:
                          "This app is provided as is with no warranties. Use at your own risk; we are not liable for any losses. Accuracy and features may change without notice.",
                      title: "Disclaimer",
                      isShowCheckBox: true,
                      onAccepted: () {
                        if (membershipType == chowLuckyPlus) {
                          Navigation.push(
                              context: context,
                              moveTo: SubscriptionPlansScreen(
                                  onSuccess: () => register()));
                        } else {
                          register();
                        }
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

  register() {
    RegistrationController.register(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      mobile: _mobileController.text,
      password: _passwordController.text,
      address: _addressController.text,
      gender: gender,
      membershipType: membershipType,
      file: _image.value ?? File(""),
    );
  }
}
