// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/servies/firebase_service.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/custom_notification.dart';
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
        title: const Text("Jadwal Servis"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('jadwalServis')
              .orderBy("updateTime", descending: true)
              .snapshots(),
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
          Timestamp storageTanggal = itemsList["tanggal"];
          String storageJam = itemsList["jam"];
          String storageNama = itemsList["nama"];
          int storageNoHP = itemsList["noHp"];
          String storageTipeMotor = itemsList["tipeMotor"];
          String storageNoPolisi = itemsList["noPolisi"];
          String storageJenisServis = itemsList["jenisServis"];
          String storageJumlahKm = itemsList["jumlahKm"];
          String storageStatus = itemsList["status"];
          String storageGambarUrl = itemsList["gambarUrl"];
          String storageGambarNama = itemsList["gambarNama"];
          String storageUpdateBy = itemsList["updateBy"];
          String storageNoTiket = itemsList["noTiket"];

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
                                  flex: 5,
                                  child: Text(
                                      ": ${DateFormat("EEEE, d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} / $storageJam")),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(flex: 2, child: Text("No. Tiket")),
                              Expanded(
                                  flex: 5, child: Text(": $storageNoTiket")),
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
                                        flex: 5,
                                        child: Text(": 0$storageNoHP")),
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
                          Row(
                            children: [
                              const Expanded(flex: 2, child: Text("Status")),
                              Expanded(
                                  flex: 5, child: Text(": $storageStatus")),
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
                                        flex: 2, child: Text("Acc by")),
                                    Expanded(
                                        flex: 5,
                                        child: Text(": $storageUpdateBy")),
                                  ],
                                )
                              : const SizedBox(),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomButton1(
                                            btnName: "Chat WA",
                                            onPress: () async {
                                              if (storageNoHP != null) {
                                                final Uri url = Uri.parse(
                                                    "https://api.whatsapp.com/send?phone=62$storageNoHP&text=Halo%20$storageNama");
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
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        CustomButton3(
                                            btnName: "SELESAI",
                                            onPress: () async {
                                              await showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30.0),
                                                    child: Wrap(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              const Text(
                                                                "KONFIRMASI SERVIS",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20.0,
                                                              ),
                                                              Text(
                                                                'Apakah yakin ingin menyelesaikan servis dari $storageNama?',
                                                              ),
                                                              const SizedBox(
                                                                height: 20.0,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[600],
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            "No"),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .blueGrey,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseService(FirebaseAuth.instance).postSelesaiServisToFirestore(
                                                                          gambarUrl:
                                                                              storageGambarUrl,
                                                                          gambarNama:
                                                                              storageGambarNama,
                                                                          emailAdmin:
                                                                              email!,
                                                                          nama:
                                                                              storageNama,
                                                                          jenisServis:
                                                                              storageJenisServis,
                                                                          jam:
                                                                              storageJam,
                                                                          noHp:
                                                                              storageNoHP,
                                                                          noPolisi:
                                                                              storageNoPolisi,
                                                                          jumlahKm:
                                                                              storageJumlahKm,
                                                                          tanggal: DateTime.parse(storageTanggal
                                                                              .toDate()
                                                                              .toString()),
                                                                          tipeMotor:
                                                                              storageTipeMotor);
                                                                      FirebaseService(
                                                                              FirebaseAuth.instance)
                                                                          .updateStatusLogBooking(
                                                                        title:
                                                                            "${DateFormat("d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} $storageJam $storageNoHP",
                                                                        status:
                                                                            "Servis selesai",
                                                                      );
                                                                      FirebaseService(
                                                                              FirebaseAuth.instance)
                                                                          .deleteJadwalServisToFirebase(
                                                                        title:
                                                                            "${DateFormat("d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} $storageJam $storageNoHP",
                                                                      );
                                                                      dialogInfoWithoutDelay(
                                                                        context,
                                                                        "Servis $storageNama telah selesai!",
                                                                      );
                                                                    },
                                                                    child: const Text(
                                                                        "Yes"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            }),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        CustomButton2(
                                            btnName: "CANCEL",
                                            onPress: () async {
                                              await showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30.0),
                                                    child: Wrap(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              const Text(
                                                                "KONFIRMASI SERVIS",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20.0,
                                                              ),
                                                              Text(
                                                                'Apakah yakin ingin cancel servis dari $storageNama?',
                                                              ),
                                                              const SizedBox(
                                                                height: 20.0,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[600],
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            "No"),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .blueGrey,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseService(
                                                                              FirebaseAuth.instance)
                                                                          .updateStatusLogBooking(
                                                                        title:
                                                                            "${DateFormat("d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} $storageJam $storageNoHP",
                                                                        status:
                                                                            "Servis cancel",
                                                                      );
                                                                      FirebaseService(
                                                                              FirebaseAuth.instance)
                                                                          .deleteJadwalServisToFirebase(
                                                                        title:
                                                                            "${DateFormat("d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} $storageJam $storageNoHP",
                                                                      );
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        "Yes"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            }),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox()
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
                                        actions: const <Widget>[],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 160,
                                  color: Colors.green,
                                  child: Image.network(storageGambarUrl,
                                      fit: BoxFit.cover),
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
