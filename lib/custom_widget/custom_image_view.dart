import 'dart:io';

import 'package:clc_app/resources/extenssions.dart';
import 'package:flutter/material.dart';

class CustomImageView extends StatelessWidget {
  final double width;
  final double height;
  final BoxShape shap;
  final Color borderColor;
  final double borderWidth;
  final File? imagePath;
  const CustomImageView({
    super.key,
    this.height = 100,
    this.width = 100,
    this.shap = BoxShape.rectangle,
    this.borderColor = Colors.grey,
    this.borderWidth = 3,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shap,
        border: Border.all(color: borderColor, width: borderWidth),
        image: DecorationImage(
          image: imagePath != null
              ? FileImage(imagePath!)
              : AssetImage("dummy.jpg".directory()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NetworkImageView extends StatelessWidget {
  final double width;
  final double height;
  final BoxShape shap;
  final Color borderColor;
  final double borderWidth;
  final String? imagePath;
  const NetworkImageView({
    super.key,
    this.height = 100,
    this.width = 100,
    this.shap = BoxShape.rectangle,
    this.borderColor = Colors.grey,
    this.borderWidth = 3,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shap,
        border: Border.all(color: borderColor, width: borderWidth),
        image: DecorationImage(
          image: imagePath != null
              ? NetworkImage(imagePath ?? "")
              : AssetImage("dummy.jpg".directory()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
