import 'package:flutter/material.dart';
import 'package:sehatqik_app/model/pesan_obat.dart';
import 'package:sehatqik_app/page/list_widget/pesan_obat.dart';
import 'package:sehatqik_app/util/util.dart';
import 'package:sehatqik_app/page/modul_pasien/pesan_obat/create.dart'
    as PesanObatCreate;

class PesanObatContent extends StatefulWidget {
  static String title = "Pesan Obat";

  @override
  _PesanObatContentState createState() => _PesanObatContentState();
}

class _PesanObatContentState extends State<PesanObatContent> {
  late Future<List<PesanObat>> pesanObats;

  @override
  void initState() {
    super.initState();
    pesanObats = fetchPesanObats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PesanObatCreate.CreatePage()));

            if (result != null) {
              showCustomDialog(context, result);
              setState(() {
                pesanObats = fetchPesanObats();
              });
            }
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.add)),
      body: Center(
        child: FutureBuilder(
            future: pesanObats,
            builder: (context, snapshot) {
              Widget result;
              if (snapshot.hasError) {
                result = Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                result =
                    PesanObatList(pesanObats: snapshot.data as List<PesanObat>);
              } else {
                result = CircularProgressIndicator();
              }
              return result;
            }),
      ),
    );
  }
}
