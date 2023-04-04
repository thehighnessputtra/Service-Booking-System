import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          stream: FirebaseFirestore.instance
              .collection('logBooking')
              .orderBy("tanggal", descending: true)
              .snapshots(),
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
          Timestamp storageTanggal = itemsList["tanggal"];
          String storageJam = itemsList["jam"];
          String storageNama = itemsList["nama"];
          int storageNoHP = itemsList["noHp"];
          String storageTipeMotor = itemsList["tipeMotor"];
          String storageNoPolisi = itemsList["noPolisi"];
          String storageJenisServis = itemsList["jenisServis"];
          String storageJumlahKm = itemsList["jumlahKm"];
          String storageStatus = itemsList["status"];
          String storageUpdateBy = itemsList["updateBy"];
          String storageGambarUrl = itemsList["gambarUrl"];
          String storageRating = itemsList["rating"];
          String storageKomentar = itemsList["komentar"];

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
                              const Text(": "),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                      "${DateFormat("EEEE, d-MMMM-y", "ID").format(DateTime.parse(storageTanggal.toDate().toString()))} / $storageJam")),
                            ],
                          ),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("Nama")),
                                    const Text(": "),
                                    Expanded(flex: 5, child: Text(storageNama)),
                                  ],
                                )
                              : const SizedBox(),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("No HP")),
                                    const Text(": "),
                                    Expanded(
                                        flex: 5, child: Text("0$storageNoHP")),
                                  ],
                                )
                              : const SizedBox(),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text("Tipe Motor")),
                              const Text(": "),
                              Expanded(flex: 5, child: Text(storageTipeMotor)),
                            ],
                          ),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("No Polisi")),
                                    const Text(": "),
                                    Expanded(
                                        flex: 5, child: Text(storageNoPolisi)),
                                  ],
                                )
                              : const SizedBox(),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text("Jenis Servis")),
                              const Text(": "),
                              Expanded(
                                  flex: 5, child: Text(storageJenisServis)),
                            ],
                          ),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("Jumlah Km")),
                                    const Text(": "),
                                    Expanded(
                                        flex: 5, child: Text(storageJumlahKm)),
                                  ],
                                )
                              : const SizedBox(),
                          Row(
                            children: [
                              const Expanded(flex: 2, child: Text("Rating")),
                              const Text(": "),
                              Expanded(flex: 5, child: Text(storageRating)),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(flex: 2, child: Text("Komentar")),
                              const Text(": "),
                              Expanded(flex: 5, child: Text(storageKomentar)),
                            ],
                          ),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("Status")),
                                    const Text(": "),
                                    Expanded(
                                        flex: 5, child: Text(storageStatus)),
                                  ],
                                )
                              : const SizedBox(),
                          role == "Admin"
                              ? Row(
                                  children: [
                                    const Expanded(
                                        flex: 2, child: Text("Update by")),
                                    const Text(": "),
                                    Expanded(
                                        flex: 5, child: Text(storageUpdateBy)),
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
