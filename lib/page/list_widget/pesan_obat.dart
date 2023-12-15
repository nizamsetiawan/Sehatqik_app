import 'package:flutter/material.dart';
import 'package:sehatqik_app/model/pesan_obat.dart';
import 'package:sehatqik_app/util/util.dart';

class PesanObatList extends StatefulWidget {
  final List<PesanObat> pesanObats;
  PesanObatList({required this.pesanObats});

  @override
  _PesanObatListState createState() => _PesanObatListState();
}

class _PesanObatListState extends State<PesanObatList> {
  @override
  Widget build(BuildContext context) {
    return (widget.pesanObats.isNotEmpty)
        ? ListView.builder(
            itemCount: (widget.pesanObats.length),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: null,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.local_hospital),
                        isThreeLine: true,
                        title: Text("${widget.pesanObats[i].waktu}"),
                        subtitle: Text(
                            "${widget.pesanObats[i].listPesanan} \n${widget.pesanObats[i].alamat} \n${widget.pesanObats[i].ket}"),
                        trailing:
                            Text(toRupiah(widget.pesanObats[i].totalBiaya)),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          Visibility(
                            visible: widget.pesanObats[i].isSelesai ?? false,
                            child: TextButton(
                                onPressed: () async {
                                  final result = await deletePesanObat(
                                      widget.pesanObats[i].idPesanObat);
                                  showCustomDialog(context, result);
                                  setState(() {
                                    widget.pesanObats.removeAt(i);
                                  });
                                },
                                child: const Text('HAPUS')),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            })
        : const Text('Tidak ada riwayat pesanan');
  }
}
