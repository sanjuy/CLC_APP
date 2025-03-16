import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/authentication/login/login_model.dart';
import 'package:clc_app/home/dashboard_screen.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class LoginController {
  static login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email == "") {
      showInSnackBar(
          context: context, message: "Please Enter Correct Email-ID");
      return;
    }
    if (password == "") {
      showInSnackBar(context: context, message: "Please Enter Password");
      return;
    }
    Map<String, String> params = {};
    params["email"] = email;
    params["password"] = password;
    Map<String, String> queryParams = {"p": "userlogin"};
    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    if (!context.mounted) return;
    var dt = LoginModel.fromJson(responce);
    if (dt.data != null) {
      UserDetail.setUserLoggedIn = true;
      UserDetail.setUserId = dt.data?.userId ?? "";
      UserDetail.setUserEmail = dt.data?.email ?? "";
      UserDetail.setUserName = dt.data?.name ?? "";
      UserDetail.setMobileNUmber = dt.data?.contactNo ?? "";
      UserDetail.setGender = dt.data?.gender ?? "";
      UserDetail.setMembershipType = dt.data?.membershipType ?? "";
      UserDetail.setUserStatus = dt.data?.userStatus ?? "";
      UserDetail.setProfilePicture = dt.data?.profilePicture ?? "";
      UserDetail.setAddress = dt.data?.address ?? "";
      _moveTo(context);
    } else if (dt.meta != null) {
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
    } else {
      showInSnackBar(context: context, message: responce["message"].toString());
    }
  }

  static _moveTo(BuildContext context) {
    Navigation.pushAndRemoveUntil(context: context, moveTo: DashboardScreen());
  }
}
