import 'package:flutter/material.dart';
import 'package:service_booking_system/splashscreen/splashscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Intl.defaultLocale = 'id';
    // initializeDateFormatting("id");
    return const MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [Locale('en'), Locale('id')],
        home: SplashScreen());
  }
}
