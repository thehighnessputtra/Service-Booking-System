import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_booking_system/auth/login_page.dart';
import 'package:service_booking_system/pages/list_booking_page.dart';
import 'package:service_booking_system/pages/booking_page.dart';
import 'package:service_booking_system/pages/jadwal_servis_page.dart';
import 'package:service_booking_system/pages/log_booking_page.dart';
import 'package:service_booking_system/servies/firebase_service.dart';
import 'package:service_booking_system/widget/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email;
  String? role;

  Future getAcc() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) async {
      if (value.exists) {
        setState(() {
          email = value.data()!["email"];
          role = value.data()!["role"];
        });
      }
    });
  }

  @override
  void initState() {
    getAcc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: role == "Admin"
            ? const Text("Beranda - Admin")
            : const Text("Beranda"),
        actions: [
          email == null
              ? IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  icon: const Icon(Icons.login))
              : const SizedBox()
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        children: [
          const Center(child: Text("Aplikasi Service Booking System")),
          const SizedBox(
            height: 10.0,
          ),
          email == null
              ? const SizedBox()
              : Center(child: Text(email.toString())),
          role == null
              ? const SizedBox()
              : Center(child: Text(role.toString())),
          const SizedBox(
            height: 20.0,
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
          CustomButton3(
            btnName: "Jadwal Servis",
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const JadwalServisPage()),
              );
            },
          ),
          CustomButton1(
            btnName: "List Booking",
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookedPage()),
              );
            },
          ),
          role == "Admin"
              ? CustomButton1(
                  btnName: "Log Booking",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogBookingPage()),
                    );
                  },
                )
              : const SizedBox(),
          role == "Admin"
              ? CustomButton2(
                  btnName: "Logout",
                  onPress: () {
                    FirebaseService(FirebaseAuth.instance).signOut(context);
                  },
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
