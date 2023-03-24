import 'package:flutter/material.dart';
import 'package:service_booking_system/pages/booked_page.dart';
import 'package:service_booking_system/pages/booking_page.dart';
import 'package:service_booking_system/widget/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        children: [
          const Center(child: Text("Aplikasi Service Booking System")),
          const SizedBox(
            height: 30.0,
          ),
          CustomButton3(
            btnName: "Booking",
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookingPage()),
              );
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          CustomButton3(
            btnName: "List Booking",
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookedPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
