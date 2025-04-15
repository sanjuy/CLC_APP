import 'dart:io';

import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/authentication/login/login_model.dart';
import 'package:clc_app/authentication/login/login_screen.dart';
import 'package:clc_app/home/dashboard_screen.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 4), () {
      if (Platform.isIOS) {
        moveToDashboard();
      } else {
        navigationTo();
      }
    });
  }

  navigationTo() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    if (await UserDetail.getUserLoggedIn ?? false) {
      if (!mounted) return;
      userProfile((p0, p1) {
        if (p0) {
          Navigation.pushReplacement(
              context: context, moveTo: const DashboardScreen());
        } else {
          showInSnackBar(context: context, message: p1);
          Navigation.pushReplacement(
              context: context, moveTo: const LoginScreen());
        }
      });
    } else {
      if (!mounted) return;
      Navigation.pushReplacement(context: context, moveTo: const LoginScreen());
    }
  }

  /// app flow change after app rejected from apple
  moveToDashboard() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    userProfile((p0, p1) {
      if (p0) {
        UserDetail.setUserLoggedIn = true;
      } else {
        UserDetail.setUserLoggedIn = false;
      }
      Navigation.pushReplacement(
          context: context, moveTo: const DashboardScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primeColor,
        child: Center(child: Image.asset("C2.gif".directory(), scale: 1)),
      ),
    );
  }

  userProfile(Function(bool, String) onCompletion) async {
    Map<String, String> queryParams = {"p": "user_profile"};
    Map<String, String> params = {};
    params["user_id"] = await UserDetail.getUserId ?? "";

    var responce = await ApiService.postRequest(
        params: params, queryParams: queryParams, isShowLoader: false);
    if (!context.mounted) return;
    var dt = LoginModel.fromJson(responce);
    if (dt.meta?.statusCode == 200) {
      if (dt.data != null) {
        UserDetail.setUserId = dt.data?.userId ?? "";
        UserDetail.setUserEmail = dt.data?.email ?? "";
        UserDetail.setUserName = dt.data?.name ?? "";
        UserDetail.setMobileNUmber = dt.data?.contactNo ?? "";
        UserDetail.setGender = dt.data?.gender ?? "";
        UserDetail.setMembershipType = dt.data?.membershipType ?? "";
        UserDetail.setUserStatus = dt.data?.userStatus ?? "";
        UserDetail.setProfilePicture = dt.data?.profilePicture ?? "";
        UserDetail.setAddress = dt.data?.address ?? "";
      }
      onCompletion(true, "");
    } else {
      onCompletion(false, dt.meta?.message ?? "");
    }
  }
}
