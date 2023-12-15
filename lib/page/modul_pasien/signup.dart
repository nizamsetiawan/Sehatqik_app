import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sehatqik_app/model/pasien.dart';
import 'package:sehatqik_app/page/login.dart';
import 'package:sehatqik_app/page/onboarding.dart';
import 'package:sehatqik_app/util/util.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaCont = TextEditingController();
  TextEditingController hpCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          elevation: 0,
          // Tambahkan tombol kembali di AppBar
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OnboardingView()), // Navigate to your desired screen after splash screen
              );
            },
          ),

          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('SEHAT QIK',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: _formWidget(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formWidget() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: namaCont,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person), hintText: 'Nama Lengkap'),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: hpCont,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone_android),
                hintText: 'Nomor HP',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak boleh kosong';
                } else if (value.length != 12) {
                  return 'Nomor HP harus terdiri dari 12 digit';
                } else if (int.tryParse(value) == null) {
                  return 'Nomor HP harus berupa angka';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailCont,
              decoration: const InputDecoration(
                icon: Icon(Icons.alternate_email),
                hintText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak boleh kosong';
                } else if (!value.contains('@')) {
                  return 'Email tidak valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
                width: double.infinity,
                child: largetButton(
                    label: 'REGISTRASI PASIEN',
                    onPressed: () async => (_formKey.currentState!.validate())
                        ? prosesRegistrasi()
                        : null)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Anda sudah punya akun?"),
                GestureDetector(
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));

                      if (result != null) {
                        showCustomDialog(context, result);
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ),
          ],
        ));
  }

  void prosesRegistrasi() async {
    final response = await pasienCreate(
        Pasien(nama: namaCont.text, hp: hpCont.text, email: emailCont.text));

    if (response != null) {
      // print(response.body.toString());
      if (response.statusCode == 200) {
        var jsonResp = json.decode(response.body);
        Navigator.pop(context, jsonResp['message']);
      } else {
        showCustomDialog(context, "${response.body.toString()}");
      }
    }
  }
}
