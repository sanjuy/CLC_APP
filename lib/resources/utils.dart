import 'package:clc_app/resources/default_color.dart';
import 'package:flutter/material.dart';

Widget generalTextField({
  String? label,
  required TextEditingController controller,
  IconData? icon,
  TextInputType keyboardType = TextInputType.text,
  bool readOnly = false,
  Function(String)? onTab,
}) {
  return TextField(
    readOnly: readOnly,
    keyboardType: keyboardType,
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: primeColor),
      labelText: "$label",
      labelStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    ),
  );
}

Widget passwordTextField({
  String? label,
  IconData? icon,
  required TextEditingController controller,
  bool isObscure = true,
  Function()? onPressed,
}) {
  return TextFormField(
    obscureText: isObscure,
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: primeColor,
      ),
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      suffixIcon: IconButton(
        icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          onPressed!();
        },
      ),
    ),
  );
}

Text customText({
  required String title,
  double fontSize = 14,
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

Widget multiLineTextField({
  String? label,
  int maxLines = 3,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      alignLabelWithHint: true,
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    ),
    keyboardType: TextInputType.multiline,
    maxLines: maxLines,
  );
}

Widget dropDownTextField({
  required String title,
  IconData? icon,
  required List<String> lt,
  required Function(String) onSelected,
}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: primeColor,
      ),
      label: Text(title),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    items: lt
        .map((account) => DropdownMenuItem<String>(
              value: account,
              child: Text(account),
            ))
        .toList(),
    onChanged: (String? selectedAccount) {
      onSelected(selectedAccount ?? "");
    },
  );
}

class CustomRowView extends StatelessWidget {
  final String? label;
  final String? value;
  const CustomRowView({
    super.key,
    this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: customText(
            title: "$label:",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: customText(
            title: "$value",
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

TextButton arrowButton({required String title, required Function() onPressed}) {
  return TextButton(
    onPressed: () => onPressed(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customText(
            title: title, fontWeight: FontWeight.bold, color: Colors.grey),
        Icon(
          Icons.arrow_forward,
          color: Colors.black,
        )
      ],
    ),
  );
}
