import 'package:flutter/material.dart';
import 'package:sehatqik_app/page/chat.dart';
import 'package:sehatqik_app/page/modul_pasien/home/home_content.dart';
import 'package:sehatqik_app/page/modul_pasien/pesan_obat/pesan_obat_content.dart';
import 'package:sehatqik_app/page/modul_pasien/regis_poli/regis_poli_content.dart';
import 'package:sehatqik_app/page/profile/user.dart';
import 'package:sehatqik_app/util/util.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 2;
  Widget _selectedContent = HomeContent();
  String _selectedTitle = HomeContent.title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedTitle),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () => logOut(context))
        ],
      ),
      body: _selectedContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration), label: 'Regis Poli'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), label: 'Pesan Obat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _selectedContent = RegisPoliContent();
          _selectedTitle = RegisPoliContent.title;
          break;
        case 1:
          _selectedContent = TawkPage();
          _selectedTitle = TawkPage.title;
          break;

        case 2:
          _selectedContent = HomeContent();
          _selectedTitle = HomeContent.title;
          break;

        case 3:
          _selectedContent = PesanObatContent();
          _selectedTitle = PesanObatContent.title;
          break;
        case 4:
          _selectedContent = ProfilePage();
          _selectedTitle = ProfilePage.title;
          break;
      }
    });
  }
}
