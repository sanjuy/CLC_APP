import 'dart:async';

import 'package:clc_app/authentication/otp/otp_controller.dart';
import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/home/dashboard_screen.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String? emailId;
  final String? verificationType;
  const OtpScreen({super.key, this.emailId, this.verificationType});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int otpViewSize = 6;
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = [];

  final ValueNotifier<int> _secondsRemaining = ValueNotifier<int>(0);
  final ValueNotifier<bool> _canResend = ValueNotifier<bool>(false);
  Timer? _timer;

  @override
  void initState() {
    sendOTP();
    _controllers =
        List.generate(otpViewSize, (index) => TextEditingController());
    _focusNodes = List.generate(otpViewSize, (index) => FocusNode());
    super.initState();
    _startTimer();
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
    _timer?.cancel();
    _secondsRemaining.dispose();
    _canResend.dispose();
  }

  void _startTimer() {
    _secondsRemaining.value = 60;
    _canResend.value = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value--;
      } else {
        _canResend.value = true;
        _timer?.cancel();
      }
    });
  }

  void _resendOtp() async {
    sendOTP();
    _startTimer();
  }

  sendOTP() async {
    await OtpController.resendOTP(
        context: context, email: widget.emailId ?? "");
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < otpViewSize - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void _verifyOtp() {
    String otp = _controllers.map((e) => e.text).join();
    if (otp.length == otpViewSize) {
      OtpController.verifyOTP(
          context: context,
          otp: otp,
          onVerified: (verified) {
            if (verified) {
              if (widget.verificationType != null) {
              } else {
                UserDetail.setUserLoggedIn = true;
                Navigation.pushAndRemoveUntil(
                    context: context, moveTo: const DashboardScreen());
              }
            }
          });
    } else {
      showInSnackBar(context: context, message: "Please Enter 6 digit OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Verify OTP"),
      body: SingleChildScrollView(
        child: Padding(
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
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      cursorHeight: 20,
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) => _onOtpChanged(value, index),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              FullWidthAction(
                title: "Verify OTP",
                onPressed: () {
                  _verifyOtp();
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: _secondsRemaining,
                builder: (context, value, child) {
                  return customText(
                      title: "Resend OTP in $value seconds",
                      fontSize: 16,
                      color: primeColor);
                },
              ),
              // Resend Button
              ValueListenableBuilder<bool>(
                valueListenable: _canResend,
                builder: (context, canResend, child) {
                  return ElevatedButton(
                    onPressed: canResend ? _resendOtp : null,
                    child: customText(title: "Resend OTP", color: primeColor),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
