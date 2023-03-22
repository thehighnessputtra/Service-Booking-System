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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
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
                  return 'Jam Servis tidak boleh kosong';
                }
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
            ),
            const SizedBox(
              height: 10.0,
            ),
            CustomTextFormField(
              formNama: "No Handphone",
              controller: controllerNoHP,
            ),
            const SizedBox(
              height: 10.0,
            ),
            CustomTextFormField(
              formNama: "Tipe Motor",
              controller: controllerTipeMotor,
            ),
            CustomTextSmall(text: "contoh : Yamaha Mio M3 125"),
            const SizedBox(
              height: 10.0,
            ),
            CustomTextFormField(
              formNama: "No Polisi",
              controller: controllerNoPolisi,
            ),
            CustomTextSmall(text: "contoh : B 4444 SR"),
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
              controller: controllerJumlahKM,
            ),
            const SizedBox(
              height: 10.0,
            ),
            CustomTextFormField(
              formNama: "Gambar Motor",
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                  ": ${DateFormat("EEEE, d-MMMM-y").format(selectedDate)} / $valueJamKerja"))
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
                                              child:
                                                  Text(": $valueJenisServis"))
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
                                              backgroundColor: Colors.grey[600],
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
                                              backgroundColor: Colors.blueGrey,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
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
  }
}
