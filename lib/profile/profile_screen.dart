import 'package:clc_app/authentication/login/login_screen.dart';
import 'package:clc_app/custom_widget/custom_image_view.dart';
import 'package:clc_app/profile/change_membership/change_membership_type_screen.dart';
import 'package:clc_app/profile/edit_profile_screen.dart';
import 'package:clc_app/profile/profile_controller.dart';
import 'package:clc_app/profile/reset_password/reset_password_screen.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";
  String mobile = "";
  String gender = "";
  String address = "";
  String memberType = "";
  String profile = "";

  getUserInfo() async {
    name = await UserDetail.getUserName ?? "";
    email = await UserDetail.getUserEmail ?? "";
    mobile = await UserDetail.getMobileNUmber ?? "";
    gender = await UserDetail.getGender ?? "";
    address = await UserDetail.getAddress ?? "";
    memberType = await UserDetail.getMembershipType ?? "";
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                profile == ""
                    ? CustomImageView(shap: BoxShape.circle)
                    : NetworkImageView(
                        shap: BoxShape.circle,
                        imagePath: profile,
                      ),
                SizedBox(height: 10),
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _buildUserInfo(),
                )),
                SizedBox(
                  height: 15,
                ),
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildSettings(),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      spacing: 5,
      children: [
        _buildInfoRow(Icons.person, 'Fullname', name),
        _buildInfoRow(Icons.email, 'Email', email),
        _buildInfoRow(Icons.phone, 'Mobile', mobile),
        _buildInfoRow(Icons.location_on, 'Address', address),
        _buildInfoRow(Icons.male, 'Gender', gender),
        _buildInfoRow(Icons.card_membership, 'Membership Type', memberType),
      ],
    );
  }

  Widget _buildSettings() {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        spacing: 5,
        children: [
          buildListTile(Icons.edit, 'Edit Profile', '', () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()),
            );
            getUserInfo();
          }),
          buildListTile(Icons.swap_horiz, 'Membership Type', '', () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeMembershipTypeScreen()),
            );
            getUserInfo();
          }),
          buildListTile(Icons.lock, 'Reset Password', '', () {
            Navigation.push(
              context: context,
              moveTo: ResetPasswordScreen(),
            );
          }),
          buildListTile(Icons.delete, 'Delete Account', '', () {
            showCustomDialog(
              context: context,
              msg: "Do you want to delete your account?",
              title: "Delete Account",
              titleOK: "Yes",
              titleCancel: "No",
              onAccepted: () {
                ProfileController.deleteAccount(context: context);
              },
            );
          }),
          buildListTile(Icons.logout, 'Logout', '', () {
            showCustomDialog(
              context: context,
              msg: "Do you want to logout your account?",
              title: "Logout Account",
              titleOK: "Yes",
              titleCancel: "No",
              onAccepted: () {
                UserDetail.setUserLoggedIn = false;
                Navigation.pushAndRemoveUntil(
                    context: context, moveTo: LoginScreen());
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: primeColor),
          SizedBox(width: 10),
          Expanded(
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(value, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

Widget buildListTile(IconData icon, String title, String subtitle,
    [VoidCallback? onTap]) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: primeColor),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                if (subtitle.isNotEmpty)
                  Text(subtitle,
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
              ],
            ),
          ),
          if (onTap != null) Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    ),
  );
}
