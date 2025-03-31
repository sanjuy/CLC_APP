import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class FullWidthAction extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const FullWidthAction(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primeColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => onPressed(),
      child: customText(
          title: title, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}

class ButtonType extends StatelessWidget {
  final String title;
  final Function() onTab;
  const ButtonType({
    super.key,
    required this.title,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onTab(),
        style: ElevatedButton.styleFrom(
          backgroundColor: primeColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.symmetric(horizontal: 0),
        ),
        child: customText(
          title: title,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
