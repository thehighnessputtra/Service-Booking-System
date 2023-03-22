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
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Expanded(flex: 1, child: Text("Tanggal")),
                          Expanded(flex: 3, child: Text(": Tanggal")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 1, child: Text("Nama")),
                          Expanded(flex: 3, child: Text(": Nama")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 1, child: Text("No HP")),
                          Expanded(flex: 3, child: Text(": No HP")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 1, child: Text("Tipe Motor")),
                          Expanded(flex: 3, child: Text(": Tipe Motor")),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 1, child: Text("No Polisi")),
                          Expanded(flex: 3, child: Text(": No Polisi")),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
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
                      height: 90,
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
