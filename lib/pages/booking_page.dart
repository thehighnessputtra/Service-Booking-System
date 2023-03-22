import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/widget/custom_button.dart';
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

  DateTime selectedDate = DateTime.now();

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
              hint: DateFormat("EEEE, d-MMMM-y").format(selectedDate),
              formNama: "Tanggal",
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                setState(() {
                  selectedDate = pickedDate!;
                });
              },
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
            const SizedBox(
              height: 10.0,
            ),
            CustomTextFormField(
              formNama: "No Polisi",
              controller: controllerNoPolisi,
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
                                              "Tanggal",
                                            ),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                  ": ${DateFormat("EEEE, d-MMMM-y").format(selectedDate)}"))
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
