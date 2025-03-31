import 'package:clc_app/apis_services/apis_endpoints.dart';
import 'package:clc_app/loading_indicator.dart';
import 'package:clc_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  await _setUP();
  runApp(const CLCApp());
}

Future<void> _setUP() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishablekey;
}

class CLCApp extends StatelessWidget {
  const CLCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: LoadingIndicator.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
