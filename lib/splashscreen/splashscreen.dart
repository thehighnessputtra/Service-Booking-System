import 'package:flutter/material.dart';
import 'package:service_booking_system/navbar/navigation_bar.dart';
import 'package:service_booking_system/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ssFunction() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationBarUI()),
      );
    });
  }

  @override
  void initState() {
    ssFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Ini Splashscreen")),
    );
  }
}
