import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class BookedPage extends StatefulWidget {
  const BookedPage({super.key});

  @override
  State<BookedPage> createState() => _BookedPageState();
}

class _BookedPageState extends State<BookedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Booking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('bookingList').snapshots(),
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listHasilBooking.length,
      itemBuilder: (context, index) {
        final itemsList = widget.listHasilBooking[index];
        String storageTanggal = itemsList["tanggal"];
        String storageJam = itemsList["jam"];
        String storageNama = itemsList["nama"];
        String storageNoHP = itemsList["noHp"];
        String storageTipeMotor = itemsList["tipeMotor"];
        String storageNoPolisi = itemsList["noPolisi"];
        String storageJenisServis = itemsList["jenisServis"];
        String storageJumlahKm = itemsList["jumlahKm"];
        // String storageGambarNama = itemsList["gambarNama"];
        // String storageGambarUrl = itemsList["gambarUrl"];

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
                                child: Text(": $storageTanggal/$storageJam")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Nama")),
                            Expanded(flex: 5, child: Text(": $storageNama")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("No HP")),
                            Expanded(flex: 5, child: Text(": $storageNoHP")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Tipe Motor")),
                            Expanded(
                                flex: 5, child: Text(": $storageTipeMotor")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("No Polisi")),
                            Expanded(
                                flex: 5, child: Text(": $storageNoPolisi")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                                flex: 2, child: Text("Jenis Servis")),
                            Expanded(
                                flex: 5, child: Text(": $storageJenisServis")),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Jumlah Km")),
                            Expanded(
                                flex: 5, child: Text(": $storageJumlahKm")),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Wrap(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Text('Foto Motor'),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 125,
                        color: Colors.green,
                      ),
                    ),
                  )
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
