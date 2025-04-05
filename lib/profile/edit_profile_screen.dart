import 'dart:io';

import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/custom_widget/custom_image_view.dart';
import 'package:clc_app/profile/profile_controller.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  final ValueNotifier<File?> _image = ValueNotifier<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    }
  }

  String profile = "";

  getUserInfo() async {
    nameController.text = await UserDetail.getUserName ?? "";
    mobileController.text = await UserDetail.getMobileNUmber ?? "";
    addressController.text = await UserDetail.getAddress ?? "";
    profile = await UserDetail.getProfilePicture ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

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
                InkWell(
                  onTap: () => showImagePickerDialog(context, (source) {
                    _pickImage(source);
                  }),
                  child: ValueListenableBuilder(
                    valueListenable: _image,
                    builder: (context, value, child) {
                      return _image.value != null
                          ? CustomImageView(
                              shap: BoxShape.circle,
                              imagePath: value,
                            )
                          : profile != ""
                              ? NetworkImageView(
                                  shap: BoxShape.circle,
                                  imagePath: profile,
                                )
                              : CustomImageView(shap: BoxShape.circle);
                    },
                  ),
                ),
                TextButton(
                  onPressed: () => showImagePickerDialog(context, (source) {
                    _pickImage(source);
                  }),
                  child: customText(
                    title: "Change Profile Image",
                    color: primeColor,
                  ),
                ),
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
                  onPressed: () {
                    ProfileController.editProfile(
                      context: context,
                      name: nameController.text,
                      mobile: mobileController.text,
                      address: addressController.text,
                      file: _image.value,
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
