import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sehatqik_app/page/profile/editprofile.dart';
import 'package:sehatqik_app/page/profile/faq.dart';
import 'package:sehatqik_app/util/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static String title = "Profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _noTelpController;
  String? username;
  String? email;
  String? notelp;
  late File _image;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _noTelpController = TextEditingController();
    getUsername();
    getEmail();
    getNoTelp();
    _image = File('assets/images/person.jpeg'); // Gambar profil default
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _noTelpController.dispose();
    super.dispose();
  }

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInUser = prefs.getString(NAMA);
    setState(() {
      username = loggedInUser ?? '';
      _usernameController.text = username ?? '';
    });
  }

  Future<void> getNoTelp() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInUser = prefs.getString(HP);
    setState(() {
      notelp = loggedInUser ?? '';
      _noTelpController.text = notelp ?? '';
    });
  }

  Future<void> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInUser = prefs.getString(EMAIL);
    setState(() {
      email = loggedInUser ?? '';
      _emailController.text = email ?? '';
    });
  }

  Future<void> updateEmail(String newEmail) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(EMAIL, newEmail);
    setState(() {
      email = newEmail;
    });
  }

  Future<void> updateNoTelp(String newNoTelp) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(HP, newNoTelp);
    setState(() {
      notelp = newNoTelp;
    });
  }

  Future<void> updateUsername(String newUsername) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(NAMA, newUsername);
    setState(() {
      username = newUsername;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void goToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          initialUsername: username ?? '',
          initialEmail: email ?? '',
          initialNoTelp: notelp ?? '',
        ),
      ),
    ).then((result) {
      if (result != null && result is Map<String, String>) {
        if (result['username'] != null) {
          updateUsername(result['username']!);
        }
        if (result['email'] != null) {
          updateEmail(result['email']!);
        }
        if (result['noTelp'] != null) {
          updateNoTelp(result['noTelp']!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _image != null && _image.existsSync()
                  ? FileImage(_image)
                  : AssetImage(
                      'assets/images/person.jpeg',
                    ) as ImageProvider,
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Ganti Foto Profil'),
              leading: Icon(Icons.photo),
              onTap: _pickImage,
            ),
            Divider(),
            ListTile(
              title: Text('Edit Profile'),
              leading: Icon(Icons.edit),
              onTap: goToEditProfile,
            ),
            Divider(),
            ListTile(
              title: Text('FAQs'),
              leading: Icon(Icons.chat_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FAQPage()), // Navigate to your desired screen after splash screen
                );
              },
            ),

            // Other menu items (FAQ, About, etc.)
          ],
        ),
      ),
    );
  }
}
