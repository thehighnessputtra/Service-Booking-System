// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/auth/login_page.dart';
import 'package:service_booking_system/pages/home/berikan_review/berikan_review_page.dart';
import 'package:service_booking_system/pages/home/cek_status_servis/cek_status_servis_page.dart';
import 'package:service_booking_system/pages/home/review_service.dart';
import 'package:service_booking_system/pages/home/histori_servis/histori_servis.dart';
import 'package:service_booking_system/servies/firebase_service.dart';
import 'package:service_booking_system/utils/constant.dart';
import 'package:service_booking_system/widget/card_widget.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/custom_notification.dart';
import 'package:service_booking_system/widget/custom_textformfield.dart';
import 'package:service_booking_system/widget/transition_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerNoHP = TextEditingController();
  TextEditingController controllerKomentar = TextEditingController();
  double ratingReview = 3.0;
  DateTime selectedDate = DateTime.now();
  int calcDate = DateTime.now().millisecondsSinceEpoch + 86400000;

  String fotoNama = "Masukan Gambar Motor";
  List listJenisServis = ["Servis Ringan", "Servis Besar"];
  String valueJenisServis = "";
  String valueJamKerja = "";
  List listJamKerja = [
    "08.00 WIB",
    "09.00 WIB",
    "10.00 WIB",
    "11.00 WIB",
    "13.00 WIB",
    "14.00 WIB",
    "15.00 WIB",
    "16.00 WIB",
  ];
  String? email;
  String? role;
  int buttonServis = 0;
  int btnSort = 0;
  int buttonApk = 1;
  String emailOwner = "akbarmuliaardiansyah27@gmail.com";
  String noHpOwner = "85842635120";

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
                : IconButton(
                    onPressed: () {
                      FirebaseService(FirebaseAuth.instance).signOut(context);
                    },
                    icon: const Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Center(
                child: Text(
              "Service Booking System",
              style: size24.copyWith(fontWeight: fw600),
            )),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCardWidget(
                    border: BorderRadius.circular(12),
                    icon: Icons.reviews,
                    onTap: () {
                      navPushTransition(context, const BerikanReviewPage());
                    },
                    color: Colors.green.shade500,
                    text: "Berikan Review"),
                CustomCardWidget(
                    border: BorderRadius.circular(12),
                    icon: Icons.history,
                    onTap: () {
                      navPushTransition(context, const HistoriServis());
                    },
                    color: Colors.green.shade900,
                    text: "Histori Servis"),
                CustomCardWidget(
                    border: BorderRadius.circular(12),
                    icon: Icons.search,
                    onTap: () {
                      navPushTransition(context, const CekStatusServisPage());
                    },
                    color: Colors.green.shade700,
                    text: "Status Servis")
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonApk = 1;
                    });
                  },
                  child: const Text("Tentang Kami"),
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 3, 50),
                      backgroundColor: buttonApk == 1
                          ? Colors.lightGreen[400]
                          : Colors.lightGreen[700],
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(10)))),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonApk = 3;
                    });
                  },
                  child: const Text("Review"),
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 3, 50),
                      backgroundColor: buttonApk == 3
                          ? Colors.lightGreen[400]
                          : Colors.lightGreen[700],
                      elevation: 0,
                      shape: const ContinuousRectangleBorder()),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonApk = 4;
                    });
                  },
                  child: const Text("Kontak"),
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 3, 50),
                      backgroundColor: buttonApk == 4
                          ? Colors.lightGreen[400]
                          : Colors.lightGreen[700],
                      elevation: 0,
                      shape: const ContinuousRectangleBorder()),
                ),
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(10)),
                  color: Colors.lightGreen[400],
                ),
                padding: const EdgeInsets.all(10),
                child: buttonApk == 1
                    ? tentangKami()
                    : buttonApk == 3
                        ? review()
                        : buttonApk == 4
                            ? kontak()
                            : const Text("ERROR")),
          ],
        )));
  }

  tentangKami() {
    return Column(
      children: [
        Text(
            "Service Booking System merupakan Layanan yang memudahkan pelanggan untuk melakukan reservasi servis kendaraan mereka supaya tidak perlu mengantri lama. Ada 2 jenis servis yang disediakan, yaitu Servis Ringan dan Servis Besar",
            style: size14,
            textAlign: TextAlign.justify),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 30,
              child: ElevatedButton(
                  onPressed: () {
                    if (buttonServis == 1) {
                      setState(() {
                        buttonServis = 0;
                      });
                    } else {
                      setState(() {
                        buttonServis = 1;
                      });
                    }
                  },
                  child: const Text("Servis Ringan"),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: buttonServis == 1
                          ? Colors.lightGreen[600]
                          : Colors.lightGreen[700])),
            ),
            SizedBox(
              height: 30,
              child: ElevatedButton(
                  onPressed: () {
                    if (buttonServis == 2) {
                      setState(() {
                        buttonServis = 0;
                      });
                    } else {
                      setState(() {
                        buttonServis = 2;
                      });
                    }
                  },
                  child: const Text("Servis Besar"),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: buttonServis == 2
                          ? Colors.lightGreen[600]
                          : Colors.lightGreen[700])),
            ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        buttonServis == 1
            ? Text(
                "Servis Ringan terdiri dari pergantian oli mesin, kampas rem, langsam, busi motor, suspensi, lampu, filter udara, aki, sampai dengan tekanan ban",
                textAlign: TextAlign.justify,
                style: size14,
              )
            : const SizedBox(),
        buttonServis == 2
            ? Text(
                "Servis Besar merupakan perawatan motor yang mengharuskan mesin motor Anda dibongkar",
                style: size14,
                textAlign: TextAlign.justify,
              )
            : const SizedBox(),
      ],
    );
  }

  review() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 30,
              child: ElevatedButton(
                  onPressed: () {
                    if (btnSort == 1) {
                      setState(() {
                        btnSort = 0;
                      });
                    } else {
                      setState(() {
                        btnSort = 1;
                      });
                    }
                  },
                  child: const Text("Tertinggi"),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: btnSort == 1
                          ? Colors.yellow[900]
                          : Colors.yellow[700])),
            ),
            SizedBox(
              height: 30,
              child: ElevatedButton(
                  onPressed: () {
                    if (btnSort == 2) {
                      setState(() {
                        btnSort = 0;
                      });
                    } else {
                      setState(() {
                        btnSort = 2;
                      });
                    }
                  },
                  child: const Text("Terendah"),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: btnSort == 2
                          ? Colors.yellow[900]
                          : Colors.yellow[700])),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        StreamBuilder(
          stream: btnSort == 1
              ? FirebaseFirestore.instance
                  .collection('logBooking')
                  .orderBy("rating", descending: true)
                  .snapshots()
              : btnSort == 2
                  ? FirebaseFirestore.instance
                      .collection('logBooking')
                      .orderBy("rating", descending: false)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('logBooking')
                      .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListReviewService(
                listHasilBooking: snapshot.data!.docs,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  kontak() {
    return Column(children: [
      Row(
        children: [
          const Expanded(flex: 1, child: Text("Email")),
          Expanded(flex: 3, child: Text(": $emailOwner")),
        ],
      ),
      Row(
        children: [
          const Expanded(flex: 1, child: Text("No. Handphone")),
          Expanded(flex: 3, child: Text(": 0$noHpOwner")),
        ],
      ),
      const SizedBox(
        height: 5.0,
      ),
      Row(
        children: [
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse("mailto:$emailOwner");
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw "Could not launch $url";
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                  color: Colors.lightGreen[700],
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: const [
                  Icon(Icons.email, color: Colors.white),
                  Text(
                    "Email",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse("https://wa.me/62$noHpOwner");
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw "Could not launch $url";
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                  color: Colors.lightGreen[700],
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: const [
                  Icon(Icons.call, color: Colors.white),
                  Text(
                    "Whatsapp",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
