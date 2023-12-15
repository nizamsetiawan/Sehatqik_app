import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatqik_app/util/config.dart';

class Obat {
  final dynamic idObat;
  final String nama, satuan;
  final int harga;
  bool isSelected;
  int jumlah;

  Obat(
      {required this.idObat,
      required this.nama,
      required this.harga,
      required this.satuan,
      this.isSelected = false,
      this.jumlah = 1});

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
        idObat: json['id_obat'],
        nama: json['nama'],
        harga: (json['harga'] is String)
            ? int.parse(json['harga'])
            : json['harga'],
        satuan: json['satuan']);
  }
}

List<Obat> obatFromJson(jsonData) {
  List<Obat> result =
      List<Obat>.from(jsonData.map((item) => Obat.fromJson(item)));

  return result;
}

// index
Future<List<Obat>> fetchObats() async {
  String route = "${AppConfig.API_ENDPOINT}/obat/index.php";
  final response = await http.get(Uri.parse(route));

  if (response.statusCode == 200) {
    var jsonResp = json.decode(response.body);
    return obatFromJson(jsonResp);
  } else {
    throw Exception('Failed load $route, status : ${response.statusCode}');
  }
}
