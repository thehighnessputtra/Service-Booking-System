import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/servies/firebase_service.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/custom_notification.dart';
import 'package:service_booking_system/widget/custom_textformfield.dart';

class BerikanReviewPage extends StatefulWidget {
  const BerikanReviewPage({super.key});

  @override
  State<BerikanReviewPage> createState() => _BerikanReviewPageState();
}

TextEditingController controllerNoHP = TextEditingController();
TextEditingController controllerKomentar = TextEditingController();
double ratingReview = 3.0;
DateTime selectedDate = DateTime.now();
int calcDate = DateTime.now().millisecondsSinceEpoch;
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

class _BerikanReviewPageState extends State<BerikanReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Berikan Review")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Text(
                  "Silahkan isi Form Review dengan cara memasukan form sesuai dengan form booking sebelumnya",
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                hint: DateFormat("EEEE, d-MMMM-y", "ID").format(selectedDate),
                formNama: "Tanggal",
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.fromMillisecondsSinceEpoch(calcDate),
                    locale: const Locale("in", "ID"),
                    firstDate: DateTime.utc(2022),
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
              SizedBox(
                height: 50,
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    labelStyle: TextStyle(color: Colors.black87),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
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
                height: 5.0,
              ),
              RatingBar.builder(
                initialRating: 3,
                glow: false,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    ratingReview = rating;
                  });
                },
              ),
              Text(ratingReview.toString()),
              const SizedBox(
                height: 5.0,
              ),
              CustomTextFormField(
                setHigh: true,
                formNama: "Komentar",
                hint: "Pelayanan sangat baik",
                minLine: 3,
                maxLine: 5,
                height: 80,
                controller: controllerKomentar,
                validasi: (value) {
                  if (value!.isEmpty) {
                    return "No Handphone tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButton3(
                  btnName: "Kirim Review",
                  onPress: () async {
                    if (valueJamKerja.isEmpty && controllerNoHP.text.isEmpty) {
                      dialogInfoWithoutDelay(
                          context, "Silahkan isi form terlebih dahulu!");
                    } else {
                      Future.delayed(Duration(microseconds: 1000), () {
                        dialogInfoWithoutDelay(context,
                            "Pastikan memasukan tanggal, jam servis dan nomor yang sesuai dengan booking");
                      });
                      await showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('logBooking')
                                  .doc(
                                      "${DateFormat("d-MMMM-y", "ID").format(selectedDate)} $valueJamKerja ${int.parse(controllerNoHP.text)}")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final status = snapshot.data!;
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
                                                "KONFIRMASI REVIEW",
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
                                                  const Text(
                                                    ":",
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                          "${DateFormat("EEEE, d-MMMM-y", "ID").format(selectedDate)} / $valueJamKerja"))
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
                                                  const Text(
                                                    ":",
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                          controllerNoHP.text))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Rating",
                                                    ),
                                                  ),
                                                  const Text(
                                                    ":",
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child:
                                                          Text("$ratingReview"))
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Komentar",
                                                    ),
                                                  ),
                                                  const Text(
                                                    ":",
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                          controllerKomentar
                                                              .text))
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
                                                    style: ElevatedButton
                                                        .styleFrom(
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
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.blueGrey,
                                                    ),
                                                    onPressed: () {
                                                      if (status
                                                              .get("status") ==
                                                          "Servis selesai") {
                                                        FirebaseService(
                                                                FirebaseAuth
                                                                    .instance)
                                                            .updateReviewLogBooking(
                                                                context:
                                                                    context,
                                                                title:
                                                                    "${DateFormat("d-MMMM-y", "ID").format(selectedDate)} $valueJamKerja ${int.parse(controllerNoHP.text)}",
                                                                rating: ratingReview
                                                                    .toString(),
                                                                komentar:
                                                                    controllerKomentar
                                                                        .text);
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
                                }
                                return const SizedBox();
                              });
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
