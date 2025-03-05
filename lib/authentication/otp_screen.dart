import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/home/dashboard_screen.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String? emailId;
  const OtpScreen({super.key, this.emailId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int otpViewSize = 4;
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    _controllers =
        List.generate(otpViewSize, (index) => TextEditingController());
    _focusNodes = List.generate(otpViewSize, (index) => FocusNode());
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < otpViewSize - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _verifyOtp() {
    String otp = _controllers.map((e) => e.text).join();
    if (otp.length == otpViewSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Entered OTP: $otp")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Verify OTP"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          children: [
            Image.asset("logo.png".directory(), scale: 5),
            SizedBox(height: 20),
            customText(
                title: "Enter $otpViewSize-digit OTP SENT TO",
                fontSize: 18,
                fontWeight: FontWeight.bold),
            customText(
                title: widget.emailId.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w600),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(otpViewSize, (index) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => _onOtpChanged(value, index),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 30),
            FullWidthAction(
              title: "Verify OTP",
              onPressed: () {
                _verifyOtp(); //DashboardScreen
                Navigation.pushAndRemoveUntil(
                    context: context, moveTo: const DashboardScreen());
              },
            ),
            Spacer(),
            Image.asset("clc.png".directory(), scale: 10),
          ],
        ),
      ),
    );
  }
}
