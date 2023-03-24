import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/custom_text.dart';
import 'package:service_booking_system/widget/custom_textformfield.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Booking"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  hint: DateFormat("EEEE, d-MMMM-y", "ID").format(selectedDate),
                  formNama: "Tanggal",
                  validasi: (value) {
                    if (DateFormat("EEEE, d-MMMM-y", "ID")
                            .format(selectedDate) ==
                        DateFormat("EEEE, d-MMMM-y", "ID")
                            .format(DateTime.now())) {
                      return "Untuk booking minimal H+1";
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.fromMillisecondsSinceEpoch(calcDate),
                      locale: const Locale("in", "ID"),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2040),
                    );
                    setState(() {
                      selectedDate = pickedDate!;
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
                  hint: Text(valueJamKerja),
                  validator: (value) {
                    if (valueJamKerja == "") {
                      return 'Jam Servis tidak boleh kosong!';
                    }
                    return null;
                  },
                  elevation: 0,
                  borderRadius: BorderRadius.circular(12),
                  onChanged: (value) {
                    setState(() {
                      valueJamKerja = value!;
                    });
                  },
                  items: listJamKerja
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
                  controller: controllerNama,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "Nama tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  formNama: "No Handphone",
                  hint: "08XXXXXXXXX",
                  keyboardType: TextInputType.number,
                  controller: controllerNoHP,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "No Handphone tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  formNama: "Tipe Motor",
                  hint: "Yamaha Mio 125",
                  controller: controllerTipeMotor,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "Tipe Motor tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  formNama: "No Polisi",
                  hint: "B 4444 SR",
                  controller: controllerNoPolisi,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "No Polisi tidak boleh kosong!";
                    }
                    return null;
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
                  hint: Text(valueJenisServis),
                  validator: (value) {
                    if (valueJenisServis == "") {
                      return 'Jenis Servis tidak boleh kosong';
                    }
                    return null;
                  },
                  elevation: 0,
                  borderRadius: BorderRadius.circular(12),
                  onChanged: (value) {
                    setState(() {
                      valueJenisServis = value!;
                    });
                  },
                  items: listJenisServis
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
                  controller: controllerJumlahKM,
                  validasi: (value) {
                    if (value!.isEmpty) {
                      return "Jumlah Km tidak boleh kosong!";
                    }
                    return null;
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
                          // if (_formKey.currentState!.validate()) {
                          await showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(30.0),
                                child: Wrap(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
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
                                                      ": ${DateFormat("EEEE, d-MMMM-y", "ID").format(selectedDate)} / ${valueJamKerja}"))
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
                                                      ": ${controllerNama.text}"))
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
                                                      ": ${controllerNoHP.text}"))
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
                                                      ": ${controllerTipeMotor.text}"))
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
                                                      ": ${controllerNoPolisi.text}"))
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
                                                      ": ${valueJenisServis}"))
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
                                                      ": ${controllerJumlahKM.text} Km"))
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
                                                style: ElevatedButton.styleFrom(
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
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.blueGrey,
                                                ),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
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
                                                              "${DateFormat("d-MMMM-y", "ID").format(selectedDate)}+${valueJamKerja}")
                                                          .set({
                                                        "tanggal+jam":
                                                            "${DateFormat("EEEE, d-MMMM-y", "ID").format(selectedDate)}/${valueJamKerja}",
                                                        "nama":
                                                            controllerNama.text,
                                                        "noHp":
                                                            controllerNoHP.text,
                                                        "tipeMotor":
                                                            controllerTipeMotor
                                                                .text,
                                                        "noPolisi":
                                                            controllerNoPolisi
                                                                .text,
                                                        "jenisServis":
                                                            valueJenisServis,
                                                        "jumlahKm":
                                                            controllerJumlahKM
                                                                .text,
                                                        "gambarNama": "kosong",
                                                        "gambarUrl": "kosong",
                                                        "createTime": DateFormat(
                                                                "EEEE, d-MMMM-y H:m:s",
                                                                "ID")
                                                            .format(
                                                                DateTime.now())
                                                      });
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "Sukses")));
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                // },
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
                          // }
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
        ));
  }
}
