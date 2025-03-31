import 'package:clc_app/home/redeem/web_view_screen.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showInSnackBar({
  required BuildContext context,
  required String message,
  Color? bgColor,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: bgColor ?? primeColor,
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
  bool isShowCheckBox = false,
  Function()? onAccepted,
}) async {
  var isChecked = false;
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                  customText(title: msg),
                  SizedBox(height: 10),
                  isShowCheckBox
                      ? Row(
                          children: [
                            Checkbox(
                              activeColor: primeColor,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            customText(title: "I agree to the"),
                            TextButton(
                                onPressed: () {
                                  Navigation.push(
                                    context: context,
                                    moveTo: WebViewScreen(
                                      title: "Terms and Conditions",
                                      url:
                                          "https://drive.google.com/file/d/18TbSJ283MmYBUDYXGn-K_iBH0C-mOAgJ/view",
                                    ),
                                  );
                                },
                                child: customText(
                                    title: "Terms and Conditions",
                                    color: Colors.red))
                          ],
                        )
                      : SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonType(
                        title: titleCancel,
                        onTab: () => Navigation.pop(context: context),
                      ),
                      SizedBox(width: 5),
                      ButtonType(
                        title: titleOK,
                        onTab: () {
                          if (isShowCheckBox) {
                            if (isChecked) {
                              Navigation.pop(context: context);
                              onAccepted!();
                            } else {
                              showInSnackBar(
                                  context: context,
                                  message:
                                      "Please agree to the Terms and Conditions.");
                            }
                          } else {
                            Navigation.pop(context: context);
                            onAccepted!();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> showImagePickerDialog(
    BuildContext context, Function(ImageSource) onClicked) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: customText(title: "Select Image Source"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: primeColor),
              title: customText(title: "Camera"),
              onTap: () {
                onClicked(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: primeColor),
              title: customText(title: "Gallery"),
              onTap: () {
                onClicked(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
