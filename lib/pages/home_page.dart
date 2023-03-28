import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/auth/login_page.dart';
import 'package:service_booking_system/servies/firebase_service.dart';
import 'package:service_booking_system/utils/constant.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/custom_notification.dart';
import 'package:service_booking_system/widget/custom_textformfield.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerNoHP = TextEditingController();
  TextEditingController controllerReview = TextEditingController();
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
  int buttonApk = 1;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                "Service Booking System",
                style: size24.copyWith(fontWeight: fw600),
              )),
              const SizedBox(
                height: 10.0,
              ),
              Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.lightGreen[700],
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10))),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonApk = 1;
                            });
                          },
                          child: const Text("Tentang Kami"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonApk == 1
                                  ? Colors.lightGreen[400]
                                  : Colors.lightGreen[700],
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10)))),
                        )),
                    SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonApk = 3;
                            });
                          },
                          child: const Text("Review"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonApk == 3
                                  ? Colors.lightGreen[400]
                                  : Colors.lightGreen[700],
                              elevation: 0,
                              shape: const ContinuousRectangleBorder()),
                        )),
                    SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonApk = 4;
                            });
                          },
                          child: const Text("Kontak"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonApk == 4
                                  ? Colors.lightGreen[400]
                                  : Colors.lightGreen[700],
                              elevation: 0,
                              shape: const ContinuousRectangleBorder()),
                        )),
                    SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              buttonApk = 2;
                            });
                          },
                          child: const Text("Berikan Review"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonApk == 2
                                  ? Colors.lightGreen[400]
                                  : Colors.lightGreen[700],
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10)))),
                        )),
                  ],
                ),
              ]),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10)),
                    color: Colors.lightGreen[400],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: buttonApk == 1
                      ? tentangKami()
                      : buttonApk == 2
                          ? berikanReview()
                          : buttonApk == 3
                              ? review()
                              : buttonApk == 4
                                  ? kontak()
                                  : const Text("ERROR")),
            ],
          ),
        ),
      ),
    );
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

  berikanReview() {
    return Column(
      children: [
        const Text(
            "Silahkan isi Form Review dengan cara memasukan form sesuai dengan form booking sebelumnya",
            textAlign: TextAlign.justify),
        const SizedBox(
          height: 10.0,
        ),
        CustomTextFormField(
          hint: DateFormat("EEEE, d-MMMM-y", "ID").format(selectedDate),
          formNama: "Tanggal",
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.fromMillisecondsSinceEpoch(calcDate),
              locale: const Locale("in", "ID"),
              firstDate: DateTime.now(),
              lastDate: DateTime(2040),
            );
            setState(() {
              selectedDate = pickedDate!;
            });
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 50,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              labelStyle: TextStyle(color: Colors.black87),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              labelText: "Jam Servis",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            isExpanded: true,
            hint: Text(valueJamKerja),
            validator: (value) {
              if (valueJamKerja == "") {
                return 'Jam Servis tidak boleh kosong!';
              }
              return null;
            },
            elevation: 0,
            borderRadius: BorderRadius.circular(12),
            onChanged: (value) {
              setState(() {
                valueJamKerja = value!;
              });
            },
            items: listJamKerja
                .map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        CustomTextFormField(
          formNama: "No Handphone",
          hint: "08XXXXXXXXX",
          keyboardType: TextInputType.number,
          controller: controllerNoHP,
          validasi: (value) {
            if (value!.isEmpty) {
              return "No Handphone tidak boleh kosong!";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        CustomTextFormField(
          setHigh: true,
          formNama: "Review",
          hint: "Pelayanan sangat baik",
          minLine: 3,
          maxLine: 5,
          height: 80,
          controller: controllerReview,
          validasi: (value) {
            if (value!.isEmpty) {
              return "No Handphone tidak boleh kosong!";
            }
            return null;
          },
        ),
        SizedBox(
          width: double.infinity,
          child: CustomButton3(
            btnName: "Kirim Review",
            onPress: () {
              dialogInfoWithoutDelay(context, "Cooming soon!");
            },
          ),
        )
      ],
    );
  }

  review() {
    return Text("Berikut review dari customer pada pelayanan kami",
        style: size14, textAlign: TextAlign.justify);
  }

  kontak() {
    return Column(children: [
      Row(
        children: const [
          Expanded(flex: 1, child: Text("Email")),
          Expanded(flex: 3, child: Text(": emailmu@gmail.com")),
        ],
      ),
      Row(
        children: const [
          Expanded(flex: 1, child: Text("No. Handphone")),
          Expanded(flex: 3, child: Text(": 08XXXXXXXXXX")),
        ],
      ),
      const SizedBox(
        height: 5.0,
      ),
      Row(
        children: [
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse("mailto:emailmu@gmail.com");
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
              final Uri url = Uri.parse("https://wa.me/628");
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
