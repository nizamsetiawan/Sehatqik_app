import 'dart:convert';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:sehatqik_app/model/pasien.dart';
import 'package:sehatqik_app/util/config.dart';

class User {
  final String username, password;
  final dynamic idUser;
  final Pasien? idPasien;

  User(
      {this.idUser,
      required this.username,
      required this.password,
      this.idPasien});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        idUser: json['id_user'],
        username: json['username'],
        password: json['password'],
        idPasien: (json['id_pasien'] != null)
            ? Pasien.fromJson(json['id_pasien'])
            : null);
  }
}

// login (POST)
Future<Response> login(User user) async {
  String route = "${AppConfig.API_ENDPOINT}/login.php";
  try {
    final response = await http.post(Uri.parse(route),
        headers: {"Content-Type": "application/json"},
        body:
            jsonEncode({'username': user.username, 'password': user.password}));

    print(response.body.toString());

    return response;
  } catch (e) {
    print("Error : ${e.toString()}");
    throw Exception('Failed load $route');
  }
}
