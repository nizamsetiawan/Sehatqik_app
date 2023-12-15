import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String initialUsername;
  final String initialEmail;
  final String initialNoTelp;

  const EditProfilePage({
    Key? key,
    required this.initialUsername,
    required this.initialEmail,
    required this.initialNoTelp,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _noTelpController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _emailController = TextEditingController(text: widget.initialEmail);
    _noTelpController = TextEditingController(text: widget.initialNoTelp);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _noTelpController.dispose();
    super.dispose();
  }

  void saveChangesAndPop() {
    final Map<String, String> updatedData = {
      'username': _usernameController.text,
      'email': _emailController.text,
      'noTelp': _noTelpController.text,
    };

    showSavedSnackbar();

    Navigator.pop(context, updatedData);
  }

  void showSavedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data profil Anda telah diperbarui!'),
        duration: Duration(seconds: 3), // Durasi tampilan snackbar
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _noTelpController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nomor Telepon',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveChangesAndPop,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
