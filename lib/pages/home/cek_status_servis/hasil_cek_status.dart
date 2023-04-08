import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HasilCekStatusServis extends StatelessWidget {
  int? noHP;
  HasilCekStatusServis({super.key, required this.noHP});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("logBooking")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];
                      final dataNoHp = data.get("noHp");
                      final dataTanggal = data.get("tanggal");
                      final dataJam = data.get("jam");
                      final dataStatus = data.get("status");
                      final dataJenisServis = data.get("jenisServis");
                      final dataNama = data.get("nama");
                      final dataTipeMotor = data.get("tipeMotor");
                      if (noHP == dataNoHp) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(flex: 1, child: Text("Status")),
                                const Text(": "),
                                Expanded(flex: 3, child: Text(dataStatus))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(flex: 1, child: Text("Nama")),
                                const Text(": "),
                                Expanded(flex: 3, child: Text(dataNama))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 1, child: Text("No. Handphone")),
                                const Text(": "),
                                Expanded(flex: 3, child: Text("0$dataNoHp"))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(flex: 1, child: Text("Tgl/Jam")),
                                const Text(": "),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                        "${DateFormat("EEEE, d-MMMM-y", "ID").format(DateTime.parse(dataTanggal.toDate().toString()))} / $dataJam"))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 1, child: Text("Tipe Motor")),
                                const Text(": "),
                                Expanded(flex: 3, child: Text(dataTipeMotor))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 1, child: Text("Jenis Servis")),
                                const Text(": "),
                                Expanded(flex: 3, child: Text(dataJenisServis))
                              ],
                            ),
                            const Divider(
                              color: Colors.black54,
                            )
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
