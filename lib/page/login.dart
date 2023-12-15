import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sehatqik_app/model/user.dart';
import 'package:sehatqik_app/page/modul_pasien/signup.dart';
import 'package:sehatqik_app/page/onboarding.dart';
import 'package:sehatqik_app/util/session.dart';
import 'package:sehatqik_app/util/util.dart';
import 'package:sehatqik_app/page/modul_pasien/index.dart' as IndexPasien;
import 'package:sehatqik_app/page/modul_pegawai/index.dart' as IndexPegawai;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

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
              constraints: BoxConstraints(),
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
              controller: usernameCont,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person), hintText: 'Username'),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passCont,
              obscureText: true,
              decoration: const InputDecoration(
                  icon: Icon(Icons.vpn_key), hintText: 'Password'),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
                width: double.infinity,
                child: largetButton(
                    label: 'LOGIN',
                    iconData: Icons.subdirectory_arrow_right,
                    onPressed: () => (_formKey.currentState!.validate())
                        ? prosesLogin()
                        : null)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Anda belum punya akun?"),
                GestureDetector(
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));

                      if (result != null) {
                        showCustomDialog(context, result);
                      }
                    },
                    child: const Text(
                      'Registrasi',
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ),
          ],
        ));
  }

  void prosesLogin() async {
    try {
      final response = await login(
          User(username: usernameCont.text, password: passCont.text));
      var jsonResp = json.decode(response.body);
      if (response.statusCode == 200) {
        User user = User.fromJson(jsonResp['user']);
        if (user.idPasien != null) {
          // direct to home pasien
          createPasienSession(user.idPasien!);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => IndexPasien.IndexPage()));
        } else {
          // direct to home pegawai here
          createPegawaiSession(jsonResp['user']['username']);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => IndexPegawai.IndexPage()));
        }
      } else if (response.statusCode == 401) {
        showCustomDialog(context, jsonResp['message']);
      } else {
        showCustomDialog(context, response.body.toString());
      }
    } catch (e) {
      showCustomDialog(context, e.toString());
    }
  }
}
