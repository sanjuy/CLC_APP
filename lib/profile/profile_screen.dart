import 'package:clc_app/custom_widget/custom_image_view.dart';
import 'package:clc_app/profile/change_membership_type_screen.dart';
import 'package:clc_app/profile/edit_profile_screen.dart';
import 'package:clc_app/profile/reset_password_screen.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                CustomImageView(
                  shap: BoxShape.circle,
                ),
                TextButton(
                  onPressed: () {},
                  child: customText(
                      title: "Change Profile Image", color: Colors.blue),
                ),
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
      children: [
        _buildInfoRow(Icons.person, 'Fullname', 'John Jack'),
        _buildSeparator(),
        _buildInfoRow(Icons.email, 'Email', 'john.jack@gmail.com'),
        _buildSeparator(),
        _buildInfoRow(Icons.phone, 'Mobile', '8130686230'),
        _buildSeparator(),
        _buildInfoRow(Icons.location_on, 'Address', 'Noida UP'),
        _buildSeparator(),
        _buildInfoRow(Icons.male, 'Gender', 'Male'),
        _buildSeparator(),
        _buildInfoRow(Icons.card_membership, 'Membership Type', 'Free'),
      ],
    );
  }

  Widget _buildSettings() {
    return Card(
      // color: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildListTile(Icons.edit, 'Edit Profile', '', () {
            Navigation.push(
              context: context,
              moveTo: EditProfileScreen(),
            );
          }),
          _buildSeparator(),
          _buildListTile(Icons.swap_horiz, 'Change Membership Type', '', () {
            Navigation.push(
              context: context,
              moveTo: ChangeMembershipTypeScreen(),
            );
          }),
          _buildSeparator(),
          _buildListTile(Icons.lock, 'Reset Password', '', () {
            Navigation.push(
              context: context,
              moveTo: ResetPasswordScreen(),
            );
          }),
          _buildSeparator(),
          _buildListTile(Icons.delete, 'Delete Account', ''),
          _buildSeparator(),
          _buildListTile(Icons.logout, 'Logout', ''),
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

  Widget _buildSeparator() {
    return SizedBox(height: 5);
  }

  Widget _buildListTile(IconData icon, String title, String subtitle,
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
}


/*
import 'package:clc_app/custom_widget/custom_image_view.dart';
import 'package:clc_app/profile/change_membership_type_screen.dart';
import 'package:clc_app/profile/edit_profile_screen.dart';
import 'package:clc_app/profile/reset_password_screen.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              CustomImageView(
                shap: BoxShape.circle,
              ),
              TextButton(
                onPressed: () {},
                child: customText(
                    title: "Change Profile Image", color: Colors.blue),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRowView(label: "Name", value: "John Jack"),
                        CustomRowView(
                            label: "Phone number", value: "8130686230"),
                        CustomRowView(
                            label: "Email-Id", value: "john.jack@gmail.com"),
                        CustomRowView(label: "Gender", value: "Male"),
                        CustomRowView(label: "Membership Type", value: "Free"),
                        CustomRowView(label: "Address", value: "Noida UP"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        arrowButton(
                          title: "Edit Profile",
                          onPressed: () {
                            Navigation.push(
                              context: context,
                              moveTo: EditProfileScreen(),
                            );
                          },
                        ),
                        arrowButton(
                          title: "Change Membership Type",
                          onPressed: () {
                            Navigation.push(
                              context: context,
                              moveTo: ChangeMembershipTypeScreen(),
                            );
                          },
                        ),
                        arrowButton(
                          title: "Reset Password",
                          onPressed: () {
                            Navigation.push(
                              context: context,
                              moveTo: ResetPasswordScreen(),
                            );
                          },
                        ),
                        arrowButton(
                          title: "Delete Account",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Spacer(),
              // Image.asset("clc.png".directory(), scale: 10),
            ],
          ),
        ),
      ),
    );
  }
}
*/