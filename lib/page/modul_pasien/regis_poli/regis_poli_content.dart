import 'package:flutter/material.dart';
import 'package:sehatqik_app/model/regis_poli.dart';
import 'package:sehatqik_app/page/list_widget/regis_poli.dart';
import 'package:sehatqik_app/util/util.dart';

import 'package:sehatqik_app/page/modul_pasien/regis_poli/create.dart'
    as RegisPoliCreate;

class RegisPoliContent extends StatefulWidget {
  static String title = "Registrasi Poli";

  @override
  _RegisPoliContentState createState() => _RegisPoliContentState();
}

class _RegisPoliContentState extends State<RegisPoliContent> {
  late Future<List<RegisPoli>> regisPolis;

  @override
  void initState() {
    super.initState();
    regisPolis = fetchRegisPolis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisPoliCreate.CreatePage()));
            if (result != null) {
              showCustomDialog(context, result);
              setState(() {
                regisPolis = fetchRegisPolis();
              });
            }
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.edit)),
      body: Center(
        child: FutureBuilder(
            future: regisPolis,
            builder: (context, snapshot) {
              Widget result;
              if (snapshot.hasError) {
                result = Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                result =
                    RegisPoliList(regisPolis: snapshot.data as List<RegisPoli>);
              } else {
                result = CircularProgressIndicator();
              }
              return result;
            }),
      ),
    );
  }
}
