import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:sehatqik_app/util/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TawkPage extends StatefulWidget {
  static String title = "Chat";
  @override
  State<TawkPage> createState() => _TawkPageState();
}

class _TawkPageState extends State<TawkPage> {
  late String name = '';
  bool usernameLoaded = false;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInUser = prefs.getString(NAMA);
    setState(() {
      name = loggedInUser ?? '';
      usernameLoaded = true; // Set flag ketika username berhasil diambil
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: usernameLoaded // Periksa apakah username sudah diambil
          ? Tawk(
              directChatLink:
                  'https://tawk.to/chat/657c2b0907843602b8025244/1hhmgg83n',
              visitor: TawkVisitor(
                name: name,
                email: 'takathasan82@gmail.com',
              ),
            )
          : Center(
              child:
                  CircularProgressIndicator(), // Tampilkan loader saat menunggu username
            ),
    );
  }
}
