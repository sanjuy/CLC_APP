import 'package:clc_app/profile/edit_profile_screen.dart';
import 'package:clc_app/profile/profile_screen.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isShowProfile;
  final bool isEditProfile;
  const CustomAppBar(
      {super.key,
      this.title,
      this.isShowProfile = false,
      this.isEditProfile = false});

  // Default function that does nothing
  static void defaultActionHandler(String value) {
    // print("Default action handler: $value");
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: customText(
          title: title ?? "", fontSize: 14, fontWeight: FontWeight.bold),
      actions: [
        isShowProfile
            ? InkWell(
                onTap: () {
                  Navigation.push(context: context, moveTo: ProfileScreen());
                },
                child: CircleAvatar(
                  radius: 20,
                  child: Image.asset("dummy.jpg".directory()),
                ),
              )
            : SizedBox(),
        isEditProfile
            ? InkWell(
                onTap: () {
                  Navigation.push(
                      context: context, moveTo: EditProfileScreen());
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
              )
            : SizedBox(),
        SizedBox(width: 8),
      ],
    );
  }
}
