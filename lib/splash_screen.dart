import 'package:clc_app/authentication/login_screen.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 5), () {
      navigationTo();
    });
  }

  navigationTo() {
    // Show status bar again before navigating
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Navigation.pushReplacement(context: context, moveTo: const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primeColor,
        child:
            Center(child: Image.asset("splashLogo.png".directory(), scale: 2)),
      ),
    );
  }
}
