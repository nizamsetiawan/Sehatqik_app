import 'package:flutter/material.dart';
import 'package:sehatqik_app/model/pasien.dart';
import 'package:sehatqik_app/util/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeContent extends StatefulWidget {
  static String title = 'Home Pasien';

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String? username = '';

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInUser = prefs.getString(NAMA);
    setState(() {
      username = loggedInUser ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Selamat Datang',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 10),
          Text(
            username ?? '',
            style: TextStyle(fontSize: 20),
          ),
          // ... Tambahkan widget lainnya sesuai kebutuhan
        ],
      ),
    );
  }
}
