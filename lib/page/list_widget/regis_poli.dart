import 'package:flutter/material.dart';
import 'package:sehatqik_app/model/regis_poli.dart';
import 'package:sehatqik_app/util/util.dart';

class RegisPoliList extends StatefulWidget {
  final List<RegisPoli> regisPolis;
  RegisPoliList({required this.regisPolis});

  @override
  _RegisPoliListState createState() => _RegisPoliListState();
}

class _RegisPoliListState extends State<RegisPoliList> {
  @override
  Widget build(BuildContext context) {
    return (widget.regisPolis.isNotEmpty)
        ? ListView.builder(
            itemCount: (widget.regisPolis.length),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: null,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.assignment),
                        isThreeLine: true,
                        title: Text(widget.regisPolis[i].idDokter.nama),
                        subtitle: Text(widget.regisPolis[i].tglBooking),
                        trailing: Text(widget.regisPolis[i].poli),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          TextButton(
                              onPressed: () async {
                                final result = await deleteRegisPoli(
                                    widget.regisPolis[i].idRegisPoli);
                                showCustomDialog(context, result);
                                setState(() {
                                  widget.regisPolis.removeAt(i);
                                });
                              },
                              child: Text('HAPUS'))
                        ],
                      )
                    ],
                  ),
                ),
              );
            })
        : const Text('Tidak ada riwayat registrasi');
  }
}
