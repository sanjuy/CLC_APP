import 'package:clc_app/authentication/forgot/forgot_controller.dart';
import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool verified;
  const ForgotPasswordScreen({super.key, this.verified = false});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> isObscure = ValueNotifier<bool>(true);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Forgot Password"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                !widget.verified
                    ? generalTextField(
                        icon: Icons.email,
                        label: "Email Address",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      )
                    : ValueListenableBuilder(
                        valueListenable: isObscure,
                        builder: (context, value, child) {
                          return passwordTextField(
                            icon: (Icons.password),
                            label: "New Password",
                            isObscure: isObscure.value,
                            controller: passwordController,
                            onPressed: () => isObscure.value = !isObscure.value,
                          );
                        },
                      ),
                SizedBox(height: 20),
                FullWidthAction(
                  title: widget.verified ? "Create Password" : "Get OTP",
                  onPressed: () {
                    if (!widget.verified) {
                      if (emailController.text == "") {
                        showInSnackBar(
                            context: context,
                            message: "Please Enter Registered Email-ID");
                        return;
                      }
                      ForgotController.sendOTO(
                          context: context, email: emailController.text);
                    } else {
                      if (passwordController.text == "") {
                        showInSnackBar(
                            context: context,
                            message: "Please Enter New Password");
                        return;
                      }
                      ForgotController.createNewPassword(
                          context: context, password: passwordController.text);
                    }
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
