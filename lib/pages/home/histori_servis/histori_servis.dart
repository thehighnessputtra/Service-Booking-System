import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class HistoriServis extends StatelessWidget {
  const HistoriServis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Histori Servis"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("selesaiServis")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index];
                  final storageTanggal = data.get("tanggal");
                  final storageJam = data.get("jam");
                  final storageNama = data.get("nama");
                  final storageJenisServis = data.get("jenisServis");
                  final storageTipeMotor = data.get("tipeMotor");
                  final storageStatus = data.get("status");
                  // if (storageStatus == "Servis selesai") {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 2, child: Text("Status")),
                          const Text(": "),
                          Expanded(flex: 5, child: Text("$storageStatus")),
                        ],
                      ),
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
                      Row(
                        children: [
                          const Expanded(flex: 2, child: Text("Nama")),
                          const Text(": "),
                          Expanded(flex: 5, child: Text(storageNama)),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 2, child: Text("Tipe Motor")),
                          const Text(": "),
                          Expanded(flex: 5, child: Text(storageTipeMotor)),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 2, child: Text("Jenis Servis")),
                          const Text(": "),
                          Expanded(flex: 5, child: Text(storageJenisServis)),
                        ],
                      ),
                    ],
                  );
                  // }
                  // return SizedBox();
                },
              );
            }
            return SizedBox();
          }),
    );
  }
}
