import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_system/auth/login_page.dart';
import 'package:service_booking_system/navbar/navigation_bar.dart';
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
      authRoute(context, "Login success!", NavigationBarUI());
    } on FirebaseAuthException catch (e) {
      // dialogInfo(context, e.message!);
      if (e.message ==
          "The password is invalid or the user does not have a password.") {
        return dialogInfoWithoutDelay(
          context,
          "Password salah!",
        );
      } else {
        return dialogInfoWithoutDelay(
          context,
          "Email tidak terdaftar!",
        );
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
      dialogInfoWithoutDelay(
        context,
        e.message!,
      );
    }
  }

  authRoute(context, String text, Widget page) {
    dialogInfoWithoutDelay(
      context,
      text,
    );
    Future.delayed(
      const Duration(seconds: 2),
      () => navReplaceTransition(context, page),
    );
  }

  postListBookingToFirestore(
      {required DateTime tanggal,
      required String title,
      required String nama,
      required String jam,
      required int noHp,
      required String tipeMotor,
      required String noPolisi,
      required String jenisServis,
      required String jumlahKm,
      required String gambarNama,
      required String gambarUrl}) async {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection('listBooking');
    fireStore.doc(title).set({
      "tanggal": tanggal,
      "jam": jam,
      "nama": nama,
      "status": "Menunggu",
      "noHp": noHp,
      "tipeMotor": tipeMotor,
      "noPolisi": noPolisi,
      "jenisServis": jenisServis,
      "jumlahKm": jumlahKm,
      "gambarNama": gambarNama,
      "gambarUrl": gambarUrl,
      "komentar": "Belum ada komentar",
      "rating": "Belum ada rating",
      "createTime":
          DateFormat("EEEE, d-MMMM-y H:m:s", "ID").format(DateTime.now()),
    });
  }

  postLogBookingToFireStore({
    required String title,
    required String jam,
    required String nama,
    required DateTime tanggal,
    required int noHp,
    required String tipeMotor,
    required String noPolisi,
    required String jenisServis,
    required String jumlahKm,
    required String gambarNama,
    required String emailAdmin,
    required String gambarUrl,
    required String status,
  }) {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection('logBooking');
    fireStore.doc(title).set({
      "status": status,
      "updateBy": emailAdmin,
      "tanggal": tanggal,
      "jam": jam,
      "nama": nama,
      "noHp": noHp,
      "tipeMotor": tipeMotor,
      "noPolisi": noPolisi,
      "jenisServis": jenisServis,
      "jumlahKm": jumlahKm,
      "gambarNama": gambarNama,
      "gambarUrl": gambarUrl,
      "komentar": "Belum ada komentar",
      "rating": "Belum ada rating",
      "createTime":
          DateFormat("EEEE, d-MMMM-y H:m:s", "ID").format(DateTime.now()),
    });
  }

  updateStatusListBooking({
    required String title,
    required String status,
  }) async {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection("listBooking");
    fireStore.doc(title).update({
      "status": status,
      "createTime":
          DateFormat("EEEE, d-MMMM-y H:m:s", "ID").format(DateTime.now()),
    });
  }

  deleteListBookingToFirebase({required String title}) {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection('listBooking');
    fireStore.doc(title).delete();
  }

  postJadwalServisToFirestore(
      {required DateTime tanggal,
      required String gambarNama,
      required String gambarUrl,
      required String jenisServis,
      required String jumlahKm,
      required String nama,
      required String jam,
      required String title,
      required int noHp,
      required String noTiket,
      required String noPolisi,
      required String emailAdmin,
      required String tipeMotor}) async {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection("jadwalServis");
    fireStore.doc(title).set({
      "gambarNama": gambarNama,
      "gambarUrl": gambarUrl,
      "jenisServis": jenisServis,
      "jumlahKm": jumlahKm,
      "nama": nama,
      "noHp": noHp,
      "noPolisi": noPolisi,
      "tanggal": tanggal,
      "jam": jam,
      "noTiket": noTiket,
      "tipeMotor": tipeMotor,
      "komentar": "Belum ada komentar",
      "status": "Booking diterima",
      "rating": "Belum ada rating",
      "updateBy": emailAdmin,
      "updateTime": DateTime.now().millisecondsSinceEpoch,
      "createTime":
          DateFormat("EEEE, d-MMMM-y H:m:s", "ID").format(DateTime.now()),
    });
  }

  deleteJadwalServisToFirebase({required String title}) {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection('jadwalServis');
    fireStore.doc(title).delete();
  }

  updateStatusLogBooking({
    required String title,
    required String status,
  }) async {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection("logBooking");
    fireStore.doc(title).update({
      "status": status,
      "createTime":
          DateFormat("EEEE, d-MMMM-y H:m:s", "ID").format(DateTime.now()),
    });
  }

  postSelesaiServisToFirestore(
      {required DateTime tanggal,
      required String gambarNama,
      required String gambarUrl,
      required String jenisServis,
      required String jumlahKm,
      required String nama,
      required String jam,
      required String title,
      required int noHp,
      required String noPolisi,
      required String emailAdmin,
      required String tipeMotor}) async {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection("selesaiServis");
    fireStore.doc(title).set({
      "gambarNama": gambarNama,
      "gambarUrl": gambarUrl,
      "jenisServis": jenisServis,
      "jumlahKm": jumlahKm,
      "nama": nama,
      "noHp": noHp,
      "komentar": "Belum ada komentar",
      "status": "Booking diterima",
      "rating": "Belum ada rating",
      "noPolisi": noPolisi,
      "tanggal": tanggal,
      "jam": jam,
      "tipeMotor": tipeMotor,
      "status": "Servis selesai",
      "updateBy": emailAdmin,
      "createTime": DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  updateReviewLogBooking({
    required BuildContext context,
    required String title,
    required String rating,
    required String komentar,
  }) async {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection("selesaiServis");
    fireStore.doc(title).update({
      "rating": rating,
      "komentar": komentar,
      "createTime":
          DateFormat("EEEE, d-MMMM-y H:m:s", "ID").format(DateTime.now()),
    }).then((value) {
      dialogInfoWithoutDelay(context, "Review sukses diberikan!");
      Future.delayed(Duration(seconds: 2), () {
        navReplaceTransition(context, NavigationBarUI());
      });
    }).onError((error, stackTrace) {
      dialogInfoWithoutDelay(context,
          "Review gagal diberikan!\n\nPastikan sudah memasukan tanggal, jam servis dan nomor yang sesuai dengan booking");
    });
  }
}

updateTimeServices({
  required String jam,
  required int hitungJam,
  required int hitungMontir,
}) async {
  CollectionReference fireStore =
      FirebaseFirestore.instance.collection("timeServices");
  fireStore.doc("UFYfUtf5FW3sxPB2iCPg").update({
    jam: hitungJam,
    "montir": hitungMontir,
    "updateTime":
        DateFormat("EEEE, d-MMMM-y H:m:s", "ID").format(DateTime.now()),
  });
}
