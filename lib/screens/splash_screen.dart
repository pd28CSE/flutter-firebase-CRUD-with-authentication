import 'dart:developer';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
