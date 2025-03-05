import 'package:clc_app/resources/extenssions.dart';
import 'package:flutter/material.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Credit Card UI")),
      body: Center(
        child: CreditCardWidget(
          cardNumber: "**** **** **** 1234",
          cardHolder: "John Doe",
          expiryDate: "12/26",
          cardType: "visa", // Change to "mastercard" if needed
        ),
      ),
    );
  }
}

class CreditCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cardType; // Accepts "visa" or "mastercard"

  CreditCardWidget({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
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
              Image.asset("logo.png".directory(), width: 50), // Chip Icon
              Image.asset(
                cardType == "visa"
                    ? "logo.png".directory()
                    : "logo.png".directory(),
                width: 60,
              ), // Visa/MasterCard Logo
            ],
          ),
          Text(
            cardNumber,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
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
