import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/custom_text.dart';
import 'package:service_booking_system/widget/custom_textformfield.dart';

// class BookingPage extends StatefulWidget {
//   const BookingPage({super.key});

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   TextEditingController controllerNama = TextEditingController();
//   TextEditingController controllerNoHP = TextEditingController();
//   TextEditingController controllerTipeMotor = TextEditingController();
//   TextEditingController controllerNoPolisi = TextEditingController();
//   TextEditingController controllerJumlahKM = TextEditingController();
//   TextEditingController controllerJenisServis = TextEditingController();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   DateTime selectedDate = DateTime.now();
//   int calcDate = DateTime.now().millisecondsSinceEpoch + 86400000;

//   List listJenisServis = ["Servis Ringan", "Servis Besar"];
//   String valueJenisServis = "";
//   String valueJamKerja = "";
//   List listJamKerja = [
//     "08.00 WIB",
//     "09.00 WIB",
//     "10.00 WIB",
//     "11.00 WIB",
//     "13.00 WIB",
//     "14.00 WIB",
//     "15.00 WIB",
//     "16.00 WIB",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Booking"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         child: Form(
//           key: _formKey,
//           // autovalidateMode: AutovalidateMode.always,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 20.0,
//               ),
//               CustomTextFormField(
//                 hint: DateFormat("EEEE, d-MMMM-y", "ID").format(selectedDate),
//                 formNama: "Tanggal",
//                 validasi: (value) {
//                   if (DateFormat("EEEE, d-MMMM-y", "ID").format(selectedDate) ==
//                       DateFormat("EEEE, d-MMMM-y", "ID")
//                           .format(DateTime.now())) {
//                     return "Untuk booking minimal H+1";
//                   }
//                 },
//                 readOnly: true,
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.fromMillisecondsSinceEpoch(calcDate),
//                     locale: const Locale("in", "ID"),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2040),
//                   );
//                   setState(() {
//                     selectedDate = pickedDate!;
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: "Jam Servis",
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                 ),
//                 isExpanded: true,
//                 hint: Text(valueJamKerja),
//                 validator: (value) {
//                   if (valueJamKerja == "") {
//                     return 'Jam Servis tidak boleh kosong!';
//                   }
//                 },
//                 elevation: 0,
//                 borderRadius: BorderRadius.circular(12),
//                 onChanged: (value) {
//                   setState(() {
//                     valueJamKerja = value!;
//                   });
//                 },
//                 items: listJamKerja
//                     .map<DropdownMenuItem<String>>(
//                       (e) => DropdownMenuItem(
//                         value: e,
//                         child: Text(e),
//                       ),
//                     )
//                     .toList(),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               CustomTextFormField(
//                 formNama: "Nama",
//                 controller: controllerNama,
//                 validasi: (value) {
//                   if (value!.isEmpty) {
//                     return "Nama tidak boleh kosong!";
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               CustomTextFormField(
//                 formNama: "No Handphone",
//                 hint: "08XXXXXXXXX",
//                 keyboardType: TextInputType.number,
//                 controller: controllerNoHP,
//                 validasi: (value) {
//                   if (value!.isEmpty) {
//                     return "No Handphone tidak boleh kosong!";
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               CustomTextFormField(
//                 formNama: "Tipe Motor",
//                 hint: "Yamaha Mio 125",
//                 controller: controllerTipeMotor,
//                 validasi: (value) {
//                   if (value!.isEmpty) {
//                     return "Tipe Motor tidak boleh kosong!";
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               CustomTextFormField(
//                 formNama: "No Polisi",
//                 hint: "B 4444 SR",
//                 controller: controllerNoPolisi,
//                 validasi: (value) {
//                   if (value!.isEmpty) {
//                     return "No Polisi tidak boleh kosong!";
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: "Jenis Servis",
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                 ),
//                 isExpanded: true,
//                 hint: Text(valueJenisServis),
//                 validator: (value) {
//                   if (valueJenisServis == "") {
//                     return 'Jenis Servis tidak boleh kosong';
//                   }
//                 },
//                 elevation: 0,
//                 borderRadius: BorderRadius.circular(12),
//                 onChanged: (value) {
//                   setState(() {
//                     valueJenisServis = value!;
//                   });
//                 },
//                 items: listJenisServis
//                     .map<DropdownMenuItem<String>>(
//                       (e) => DropdownMenuItem(
//                         value: e,
//                         child: Text(e),
//                       ),
//                     )
//                     .toList(),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               CustomTextFormField(
//                 formNama: "Jumlah KM",
//                 hint: "3000",
//                 keyboardType: TextInputType.number,
//                 controller: controllerJumlahKM,
//                 validasi: (value) {
//                   if (value!.isEmpty) {
//                     return "Jumlah Km tidak boleh kosong!";
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               CustomTextFormField(
//                 formNama: "Gambar Motor",
//                 hint: "Upload Gambar Motor",
//                 readOnly: true,
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomButton1(
//                       btnName: "KONFIRMASI",
//                       onPress: () async {
//                         if (_formKey.currentState!.validate()) {
//                           await showModalBottomSheet<void>(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return Container(
//                                 padding: const EdgeInsets.all(30.0),
//                                 child: Wrap(
//                                   children: [
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: <Widget>[
//                                           const Text(
//                                             "KONFIRMASI BOOKING",
//                                             style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20.0,
//                                           ),
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 flex: 1,
//                                                 child: Text(
//                                                   "Tgl/Jam",
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 3,
//                                                   child: Text(
//                                                       ": ${DateFormat("EEEE, d-MMMM-y", "ID").format(selectedDate)} / $valueJamKerja"))
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 flex: 1,
//                                                 child: Text(
//                                                   "Nama",
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 3,
//                                                   child: Text(
//                                                       ": ${controllerNama.text}"))
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 flex: 1,
//                                                 child: Text(
//                                                   "No HP",
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 3,
//                                                   child: Text(
//                                                       ": ${controllerNoHP.text}"))
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 flex: 1,
//                                                 child: Text(
//                                                   "Tipe Motor",
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 3,
//                                                   child: Text(
//                                                       ": ${controllerTipeMotor.text}"))
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 flex: 1,
//                                                 child: Text(
//                                                   "No Polisi",
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 3,
//                                                   child: Text(
//                                                       ": ${controllerNoPolisi.text}"))
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 flex: 1,
//                                                 child: Text(
//                                                   "Jenis Servis",
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 3,
//                                                   child: Text(
//                                                       ": $valueJenisServis"))
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 flex: 1,
//                                                 child: Text(
//                                                   "Jumlah Km",
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 3,
//                                                   child: Text(
//                                                       ": ${controllerJumlahKM.text} Km"))
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             height: 20.0,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             children: [
//                                               ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                   backgroundColor:
//                                                       Colors.grey[600],
//                                                 ),
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: const Text("No"),
//                                               ),
//                                               const SizedBox(
//                                                 width: 10.0,
//                                               ),
//                                               ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                   backgroundColor:
//                                                       Colors.blueGrey,
//                                                 ),
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                   FirebaseFirestore.instance
//                                                       .runTransaction(
//                                                           (transaction) async {
//                                                     CollectionReference
//                                                         reference =
//                                                         FirebaseFirestore
//                                                             .instance
//                                                             .collection(
//                                                                 "bookingList");
//                                                     await reference
//                                                         .doc(
//                                                             "${DateFormat("d-MMMM-y", "ID").format(selectedDate)}+$valueJamKerja")
//                                                         .set({
//                                                       "tanggal": DateFormat(
//                                                               "EEEE, d-MMMM-y",
//                                                               "ID")
//                                                           .format(selectedDate),
//                                                       "jam": valueJamKerja,
//                                                       "nama":
//                                                           controllerNama.text,
//                                                       "noHp":
//                                                           controllerNoHP.text,
//                                                       "tipeMotor":
//                                                           controllerTipeMotor
//                                                               .text,
//                                                       "noPolisi":
//                                                           controllerNoPolisi
//                                                               .text,
//                                                       "jenisServis":
//                                                           valueJenisServis,
//                                                       "jumlahKm":
//                                                           controllerJumlahKM
//                                                               .text,
//                                                       "gambarNama": "kosong",
//                                                       "gambarUrl": "kosong",
//                                                       "createTime": DateFormat(
//                                                               "EEEE, d-MMMM-y H:m:s",
//                                                               "ID")
//                                                           .format(
//                                                               DateTime.now())
//                                                     });
//                                                   });
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(SnackBar(
//                                                           content:
//                                                               Text("Sukses")));
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: const Text("Yes"),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           );
//                         }
//                       }),
//                   CustomButton2(
//                       btnName: "BATAL",
//                       onPress: () {
//                         Navigator.pop(context);
//                       }),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class TesterPage extends StatefulWidget {
  TesterPage({super.key});

  @override
  State<TesterPage> createState() => _TesterPageState();
}

class _TesterPageState extends State<TesterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking"),
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
  HasilBooking({super.key, required this.listHasilBooking});
  final List<DocumentSnapshot> listHasilBooking;
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerNoHP = TextEditingController();
  TextEditingController controllerTipeMotor = TextEditingController();
  TextEditingController controllerNoPolisi = TextEditingController();
  TextEditingController controllerJumlahKM = TextEditingController();
  TextEditingController controllerJenisServis = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  int calcDate = DateTime.now().millisecondsSinceEpoch + 86400000;

  List listJenisServis = ["Servis Ringan", "Servis Besar"];
  String valueJenisServis = "";
  String valueJamKerja = "";
  List listJamKerja = [
    "08.00 WIB",
    "09.00 WIB",
    "10.00 WIB",
    "11.00 WIB",
    "13.00 WIB",
    "14.00 WIB",
    "15.00 WIB",
    "16.00 WIB",
  ];

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

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Form(
            key: widget._formKey,
            // autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  hint: DateFormat("EEEE, d-MMMM-y", "ID")
                      .format(widget.selectedDate),
                  formNama: "Tanggal",
                  validasi: (value) {
                    if (DateFormat("EEEE, d-MMMM-y", "ID")
                            .format(widget.selectedDate) ==
                        DateFormat("EEEE, d-MMMM-y", "ID")
                            .format(DateTime.now())) {
                      return "Untuk booking minimal H+1";
                    }
                  },
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.fromMillisecondsSinceEpoch(widget.calcDate),
                      locale: const Locale("in", "ID"),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2040),
                    );
                    setState(() {
                      widget.selectedDate = pickedDate!;
                    });
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Jam Servis",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  isExpanded: true,
                  hint: Text(widget.valueJamKerja),
                  validator: (value) {
                    if (widget.valueJamKerja == "") {
                      return 'Jam Servis tidak boleh kosong!';
                    }
                  },
                  elevation: 0,
                  borderRadius: BorderRadius.circular(12),
                  onChanged: (value) {
                    setState(() {
                      widget.valueJamKerja = value!;
                    });
                  },
                  items: widget.listJamKerja
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  formNama: "Nama",
                  controller: widget.controllerNama,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "Nama tidak boleh kosong!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  formNama: "No Handphone",
                  hint: "08XXXXXXXXX",
                  keyboardType: TextInputType.number,
                  controller: widget.controllerNoHP,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "No Handphone tidak boleh kosong!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  formNama: "Tipe Motor",
                  hint: "Yamaha Mio 125",
                  controller: widget.controllerTipeMotor,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "Tipe Motor tidak boleh kosong!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  formNama: "No Polisi",
                  hint: "B 4444 SR",
                  controller: widget.controllerNoPolisi,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "No Polisi tidak boleh kosong!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Jenis Servis",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  isExpanded: true,
                  hint: Text(widget.valueJenisServis),
                  validator: (value) {
                    if (widget.valueJenisServis == "") {
                      return 'Jenis Servis tidak boleh kosong';
                    }
                  },
                  elevation: 0,
                  borderRadius: BorderRadius.circular(12),
                  onChanged: (value) {
                    setState(() {
                      widget.valueJenisServis = value!;
                    });
                  },
                  items: widget.listJenisServis
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  formNama: "Jumlah KM",
                  hint: "3000",
                  keyboardType: TextInputType.number,
                  controller: widget.controllerJumlahKM,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "Jumlah Km tidak boleh kosong!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  formNama: "Gambar Motor",
                  hint: "Upload Gambar Motor",
                  readOnly: true,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton1(
                        btnName: "KONFIRMASI",
                        onPress: () async {
                          if (widget._formKey.currentState!.validate()) {
                            await showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Wrap(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            const Text(
                                              "KONFIRMASI BOOKING",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Tgl/Jam",
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        ": ${DateFormat("EEEE, d-MMMM-y", "ID").format(widget.selectedDate)} / ${widget.valueJamKerja}"))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Nama",
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        ": ${widget.controllerNama.text}"))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "No HP",
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        ": ${widget.controllerNoHP.text}"))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Tipe Motor",
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        ": ${widget.controllerTipeMotor.text}"))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "No Polisi",
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        ": ${widget.controllerNoPolisi.text}"))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Jenis Servis",
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        ": ${widget.valueJenisServis}"))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Jumlah Km",
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        ": ${widget.controllerJumlahKM.text} Km"))
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.grey[600],
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No"),
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blueGrey,
                                                  ),
                                                  onPressed: () {
                                                    if (DateFormat(
                                                                "EEEE, d-MMMM-y",
                                                                "ID")
                                                            .format(widget
                                                                .selectedDate) ==
                                                        storageTanggal) {
                                                      print("EROR");
                                                    } else {
                                                      FirebaseFirestore.instance
                                                          .runTransaction(
                                                              (transaction) async {
                                                        CollectionReference
                                                            reference =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "bookingList");
                                                        await reference
                                                            .doc(
                                                                "${DateFormat("d-MMMM-y", "ID").format(widget.selectedDate)}+${widget.valueJamKerja}")
                                                            .set({
                                                          "tanggal": DateFormat(
                                                                  "EEEE, d-MMMM-y",
                                                                  "ID")
                                                              .format(widget
                                                                  .selectedDate),
                                                          "jam": widget
                                                              .valueJamKerja,
                                                          "nama": widget
                                                              .controllerNama
                                                              .text,
                                                          "noHp": widget
                                                              .controllerNoHP
                                                              .text,
                                                          "tipeMotor": widget
                                                              .controllerTipeMotor
                                                              .text,
                                                          "noPolisi": widget
                                                              .controllerNoPolisi
                                                              .text,
                                                          "jenisServis": widget
                                                              .valueJenisServis,
                                                          "jumlahKm": widget
                                                              .controllerJumlahKM
                                                              .text,
                                                          "gambarNama":
                                                              "kosong",
                                                          "gambarUrl": "kosong",
                                                          "createTime": DateFormat(
                                                                  "EEEE, d-MMMM-y H:m:s",
                                                                  "ID")
                                                              .format(DateTime
                                                                  .now())
                                                        });
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Sukses")));
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text("Yes"),
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
                          }
                        }),
                    CustomButton2(
                        btnName: "BATAL",
                        onPress: () {
                          Navigator.pop(context);
                        }),
                  ],
                )
              ],
            ),
          ),
        );
        // Column(
        // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        // children: [
        //   Row(
        //     children: [
        //       Expanded(
        //         flex: 5,
        //         child: Column(
        //           children: [
        //             Row(
        //               children: [
        //                 const Expanded(flex: 2, child: Text("Tgl/Jam")),
        //                 Expanded(
        //                     flex: 5,
        //                     child: Text(": $storageTanggal/$storageJam")),
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 const Expanded(flex: 2, child: Text("Nama")),
        //                 Expanded(flex: 5, child: Text(": $storageNama")),
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 const Expanded(flex: 2, child: Text("No HP")),
        //                 Expanded(flex: 5, child: Text(": $storageNoHP")),
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 const Expanded(flex: 2, child: Text("Tipe Motor")),
        //                 Expanded(
        //                     flex: 5, child: Text(": $storageTipeMotor")),
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 const Expanded(flex: 2, child: Text("No Polisi")),
        //                 Expanded(
        //                     flex: 5, child: Text(": $storageNoPolisi")),
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 const Expanded(
        //                     flex: 2, child: Text("Jenis Servis")),
        //                 Expanded(
        //                     flex: 5, child: Text(": $storageJenisServis")),
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 const Expanded(flex: 2, child: Text("Jumlah Km")),
        //                 Expanded(
        //                     flex: 5, child: Text(": $storageJumlahKm")),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       Expanded(
        //         flex: 2,
        //         child: GestureDetector(
        //           onTap: () async {
        //             await showModalBottomSheet<void>(
        //               context: context,
        //               builder: (BuildContext context) {
        //                 return Container(
        //                   padding: const EdgeInsets.all(20.0),
        //                   child: Wrap(
        //                     children: [
        //                       SizedBox(
        //                         width: MediaQuery.of(context).size.width,
        //                         child: Column(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.center,
        //                           children: <Widget>[
        //                             const Text('Foto Motor'),
        //                             const SizedBox(
        //                               height: 20.0,
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 );
        //               },
        //             );
        //           },
        //           child: Container(
        //             height: 125,
        //             color: Colors.green,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        //   const Divider(
        //     color: Colors.black45,
        //   ),
        // ]);
      },
    );
  }
}
