import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/servies/firebase_service.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/custom_notification.dart';
import 'package:service_booking_system/widget/custom_textformfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  String? fotoUrl;
  String fotoNama = "Masukan Gambar Motor";
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
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      dialogInfoWithoutDelay(context,
          "Pastikan sebelum booking sudah melihat List booking dan Jadwal servis. Serta mengajukan Tanggal dan Jam yang berbeda untuk menghindari PENOLAKAN Booking!");
    });

    super.initState();
  }

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
                  hint: fotoNama,
                  readOnly: true,
                  formNama: "Gambar Motor",
                  onTap: () {
                    uploadImage();
                  },
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
                                                      ": ${controllerJumlahKM.text} Km")),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          CustomTextFormField(
                                            hint: fotoNama,
                                            readOnly: true,
                                            onTap: () async {
                                              if (fotoUrl != null) {
                                                final Uri url =
                                                    Uri.parse(fotoUrl!);
                                                if (!await launchUrl(url,
                                                    mode: LaunchMode
                                                        .externalApplication)) {
                                                  throw "Could not launch $url";
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Belum memasukan gambar!")));
                                              }
                                            },
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
                                                    FirebaseService(FirebaseAuth
                                                            .instance)
                                                        .postListBookingToFirestore(
                                                            gambarNama:
                                                                fotoNama,
                                                            gambarUrl: fotoUrl!,
                                                            tnglJam:
                                                                "${DateFormat("d-MMMM-y", "ID").format(selectedDate)} $valueJamKerja",
                                                            jenisServis:
                                                                valueJenisServis,
                                                            jumlahKm:
                                                                controllerJumlahKM
                                                                    .text,
                                                            nama: controllerNama
                                                                .text,
                                                            noHp: controllerNoHP
                                                                .text,
                                                            noPolisi:
                                                                controllerNoPolisi
                                                                    .text,
                                                            tipeMotor:
                                                                controllerTipeMotor
                                                                    .text);
                                                  }

                                                  dialogInfo(context,
                                                      "Berhasil booking!", 3);
                                                  Future.delayed(
                                                      Duration(seconds: 3), () {
                                                    Navigator.pop(context);
                                                  });
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

  uploadImage() async {
    if (controllerNoHP.text.isEmpty) {
      dialogInfoWithoutDelay(
          context, "Silahkan isi No. Handphone terlebih dahulu");
    } else {
      final result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.any);
      if (result != null) {
        final path = result.files.single.path!;
        final fileName = result.files.single.name;

        FirebaseStorage storage = FirebaseStorage.instance;
        await storage
            .ref('users/${controllerNoHP.text}/$fileName')
            .putFile(File(path));
        String getDownloadUrl = await storage
            .ref('users/${controllerNoHP.text}/$fileName')
            .getDownloadURL();
        // print("DOWNLOAD AVATAR = $getDownloadUrl");
        setState(() {
          fotoNama = fileName;
          fotoUrl = getDownloadUrl;
        });

        // ignore: use_build_context_synchronously
        dialogInfo(context, "Foto sukses diupload!", 2);
      } else {
        dialogInfo(context, "Foto gagal diupload!", 2);
      }
    }
  }
}
