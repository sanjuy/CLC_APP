import 'dart:io';

import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/authentication/otp/otp_screen.dart';
import 'package:clc_app/authentication/registration/register_model.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class RegistrationController {
  static register({
    required BuildContext context,
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String address,
    required String gender,
    required String membershipType,
    required File file,
  }) async {
    Map<String, String> queryParams = {"p": "addUser"};
    Map<String, String> params = {};
    params["name"] = name;
    params["email"] = email;
    params["contact_no"] = mobile;
    params["password"] = password;
    params["address"] = address;
    params["gender"] = gender;
    params["membership_type"] = membershipType;
    params["user_status"] = "Active";
    print(file.path);
    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
      filePath: file.path != "" ? file : null,
    );
    if (!context.mounted) return;
    var dt = RegisterModel.fromJson(responce);
    if (dt.data != null) {
      UserDetail.setUserId = dt.data?.id ?? "";
      UserDetail.setUserEmail = dt.data?.email ?? "";
      UserDetail.setUserName = dt.data?.name ?? "";
      UserDetail.setMobileNUmber = dt.data?.contactNo ?? "";
      UserDetail.setGender = dt.data?.gender ?? "";
      UserDetail.setMembershipType = dt.data?.membershipType ?? "";
      UserDetail.setUserStatus = dt.data?.userStatus ?? "";
      UserDetail.setProfilePicture = dt.data?.profilePicture ?? "";
      UserDetail.setAddress = dt.data?.address ?? "";
      _moveTo(context, email);
    } else if (dt.meta != null) {
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
    } else {
      showInSnackBar(context: context, message: responce["message"].toString());
    }
  }

  static _moveTo(BuildContext context, String email) {
    Navigation.push(context: context, moveTo: OtpScreen(emailId: email));
  }
}
