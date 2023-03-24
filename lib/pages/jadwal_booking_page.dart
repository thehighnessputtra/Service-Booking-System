import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class JadwalServisPage extends StatefulWidget {
  const JadwalServisPage({super.key});

  @override
  State<JadwalServisPage> createState() => _JadwalServisPageState();
}

class _JadwalServisPageState extends State<JadwalServisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jadwal Booking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('fixedBooking').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListJadwalServisPage(
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

class ListJadwalServisPage extends StatefulWidget {
  final List<DocumentSnapshot> listHasilBooking;
  const ListJadwalServisPage({super.key, required this.listHasilBooking});

  @override
  State<ListJadwalServisPage> createState() => _ListJadwalServisPageState();
}

class _ListJadwalServisPageState extends State<ListJadwalServisPage> {
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
          String storageAccBy = itemsList["accBy"];
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
                          Row(
                            children: [
                              const Expanded(flex: 2, child: Text("Nama")),
                              Expanded(flex: 5, child: Text(": $storageNama")),
                            ],
                          ),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("No HP")),
                                    Expanded(
                                        flex: 5, child: Text(": $storageNoHP")),
                                  ],
                                )
                              : SizedBox(),
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
                              : SizedBox(),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text("Jenis Servis")),
                              Expanded(
                                  flex: 5,
                                  child: Text(": $storageJenisServis")),
                            ],
                          ),
                          Row(
                            children: const [
                              Expanded(flex: 2, child: Text("Status")),
                              Expanded(
                                  flex: 5, child: Text(": Booking diterima")),
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
                              : SizedBox(),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("Acc by")),
                                    Expanded(
                                        flex: 5,
                                        child: Text(": $storageAccBy")),
                                  ],
                                )
                              : SizedBox(),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    CustomButton1(
                                        btnName: "Chat WA",
                                        onPress: () async {
                                          if (storageNoHP != null) {
                                            final Uri url = Uri.parse(
                                                "https://wa.me/$storageNoHP");
                                            if (!await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication)) {
                                              throw "Could not launch $url";
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Could not launch URL!")));
                                          }
                                        }),
                                  ],
                                )
                              : SizedBox()
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
                            : SizedBox())
                  ],
                ),
                const Divider(
                  color: Colors.black45,
                ),
              ]);
        });
  }
}
