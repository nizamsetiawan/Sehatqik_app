import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatqik_app/util/config.dart';
import 'package:sehatqik_app/util/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pasien.dart';

class PesanObat {
  final String alamat, listPesanan, ket;
  final dynamic lat, lng, totalBiaya;

  bool? isSelesai;

  final dynamic idPesanObat;
  final String? waktu;

  final Pasien? idPasien;

  PesanObat(
      {this.idPesanObat,
      this.idPasien,
      this.waktu,
      required this.alamat,
      required this.lat,
      required this.lng,
      required this.listPesanan,
      required this.totalBiaya,
      required this.ket,
      this.isSelesai});

  factory PesanObat.fromJson(Map<String, dynamic> json) {
    return PesanObat(
        idPesanObat: json['id_pesan_obat'],
        idPasien: Pasien.fromJson(json['id_pasien']),
        waktu: json['waktu'],
        alamat: json['alamat'],
        lat: (json['lat'] is String) ? double.parse(json['lat']) : json['lat'],
        lng: (json['lng'] is String) ? double.parse(json['lng']) : json['lng'],
        listPesanan: json['list_pesanan'],
        totalBiaya: json['total_biaya'],
        ket: json['ket'] ?? "",
        isSelesai: (json['is_selesai'] == "1") ? true : false);
  }
}

List<PesanObat> pesanObatFromJson(jsonData) {
  List<PesanObat> result =
      List<PesanObat>.from(jsonData.map((item) => PesanObat.fromJson(item)));

  return result;
}

// index
Future<List<PesanObat>> fetchPesanObats({isSelesai}) async {
  isSelesai = isSelesai ?? "";
  final prefs = await SharedPreferences.getInstance();
  String idPasien = prefs.getString(ID_PASIEN) ?? "";
  String route =
      "${AppConfig.API_ENDPOINT}/pesan-obat/index.php?id_pasien=$idPasien&is_selesai=$isSelesai";

  final response = await http.get(Uri.parse(route));
  print(response.body);

  if (response.statusCode == 200) {
    var jsonResp = json.decode(response.body);
    return pesanObatFromJson(jsonResp);
  } else {
    throw Exception('Failed load $route, status : ${response.statusCode}');
  }
}

// create (POST)
Future pesanObatCreate(PesanObat pesanObat) async {
  final prefs = await SharedPreferences.getInstance();
  String route = AppConfig.API_ENDPOINT + "/pesan-obat/create.php";
  try {
    final response = await http.post(Uri.parse(route),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'id_pasien': prefs.getString(ID_PASIEN),
          'alamat': pesanObat.alamat,
          'lat': pesanObat.lat,
          'lng': pesanObat.lng,
          'list_pesanan': pesanObat.listPesanan,
          'total_biaya': pesanObat.totalBiaya,
          'ket': pesanObat.ket
        }));

    return response;
  } catch (e) {
    print("Error : ${e.toString()}");
    return null;
  }
}

// delete (GET)
Future deletePesanObat(id) async {
  String route = "${AppConfig.API_ENDPOINT}/pesan-obat/delete.php?id=$id";
  final response = await http.get(Uri.parse(route));

  if (response.statusCode == 200) {
    var jsonResp = json.decode(response.body);
    return jsonResp['message'];
  } else {
    return response.body.toString();
  }
}

// update (GET)
Future updatePesanObat(id) async {
  String route = "${AppConfig.API_ENDPOINT}/pesan-obat/update.php?id=$id";
  final response = await http.get(Uri.parse(route));

  if (response.statusCode == 200) {
    var jsonResp = json.decode(response.body);
    return jsonResp['message'];
  } else {
    return response.body.toString();
  }
}
