import 'package:clc_app/loading_indicator.dart';
import 'package:clc_app/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CLCApp());
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
