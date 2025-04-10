import 'package:clc_app/authentication/forgot/forgot_password_screen.dart';
import 'package:clc_app/authentication/login/login_controller.dart';
import 'package:clc_app/authentication/registration/registration_screen.dart';
import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:clc_app/resources/validators.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> isObscure = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Login"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 18),
            child: Column(
              spacing: 8,
              children: [
                Image.asset("logo.png".directory(), scale: 4),
                SizedBox(height: 10),
                customText(
                  title: "WELCOME",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primeColor,
                ),
                customText(
                  title: "CHOW LUCK CLUB",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primeColor,
                ),
                SizedBox(height: 10),
                generalTextField(
                  icon: (Icons.email),
                  label: "Email Address",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigation.push(
                          context: context, moveTo: ForgotPasswordScreen());
                    },
                    child: customText(
                        title: "Forgot Password?", color: primeColor),
                  ),
                ),
                // SizedBox(height: 15),
                FullWidthAction(
                  title: "Login",
                  onPressed: () {
                    if (emailController.text == "") {
                      showInSnackBar(
                          context: context, message: "Enter Email Address");
                      return;
                    }
                    if (passwordController.text == "") {
                      showInSnackBar(
                          context: context, message: "Enter Password");
                      return;
                    }
                    if (!isValidateEmail(emailController.text)) {
                      showInSnackBar(
                          context: context, message: "Enter Valid Email-Id");
                      return;
                    }
                    LoginController.login(
                      context: context,
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                ),
                SizedBox(height: 10),
                FullWidthAction(
                  title: "Register",
                  onPressed: () {
                    Navigation.push(
                        context: context, moveTo: RegistrationScreen());
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
