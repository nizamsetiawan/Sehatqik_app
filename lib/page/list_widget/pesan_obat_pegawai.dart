import 'package:flutter/material.dart';
import 'package:sehatqik_app/model/pesan_obat.dart';
import 'package:sehatqik_app/page/modul_pegawai/pesan_obat_view.dart';
import 'package:sehatqik_app/util/util.dart';

class PesanObatPegawaiList extends StatefulWidget {
  final List<PesanObat> pesanObats;
  final Function parentAction;
  PesanObatPegawaiList({required this.parentAction, required this.pesanObats});

  @override
  _PesanObatPegawaiListState createState() => _PesanObatPegawaiListState();
}

class _PesanObatPegawaiListState extends State<PesanObatPegawaiList> {
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
                        leading: Icon(Icons.local_hospital),
                        isThreeLine: true,
                        title: Text(widget.pesanObats[i].idPasien?.nama ?? '-'),
                        subtitle: Text(
                            "${widget.pesanObats[i].listPesanan} \n${widget.pesanObats[i].alamat} \n${widget.pesanObats[i].ket}"),
                        trailing:
                            Text(toRupiah(widget.pesanObats[i].totalBiaya)),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          TextButton(
                              onPressed: () async {
                                final result = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => PesanObatViewPage(
                                            pesanObat: widget.pesanObats[i])));
                                if (result != null) {
                                  widget.parentAction();
                                  showCustomDialog(context, result);
                                }
                              },
                              child: const Text('LOKASI')),
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
