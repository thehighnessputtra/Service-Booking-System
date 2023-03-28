import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_booking_system/pages/log_booking_page.dart';
import 'package:service_booking_system/servies/firebase_service.dart';
import 'package:service_booking_system/widget/custom_button.dart';
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
          role == "Admin"
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogBookingPage()),
                    );
                  },
                  icon: Icon(Icons.history))
              : SizedBox(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('listBooking').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HasilBooking(
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
        String storageTanggal = itemsList["tanggal+jam"];
        String storageNama = itemsList["nama"];
        String storageNoHP = itemsList["noHp"];
        String storageTipeMotor = itemsList["tipeMotor"];
        String storageNoPolisi = itemsList["noPolisi"];
        String storageJenisServis = itemsList["jenisServis"];
        String storageJumlahKm = itemsList["jumlahKm"];
        String storageGambarNama = itemsList["gambarNama"];
        String storageGambarUrl = itemsList["gambarUrl"];
        String storageCreateTime = itemsList["createTime"];

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
                            Expanded(flex: 5, child: Text(": $storageTanggal")),
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
                                  const Expanded(flex: 2, child: Text("No HP")),
                                  Expanded(
                                      flex: 5, child: Text(": $storageNoHP")),
                                ],
                              )
                            : const SizedBox(),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Tipe Motor")),
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
                                flex: 5, child: Text(": $storageJenisServis")),
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
                            const Expanded(flex: 5, child: Text(": Menunggu")),
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
                                                          "Confirm",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        600],
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "No"),
                                                            ),
                                                            const SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            ElevatedButton(
                                                              style:
                                                                  ElevatedButton
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
                                                                          children: <
                                                                              Widget>[
                                                                            const Text('Silahkan hubungi costumer melalui WA'),
                                                                            CustomButton1(
                                                                                btnName: "Chat WA",
                                                                                onPress: () async {
                                                                                  if (storageNoHP != null) {
                                                                                    final Uri url = Uri.parse("https://wa.me/$storageNoHP");
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
                                                                FirebaseService(FirebaseAuth.instance).postFixedBookingToFirestore(
                                                                    accBy:
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
                                                                    tanggaljam:
                                                                        storageTanggal,
                                                                    tipeMotor:
                                                                        storageTipeMotor);
                                                                Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                    () {
                                                                  FirebaseService(
                                                                          FirebaseAuth
                                                                              .instance)
                                                                      .postLogBookingToFireStore(
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
                                                                        "DITERIMA $email",
                                                                    noHp:
                                                                        storageNoHP,
                                                                    noPolisi:
                                                                        storageNoPolisi,
                                                                    tipeMotor:
                                                                        storageTipeMotor,
                                                                    tnglJam:
                                                                        storageTanggal,
                                                                  );
                                                                  FirebaseService(
                                                                          FirebaseAuth
                                                                              .instance)
                                                                      .deleteListBookingToFirebase(
                                                                          tnglJam:
                                                                              storageTanggal,
                                                                          noHP:
                                                                              storageNoHP);
                                                                });
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
                                                          "Confirm",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        600],
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "No"),
                                                            ),
                                                            const SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            ElevatedButton(
                                                              style:
                                                                  ElevatedButton
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
                                                                          children: <
                                                                              Widget>[
                                                                            const Text('Silahkan hubungi costumer melalui WA'),
                                                                            CustomButton1(
                                                                                btnName: "Chat WA",
                                                                                onPress: () async {
                                                                                  if (storageNoHP != null) {
                                                                                    final Uri url = Uri.parse("https://wa.me/$storageNoHP");
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
                                                                          FirebaseAuth
                                                                              .instance)
                                                                      .postLogBookingToFireStore(
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
                                                                        "DITOLAK $email",
                                                                    noHp:
                                                                        storageNoHP,
                                                                    noPolisi:
                                                                        storageNoPolisi,
                                                                    tipeMotor:
                                                                        storageTipeMotor,
                                                                    tnglJam:
                                                                        storageTanggal,
                                                                  );
                                                                  FirebaseService(
                                                                          FirebaseAuth
                                                                              .instance)
                                                                      .deleteListBookingToFirebase(
                                                                          tnglJam:
                                                                              storageTanggal,
                                                                          noHP:
                                                                              storageNoHP);
                                                                });
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
                                      actions: <Widget>[],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                child: Image.network(storageGambarUrl,
                                    fit: BoxFit.cover),
                                height: role == "Admin" ? 160 : 125,
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
      },
    );
  }
}

// class BookedPage extends StatelessWidget {
//   const BookedPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("List Booking")),
//       body: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   flex: 5,
//                   child: Column(
//                     children: [
//                       Row(
//                         children: const [
//                           Expanded(flex: 2, child: Text("Tgl/Jam")),
//                           Expanded(flex: 5, child: Text(": Tanggal")),
//                         ],
//                       ),
//                       Row(
//                         children: const [
//                           Expanded(flex: 2, child: Text("Nama")),
//                           Expanded(flex: 5, child: Text(": Nama")),
//                         ],
//                       ),
//                       Row(
//                         children: const [
//                           Expanded(flex: 2, child: Text("No HP")),
//                           Expanded(flex: 5, child: Text(": No HP")),
//                         ],
//                       ),
//                       Row(
//                         children: const [
//                           Expanded(flex: 2, child: Text("Tipe Motor")),
//                           Expanded(flex: 5, child: Text(": Tipe Motor")),
//                         ],
//                       ),
//                       Row(
//                         children: const [
//                           Expanded(flex: 2, child: Text("No Polisi")),
//                           Expanded(flex: 5, child: Text(": No Polisi")),
//                         ],
//                       ),
//                       Row(
//                         children: const [
//                           Expanded(flex: 2, child: Text("Jenis Servis")),
//                           Expanded(flex: 5, child: Text(": No Polisi")),
//                         ],
//                       ),
//                       Row(
//                         children: const [
//                           Expanded(flex: 2, child: Text("Jumlah Km")),
//                           Expanded(flex: 5, child: Text(": No Polisi")),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: GestureDetector(
//                     onTap: () async {
//                       await showModalBottomSheet<void>(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Container(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Wrap(
//                               children: [
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       const Text('Foto Motor'),
//                                       const SizedBox(
//                                         height: 20.0,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: Container(
//                       height: 125,
//                       color: Colors.green,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             const Divider(
//               color: Colors.black45,
//             ),
//           ]),
//     );
//   }
// }
