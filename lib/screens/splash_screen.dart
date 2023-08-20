import 'package:flutter/material.dart';

import './auth_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (cntxt) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: const FlutterLogo(
        size: 5,
        duration: Duration(seconds: 5),
        curve: Curves.bounceIn,
        textColor: Colors.blue,
        style: FlutterLogoStyle.horizontal,
      ),
    );
  }
}
