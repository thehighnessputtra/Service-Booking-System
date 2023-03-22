import 'package:flutter/material.dart';

class BookedPage extends StatelessWidget {
  const BookedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Booking")),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Expanded(flex: 2, child: Text("Tgl/Jam")),
                          Expanded(flex: 5, child: Text(": Tanggal")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 2, child: Text("Nama")),
                          Expanded(flex: 5, child: Text(": Nama")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 2, child: Text("No HP")),
                          Expanded(flex: 5, child: Text(": No HP")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 2, child: Text("Tipe Motor")),
                          Expanded(flex: 5, child: Text(": Tipe Motor")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 2, child: Text("No Polisi")),
                          Expanded(flex: 5, child: Text(": No Polisi")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 2, child: Text("Jenis Servis")),
                          Expanded(flex: 5, child: Text(": No Polisi")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 2, child: Text("Jumlah Km")),
                          Expanded(flex: 5, child: Text(": No Polisi")),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
          ]),
    );
  }
}
