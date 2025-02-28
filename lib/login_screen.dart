import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            spacing: 8,
            children: [
              Image.asset(
                "clc.png".directory(),
                width: 300,
                height: 80,
              ),
              customtext(
                title: "Login",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              // generalTextField(
              //   label: "Mobile Number",
              //   controller: emailController,
              //   keyboardType: TextInputType.emailAddress,
              // ),
              generalTextField(
                label: "Email Id",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15),
              FullWidthAction(
                title: "Login",
                onPressed: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customtext(title: "New User Registration"),
                  TextButton(
                    onPressed: () {},
                    child: customtext(title: "Click Here?",color: Colors.blue),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
