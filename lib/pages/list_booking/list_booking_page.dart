// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/pages/list_booking/histori_servis.dart';
import 'package:service_booking_system/pages/list_booking/log_booking_page.dart';
import 'package:service_booking_system/servies/firebase_service.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/transition_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BookedPage extends StatefulWidget {
  const BookedPage({super.key});

  @override
  State<BookedPage> createState() => _BookedPageState();
}

class _BookedPageState extends State<BookedPage> {
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
        title: const Text("List Booking"),
        actions: [
          IconButton(
              onPressed: () {
                role == "Admin"
                    ? navPushTransition(context, LogBookingPage())
                    : navPushTransition(context, HistoriServis());
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('listBooking')
              .orderBy('tanggal')
              .snapshots(),
          builder: (context, snapshot1) {
            if (snapshot1.hasData) {
              return HasilBooking(
                listHasilBooking: snapshot1.data!.docs,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class HasilBooking extends StatefulWidget {
  const HasilBooking({super.key, required this.listHasilBooking});
  final List<DocumentSnapshot> listHasilBooking;

  @override
  State<HasilBooking> createState() => _HasilBookingState();
}

class _HasilBookingState extends State<HasilBooking> {
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
          String storageJam = itemsList["jam"];
          Timestamp storageTanggal = itemsList["tanggal"];
          String storageNama = itemsList["nama"];
          int storageNoHP = itemsList["noHp"];
          String storageTipeMotor = itemsList["tipeMotor"];
          String storageNoPolisi = itemsList["noPolisi"];
          String storageJenisServis = itemsList["jenisServis"];
          String storageJumlahKm = itemsList["jumlahKm"];
          String storageGambarNama = itemsList["gambarNama"];
          String storageGambarUrl = itemsList["gambarUrl"];
          String storageCreateTime = itemsList["createTime"];
          String storageStatus = itemsList["status"];

          // return
          // StreamBuilder(
          //   stream:
          //       FirebaseFirestore.instance.collection('timeServices').snapshots(),
          //   builder: (context, snapshot2) {
          //     if (snapshot2.hasData) {
          //       int dataMontir = snapshot2.data!.docs[0]["montir"];
          //       int dataJam8 = snapshot2.data!.docs[0]["jam8"];
          //       int dataJam9 = snapshot2.data!.docs[0]["jam9"];
          //       int dataJam10 = snapshot2.data!.docs[0]["jam10"];
          //       int dataJam11 = snapshot2.data!.docs[0]["jam11"];
          //       int dataJam13 = snapshot2.data!.docs[0]["jam13"];
          //       int dataJam14 = snapshot2.data!.docs[0]["jam14"];
          //       int dataJam15 = snapshot2.data!.docs[0]["jam15"];
          //       int dataJam16 = snapshot2.data!.docs[0]["jam16"];
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
                                        flex: 2, child: Text("Dibuat")),
                                    Expanded(
                                        flex: 5,
                                        child: Text(": $storageCreateTime")),
                                  ],
                                )
                              : const SizedBox(),
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
                                    CustomButton1(
                                        btnName: "Terima",
                                        onPress: () async {
                                          await showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(30.0),
                                                child: Wrap(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          const Text(
                                                            "KONFIRMASI BOOKING",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          Text(
                                                            'Terima Bookingan dari $storageNama dengan no. $storageNoHP?',
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
                                                                      Colors.grey[
                                                                          600],
                                                                ),
                                                                onPressed: () {
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
                                                                    () async {
                                                                  await showDialog<
                                                                      void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        title: const Text(
                                                                            'Info'),
                                                                        content:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              ListBody(
                                                                            children: <Widget>[
                                                                              const Text('Silahkan hubungi costumer melalui WA'),
                                                                              CustomButton1(
                                                                                  btnName: "Chat WA",
                                                                                  onPress: () async {
                                                                                    if (storageNoHP != null) {
                                                                                      final Uri url = Uri.parse("https://api.whatsapp.com/send?phone=62$storageNoHP&text=Halo%20$storageNama%2C%20booking%20kamu%20sudah%20kami%20terima.%20Silahkan%20cek%20Jadwal%20Servis%20pada%20aplikasi!");
                                                                                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                                                                        throw "Could not launch $url";
                                                                                      }
                                                                                    } else {
                                                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Could not launch URL!")));
                                                                                    }
                                                                                  })
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                  FirebaseService(FirebaseAuth.instance).postJadwalServisToFirestore(
                                                                      emailAdmin:
                                                                          email!,
                                                                      gambarNama:
                                                                          storageGambarNama,
                                                                      gambarUrl:
                                                                          storageGambarUrl,
                                                                      jenisServis:
                                                                          storageJenisServis,
                                                                      jumlahKm:
                                                                          storageJumlahKm,
                                                                      nama:
                                                                          storageNama,
                                                                      noHp:
                                                                          storageNoHP,
                                                                      noPolisi:
                                                                          storageNoPolisi,
                                                                      jam:
                                                                          storageJam,
                                                                      title:
                                                                          "${DateFormat("d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} $storageJam $storageNoHP",
                                                                      tanggal: DateTime.parse(storageTanggal
                                                                          .toDate()
                                                                          .toString()),
                                                                      tipeMotor:
                                                                          storageTipeMotor);
                                                                  Future.delayed(
                                                                      const Duration(
                                                                          seconds:
                                                                              1),
                                                                      () {
                                                                    FirebaseService(
                                                                            FirebaseAuth.instance)
                                                                        .postLogBookingToFireStore(
                                                                      jam:
                                                                          storageJam,
                                                                      tanggal: DateTime.parse(storageTanggal
                                                                          .toDate()
                                                                          .toString()),
                                                                      title:
                                                                          "${DateFormat("d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} $storageJam $storageNoHP",
                                                                      emailAdmin:
                                                                          email!,
                                                                      gambarNama:
                                                                          storageGambarNama,
                                                                      gambarUrl:
                                                                          storageGambarUrl,
                                                                      jenisServis:
                                                                          storageJenisServis,
                                                                      jumlahKm:
                                                                          storageJumlahKm,
                                                                      nama:
                                                                          storageNama,
                                                                      status:
                                                                          "Servis diterima",
                                                                      noHp:
                                                                          storageNoHP,
                                                                      noPolisi:
                                                                          storageNoPolisi,
                                                                      tipeMotor:
                                                                          storageTipeMotor,
                                                                    );
                                                                    // FirebaseService(FirebaseAuth.instance).updateTimeServices(
                                                                    //     jam: storageJam == "08.00 WIB"
                                                                    //         ? "jam8"
                                                                    //         : storageJam == "09.00 WIB"
                                                                    //             ? "jam9"
                                                                    //             : storageJam == "10.00 WIB"
                                                                    //                 ? "jam10"
                                                                    //                 : storageJam == "11.00 WIB"
                                                                    //                     ? "jam11"
                                                                    //                     : storageJam == "13.00 WIB"
                                                                    //                         ? "jam13"
                                                                    //                         : storageJam == "14.00 WIB"
                                                                    //                             ? "jam14"
                                                                    //                             : storageJam == "15.00 WIB"
                                                                    //                                 ? "jam15"
                                                                    //                                 : storageJam == "16.00 WIB"
                                                                    //                                     ? "jam16"
                                                                    //                                     : "error",
                                                                    //     hitungJam: storageJam == "08.00 WIB"
                                                                    //         ? dataJam8 - 1
                                                                    //         : storageJam == "09.00 WIB"
                                                                    //             ? dataJam9 - 1
                                                                    //             : storageJam == "10.00 WIB"
                                                                    //                 ? dataJam10 - 1
                                                                    //                 : storageJam == "11.00 WIB"
                                                                    //                     ? dataJam11 - 1
                                                                    //                     : storageJam == "13.00 WIB"
                                                                    //                         ? dataJam13 - 1
                                                                    //                         : storageJam == "14.00 WIB"
                                                                    //                             ? dataJam14 - 1
                                                                    //                             : storageJam == "15.00 WIB"
                                                                    //                                 ? dataJam15 - 1
                                                                    //                                 : storageJam == "16.00 WIB"
                                                                    //                                     ? dataJam16 - 1
                                                                    //                                     : 404,
                                                                    //     hitungMontir: dataMontir - 1);
                                                                    FirebaseService(FirebaseAuth
                                                                            .instance)
                                                                        .deleteListBookingToFirebase(
                                                                            title:
                                                                                "${DateFormat("d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} $storageJam $storageNoHP");
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
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
                                      width: 10.0,
                                    ),
                                    CustomButton2(
                                        btnName: "Tolak",
                                        onPress: () async {
                                          await showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(30.0),
                                                child: Wrap(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          const Text(
                                                            "KONFIRMASI BOOKING",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          Text(
                                                            'Tolak Bookingan dari $storageNama dengan no. $storageNoHP?',
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
                                                                      Colors.grey[
                                                                          600],
                                                                ),
                                                                onPressed: () {
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
                                                                    () async {
                                                                  await showDialog<
                                                                      void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        title: const Text(
                                                                            'Info'),
                                                                        content:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              ListBody(
                                                                            children: <Widget>[
                                                                              const Text('Silahkan hubungi costumer melalui WA'),
                                                                              CustomButton1(
                                                                                  btnName: "Chat WA",
                                                                                  onPress: () async {
                                                                                    if (storageNoHP != null) {
                                                                                      final Uri url = Uri.parse("https://api.whatsapp.com/send?phone=62$storageNoHP&text=Halo%20$storageNama%2C%20mohon%20maaf%20booking%20kamu%20sudah%20kami%20tolak%20karena%20jadwal%20kamu%20berbentrokan%20atau%20montir%20sedang%20tidak%20tersedia.");
                                                                                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                                                                        throw "Could not launch $url";
                                                                                      }
                                                                                    } else {
                                                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Could not launch URL!")));
                                                                                    }
                                                                                  })
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );

                                                                  Future.delayed(
                                                                      const Duration(
                                                                          seconds:
                                                                              1),
                                                                      () {
                                                                    FirebaseService(
                                                                            FirebaseAuth.instance)
                                                                        .postLogBookingToFireStore(
                                                                      jam:
                                                                          storageJam,
                                                                      tanggal: DateTime.parse(storageTanggal
                                                                          .toDate()
                                                                          .toString()),
                                                                      title:
                                                                          "${DateFormat("d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} $storageJam $storageNoHP",
                                                                      emailAdmin:
                                                                          email!,
                                                                      gambarNama:
                                                                          storageGambarNama,
                                                                      gambarUrl:
                                                                          storageGambarUrl,
                                                                      jenisServis:
                                                                          storageJenisServis,
                                                                      jumlahKm:
                                                                          storageJumlahKm,
                                                                      nama:
                                                                          storageNama,
                                                                      status:
                                                                          "Servis ditolak",
                                                                      noHp:
                                                                          storageNoHP,
                                                                      noPolisi:
                                                                          storageNoPolisi,
                                                                      tipeMotor:
                                                                          storageTipeMotor,
                                                                    );

                                                                    FirebaseService(FirebaseAuth
                                                                            .instance)
                                                                        .deleteListBookingToFirebase(
                                                                            title:
                                                                                "${DateFormat("d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} $storageJam $storageNoHP");
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
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
                                      width: 20.0,
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
                                  height: role == "Admin" ? 160 : 125,
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
//         );
//       },
//     );
//   }
// }
