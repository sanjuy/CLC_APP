import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

void showInSnackBar({
  required BuildContext context,
  required String message,
  Color bgColor = Colors.grey,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: Duration(seconds: 3),
    ),
  );
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String msg,
  String titleOK = "Accept",
  String titleCancel = "Reject",
  bool barrierDismissible = false,
  Function()? onAccepted,
}) async {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customText(
                  title: title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primeColor),
              Divider(),
              SizedBox(height: 10),
              customText(
                  title:
                      "When customers register, they will get a disclaimer popup and they accept it before proceeding to the app."),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonType(
                    title: titleCancel,
                    onTab: () => Navigation.pop(context: context),
                  ),
                  SizedBox(width: 10),
                  ButtonType(
                    title: titleOK,
                    onTab: () => onAccepted!(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
