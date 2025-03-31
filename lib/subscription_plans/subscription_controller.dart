import 'package:clc_app/apis_services/apis_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class SubscriptionController {
  SubscriptionController._();
  static final SubscriptionController instance = SubscriptionController._();

  Future<void> makePayment(int amount, Function(bool) onSuccess) async {
    try {
      String? paymentIntentClientsecret =
          await _createPaymentIntent(amount, "usd");
      if (paymentIntentClientsecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientsecret,
            merchantDisplayName: "Chow Luck Club Limited"),
      );
      await _processPayment((vl) => onSuccess(vl));
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculatedAmount(amount),
        "currency": currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretkey",
            "Content-Type": "application/x-www-from-urlencoded"
          },
        ),
      );
      if (response.data != null) {
        print(response.data);
        return response.data["client_secret"].toString();
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  String _calculatedAmount(int amount) {
    final calAmount = amount * 100;
    return calAmount.toString();
  }

  Future<void> _processPayment(Function(bool) onSuccess) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      onSuccess(true);
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      onSuccess(false);
      print(e);
    }
  }
}

void showSuccessPopup(BuildContext context, Function() onSuccess,
    {String message = "Payment Successful!"}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              SizedBox(height: 10),
              Text(
                "Success",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onSuccess();
                },
                child: Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showFailurePopup(BuildContext context,
    {String message = "Payment Failed!"}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 60,
              ),
              SizedBox(height: 10),
              Text(
                "Failed",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text("Try Again", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    },
  );
}
