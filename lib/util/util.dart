import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sehatqik_app/page/login.dart';
import 'package:sehatqik_app/util/session.dart';

void showCustomDialog(BuildContext context, String msg, {String? title}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.info, // Tipe dialog yang ingin ditampilkan
    animType: AnimType.scale, // Animasi tampilan dialog
    title: title ?? 'Perhatian!',
    desc: msg,
    btnOkText: "OK", // Teks tombol untuk menutup dialog
    btnOkColor: Colors.green,
    btnOkOnPress: () {}, // Aksi ketika tombol OK ditekan
  )..show(); // Menampilkan dialog
}

// Template button lebar utk posisi bottomNavigationBar
Widget largetButton(
    {String label = "Simpan",
    IconData? iconData,
    required Function() onPressed}) {
  iconData = iconData ?? Icons.done_all;
  return SizedBox(
    height: 60,
    width: double.infinity,
    child: ElevatedButton.icon(
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        icon: Icon(iconData, color: Colors.white),
        onPressed: onPressed),
  );
}

// fungsi format tulisan rupiah
String toRupiah(dynamic val) {
  if (val is String) {
    val = int.parse(val);
  }
  return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
      .format(val);
}

void logOut(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.WARNING,
    animType: AnimType.TOPSLIDE,
    title: 'Konfirmasi',
    desc: 'Apakah Anda yakin ingin keluar?',
    btnCancelText: 'Batal',
    btnCancelOnPress: () {},
    btnOkText: 'Keluar',
    btnOkColor: Colors.green,
    btnOkOnPress: () {
      clearSession().then((value) => Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return LoginPage();
              },
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
            (route) => false,
          ));
    },
  )..show();
}
