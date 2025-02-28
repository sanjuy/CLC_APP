import 'package:flutter/material.dart';

class FullWidthAction extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const FullWidthAction({super.key, required this.title,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () =>onPressed(),
      child: Text(title),
    );
  }
}
