import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/pages/home/cek_status_servis/hasil_cek_status.dart';
import 'package:service_booking_system/widget/custom_button.dart';
import 'package:service_booking_system/widget/custom_textformfield.dart';
import 'package:service_booking_system/widget/transition_widget.dart';

class CekStatusServisPage extends StatefulWidget {
  const CekStatusServisPage({super.key});

  @override
  State<CekStatusServisPage> createState() => _CekStatusServisPageState();
}

TextEditingController controllerNoHP = TextEditingController();

class _CekStatusServisPageState extends State<CekStatusServisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cek Status Servis"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(children: [
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
            CustomButton3(
                btnName: "Cek",
                onPress: () {
                  navPushTransition(
                      context,
                      HasilCekStatusServis(
                        noHP: int.parse(controllerNoHP.text),
                      ));
                })
          ]),
        ));
  }
}
