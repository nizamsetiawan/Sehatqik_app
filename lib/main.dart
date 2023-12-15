import 'package:flutter/material.dart';
import 'package:sehatqik_app/page/login.dart';
import 'package:sehatqik_app/page/splashscreen.dart';
import 'package:sehatqik_app/util/session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sehatqik_app/page/modul_pasien/index.dart' as IndexPasien;
import 'package:sehatqik_app/page/modul_pegawai/index.dart' as IndexPegawai;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontFamily:
                'OpenSans', // Ganti dengan font Google Fonts yang diinginkan
            fontSize: 16.0, // Atur ukuran teks sesuai kebutuhan
          ),
        ),
      ),
      home: SplashscreenView(),
    );
  }
}

class MyAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadSession(),
      builder: (context, snapshot) {
        late Widget result;
        if (snapshot.connectionState == ConnectionState.waiting) {
          result = Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final SharedPreferences prefs = snapshot.data as SharedPreferences;
          if (snapshot.hasData) {
            if (prefs.getBool(IS_LOGIN) ?? false) {
              if (prefs.getString(JENIS_LOGIN) ==
                  jenisLogin.PASIEN.toString()) {
                result = IndexPasien.IndexPage();
              } else {
                // mengembalikan home pegawai
                result = IndexPegawai.IndexPage();
              }
            } else {
              result = LoginPage();
            }
          } else {
            result = Scaffold(body: Text('${snapshot.error}'));
          }
        }

        return result;
      },
    );
  }

  Future _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
