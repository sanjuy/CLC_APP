import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/buttons.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardFormScreen extends StatefulWidget {
  final String? amount;
  const CreditCardFormScreen({super.key, this.amount});

  @override
  State<CreditCardFormScreen> createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends State<CreditCardFormScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Card details submitted successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Make Payment"),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CreditCardPreview(
              cardNumber: cardNumberController.text.isEmpty
                  ? "**** **** **** ****"
                  : cardNumberController.text,
              cardHolder: cardHolderController.text.isEmpty
                  ? "CARDHOLDER NAME"
                  : cardHolderController.text,
              expiryDate: expiryDateController.text.isEmpty
                  ? "MM/YY"
                  : expiryDateController.text,
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    controller: cardNumberController,
                    label: "Card Number",
                    hint: "1234 5678 9012 3456",
                    maxLength: 19,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CardNumberInputFormatter(), // Custom Formatter
                    ],
                    onChanged: (p0) {
                      cardNumberController.text = p0;
                      setState(() {});
                    },
                  ),
                  _buildTextField(
                    controller: cardHolderController,
                    label: "Cardholder Name",
                    hint: "John Doe",
                    onChanged: (p0) {
                      cardHolderController.text = p0;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: expiryDateController,
                          label: "Expiry Date",
                          hint: "MM/YY",
                          maxLength: 5,
                          keyboardType: TextInputType.datetime,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ExpiryDateInputFormatter(), // Auto add '/'
                          ],
                          onChanged: (p0) {
                            expiryDateController.text = p0;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          controller: cvvController,
                          label: "CVV",
                          hint: "***",
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          onChanged: (p0) {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  FullWidthAction(
                      title: "Payment Method ${widget.amount}",
                      onPressed: _submitForm)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          counterText: "",
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) => onChanged!(value),
        validator: (value) {
          if (value == null || value.isEmpty) return "Please enter $label";
          return null;
        },
      ),
    );
  }
}

class CreditCardPreview extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;

  CreditCardPreview({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [primeColor, primeColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.credit_card, color: Colors.white, size: 40),
              Icon(Icons.payment, color: Colors.white, size: 40),
            ],
          ),
          Text(
            cardNumber,
            style:
                TextStyle(fontSize: 22, color: Colors.white, letterSpacing: 2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Card Holder", style: labelStyle),
                  Text(cardHolder, style: infoStyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Expiry", style: labelStyle),
                  Text(expiryDate, style: infoStyle),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  final TextStyle labelStyle = TextStyle(fontSize: 12, color: Colors.white70);
  final TextStyle infoStyle = TextStyle(fontSize: 16, color: Colors.white);
}

/// Custom Input Formatter for Card Number
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      formatted += digitsOnly[i];
      if ((i + 1) % 4 == 0 && i + 1 != digitsOnly.length) {
        formatted += ' ';
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Custom Input Formatter for Expiry Date (Auto `/`)
class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length > 4) {
      digitsOnly = digitsOnly.substring(0, 4); // Max length is MMYY
    }

    String formatted = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2) {
        formatted += '/'; // Add '/' after MM
      }
      formatted += digitsOnly[i];
    }

    // Handle backspace correctly when removing '/'
    if (oldValue.text.endsWith('/') &&
        formatted.length < oldValue.text.length) {
      formatted = formatted.substring(0, formatted.length - 1);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
