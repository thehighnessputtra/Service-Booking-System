import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/auth/login_page.dart';
import 'package:service_booking_system/navbar/navigation_bar.dart';
import 'package:service_booking_system/pages/home_page.dart';
import 'package:service_booking_system/servies/shared_service.dart';
import 'package:service_booking_system/widget/custom_notification.dart';
import 'package:service_booking_system/widget/transition_widget.dart';

class FirebaseService {
  final FirebaseAuth auth;

  FirebaseService(this.auth);
  final pref = SharedServices();
  User get user => auth.currentUser!;
  bool isLoading = false;

  Stream<User?> get authState => auth.authStateChanges();

  Future<void> signInEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      pref.saveEmail(email);

      // ignore: use_build_context_synchronously
      authRoute(context, "Login success!", const NavigationBarUI());
    } on FirebaseAuthException catch (e) {
      // dialogInfo(context, e.message!);
      if (e.message ==
          "The password is invalid or the user does not have a password.") {
        return dialogInfo(context, "Password salah!", 2);
      } else {
        return dialogInfo(context, "Email tidak terdaftar!", 2);
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();
      pref.deleteEmail();
      // ignore: use_build_context_synchronously
      authRoute(context, "Logout success!", const LoginPage());
    } on FirebaseAuthException catch (e) {
      dialogInfo(context, e.message!, 2);
    }
  }

  authRoute(context, String text, Widget page) {
    dialogInfo(context, text, 2);
    Future.delayed(
      const Duration(seconds: 2),
      () => navReplaceTransition(context, page),
    );
  }

  postListBookingToFirestore(
      {required String tnglJam,
      required String nama,
      required String noHp,
      required String tipeMotor,
      required String noPolisi,
      required String jenisServis,
      required String jumlahKm,
      required String gambarNama,
      required String gambarUrl}) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection('listBooking');
    fireStore.doc("$tnglJam $noHp").set({
      "tanggal+jam": tnglJam,
      "nama": nama,
      "noHp": noHp,
      "tipeMotor": tipeMotor,
      "noPolisi": noPolisi,
      "jenisServis": jenisServis,
      "jumlahKm": jumlahKm,
      "gambarNama": gambarNama,
      "gambarUrl": gambarUrl,
      "createTime":
          DateFormat("EEEE, d-MMMM-y H:m:s", "ID").format(DateTime.now()),
    });
  }

  postLogBookingToFireStore({
    required String tnglJam,
    required String nama,
    required String noHp,
    required String tipeMotor,
    required String noPolisi,
    required String jenisServis,
    required String jumlahKm,
    required String gambarNama,
    required String gambarUrl,
    required String status,
  }) {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection('logBooking');
    fireStore.doc(DateTime.now().millisecondsSinceEpoch.toString()).set({
      "status": status,
      "tanggal+jam": tnglJam,
      "nama": nama,
      "noHp": noHp,
      "tipeMotor": tipeMotor,
      "noPolisi": noPolisi,
      "jenisServis": jenisServis,
      "jumlahKm": jumlahKm,
      "gambarNama": gambarNama,
      "gambarUrl": gambarUrl,
      "createTime":
          DateFormat("EEEE, d-MMMM-y H:m:s", "ID").format(DateTime.now()),
    });
  }

  deleteListBookingToFirebase({required String tnglJam, required String noHP}) {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection('listBooking');
    fireStore.doc("$tnglJam $noHP").delete();
  }

  postFixedBookingToFirestore(
      {required String tanggaljam,
      required String accBy,
      required String gambarNama,
      required String gambarUrl,
      required String jenisServis,
      required String jumlahKm,
      required String nama,
      required String noHp,
      required String noPolisi,
      required String tipeMotor}) async {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection("fixedBooking");
    fireStore.doc("$tanggaljam $noHp").set({
      "accBy": accBy,
      "gambarNama": gambarNama,
      "gambarUrl": gambarUrl,
      "jenisServis": jenisServis,
      "jumlahKm": jumlahKm,
      "nama": nama,
      "noHp": noHp,
      "noPolisi": noPolisi,
      "tanggal+jam": tanggaljam,
      "tipeMotor": tipeMotor,
    });
  }
}
