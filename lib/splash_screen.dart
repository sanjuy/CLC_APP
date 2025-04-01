import 'package:clc_app/authentication/login/login_screen.dart';
import 'package:clc_app/home/dashboard_screen.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
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
    Future.delayed(const Duration(seconds: 4), () {
      navigationTo();
    });
  }

  navigationTo() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    if (await UserDetail.getUserLoggedIn ?? false) {
      if (!mounted) return;
      Navigation.pushReplacement(
          context: context, moveTo: const DashboardScreen());
    } else {
      if (!mounted) return;
      Navigation.pushReplacement(context: context, moveTo: const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primeColor,
        child: Center(child: Image.asset("C2.gif".directory(), scale: 1)),
      ),
    );
  }
}
