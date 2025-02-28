
import 'package:flutter/material.dart';

Widget generalTextField(
  {
  String? label,
  required TextEditingController controller,
  IconData? icon,
  TextInputType keyboardType = TextInputType.text,
  bool readOnly = false,
  Function(String)? onTab,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: "$label",
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}

Text customtext({
  required String title,
  double fontSize = 12,
  String? fontfamily = "Corporate S",
  Color color = Colors.black,
  bool isSingleLine = false,
  TextAlign alinment = TextAlign.left,
  FontWeight fontWeight = FontWeight.normal,
  int maxLines = 15,
}) {
  return Text(
    title,
    maxLines: maxLines,
    textAlign: alinment,
    style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontfamily,
        color: color,
        fontWeight: fontWeight,
        overflow: isSingleLine ? TextOverflow.ellipsis : TextOverflow.visible),
  );
}
