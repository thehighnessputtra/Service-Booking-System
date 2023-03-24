import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LogBookingPage extends StatefulWidget {
  const LogBookingPage({super.key});

  @override
  State<LogBookingPage> createState() => _LogBookingPageState();
}

class _LogBookingPageState extends State<LogBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Booking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('logBooking').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListLogBookingPage(
                listHasilBooking: snapshot.data!.docs,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ListLogBookingPage extends StatefulWidget {
  final List<DocumentSnapshot> listHasilBooking;
  const ListLogBookingPage({super.key, required this.listHasilBooking});

  @override
  State<ListLogBookingPage> createState() => _ListLogBookingPageState();
}

class _ListLogBookingPageState extends State<ListLogBookingPage> {
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
    return ListView.builder(
        itemCount: widget.listHasilBooking.length,
        itemBuilder: (context, index) {
          final itemsList = widget.listHasilBooking[index];
          String storageTanggal = itemsList["tanggal+jam"];
          String storageNama = itemsList["nama"];
          String storageNoHP = itemsList["noHp"];
          String storageTipeMotor = itemsList["tipeMotor"];
          String storageNoPolisi = itemsList["noPolisi"];
          String storageJenisServis = itemsList["jenisServis"];
          String storageJumlahKm = itemsList["jumlahKm"];
          String storageStatus = itemsList["status"];
          String storageGambarNama = itemsList["gambarNama"];
          String storageGambarUrl = itemsList["gambarUrl"];

          return Column(
              // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(flex: 2, child: Text("Tgl/Jam")),
                              Expanded(
                                  flex: 5, child: Text(": $storageTanggal")),
                            ],
                          ),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("Nama")),
                                    Expanded(
                                        flex: 5, child: Text(": $storageNama")),
                                  ],
                                )
                              : const SizedBox(),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("No HP")),
                                    Expanded(
                                        flex: 5, child: Text(": $storageNoHP")),
                                  ],
                                )
                              : const SizedBox(),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text("Tipe Motor")),
                              Expanded(
                                  flex: 5, child: Text(": $storageTipeMotor")),
                            ],
                          ),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("No Polisi")),
                                    Expanded(
                                        flex: 5,
                                        child: Text(": $storageNoPolisi")),
                                  ],
                                )
                              : const SizedBox(),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text("Jenis Servis")),
                              Expanded(
                                  flex: 5,
                                  child: Text(": $storageJenisServis")),
                            ],
                          ),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("Jumlah Km")),
                                    Expanded(
                                        flex: 5,
                                        child: Text(": $storageJumlahKm")),
                                  ],
                                )
                              : const SizedBox(),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("Status")),
                                    Expanded(
                                        flex: 5,
                                        child: Text(": $storageStatus")),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: role == "Admin"
                            ? GestureDetector(
                                onTap: () async {
                                  await showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Full Gambar'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Image(
                                                image: NetworkImage(
                                                    storageGambarUrl),
                                                fit: BoxFit.cover,
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  child: Image.network(storageGambarUrl,
                                      fit: BoxFit.cover),
                                  height: 160,
                                  color: Colors.green,
                                ),
                              )
                            : const SizedBox())
                  ],
                ),
                const Divider(
                  color: Colors.black45,
                ),
              ]);
        });
  }
}
