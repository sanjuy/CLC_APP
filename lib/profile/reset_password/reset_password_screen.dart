import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/profile/reset_password/reset_pass_controllert.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ValueNotifier<bool> isObscure1 = ValueNotifier<bool>(true);
  ValueNotifier<bool> isObscure2 = ValueNotifier<bool>(true);
  ValueNotifier<bool> isObscure3 = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reset Password"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              spacing: 8,
              children: [
                ValueListenableBuilder(
                  valueListenable: isObscure1,
                  builder: (context, value, child) {
                    return passwordTextField(
                      icon: (Icons.password),
                      label: "Current Password",
                      isObscure: isObscure1.value,
                      controller: currentPasswordController,
                      onPressed: () => isObscure1.value = !isObscure1.value,
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: isObscure2,
                  builder: (context, value, child) {
                    return passwordTextField(
                      icon: (Icons.password),
                      label: "New Password",
                      isObscure: isObscure2.value,
                      controller: newPasswordController,
                      onPressed: () => isObscure2.value = !isObscure2.value,
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: isObscure3,
                  builder: (context, value, child) {
                    return passwordTextField(
                      icon: (Icons.password),
                      label: "Confirm Password",
                      isObscure: isObscure3.value,
                      controller: confirmPasswordController,
                      onPressed: () => isObscure3.value = !isObscure3.value,
                    );
                  },
                ),
                SizedBox(height: 20),
                FullWidthAction(
                  title: "Reset Password",
                  onPressed: () {
                    ResetPassControllert.resetPassword(
                      context: context,
                      currentPassword: currentPasswordController.text,
                      newPassword: newPasswordController.text,
                      confirmPassword: confirmPasswordController.text,
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
