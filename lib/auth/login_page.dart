import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_booking_system/navbar/navigation_bar.dart';
import 'package:service_booking_system/servies/firebase_service.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/custom_textformfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        children: [
          const SizedBox(
            height: 40.0,
          ),
          const Text("LOGIN ADMIN"),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextFormField(
            controller: controllerEmail,
            formNama: "Email",
          ),
          const SizedBox(
            height: 10.0,
          ),
          CustomTextFormField(
            controller: controllerPassword,
            formNama: "Password",
          ),
          const SizedBox(
            height: 5.0,
          ),
          CustomButton1(
              btnName: "Login",
              onPress: () {
                FirebaseService(FirebaseAuth.instance).signInEmail(
                    email: controllerEmail.text,
                    password: controllerPassword.text,
                    context: context);
              }),
          CustomButton2(
              btnName: "Kembali",
              onPress: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavigationBarUI()),
                );
              }),
        ],
      ),
    );
  }
}
