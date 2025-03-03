import 'package:flutter/material.dart';

class Navigation {
  static pushReplacement(
      {required BuildContext context, required Widget moveTo}) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => moveTo));
  }

  static push(
      {required BuildContext context,
      required Widget moveTo,
      bool fullScree = false}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => moveTo, fullscreenDialog: fullScree));
  }

  static pop({required BuildContext context}) {
    Navigator.pop(context);
  }

  static pushAndRemoveUntil(
      {required BuildContext context, required Widget moveTo}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => moveTo),
      (Route<dynamic> route) => false, // Removes all previous routes
    );
  }
}
