import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sehatqik_app/model/obat.dart';
import 'package:sehatqik_app/model/pesan_obat.dart';
import 'package:sehatqik_app/util/util.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController alamatCont = TextEditingController();
  TextEditingController ketCont = TextEditingController();
  LatLng alamatLatLng = const LatLng(0.500359, 101.419844);
  int totalBiaya = 0;

  List<Obat> obats = [];
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  late CameraPosition _currentPosition; // Location set is Danau Raja, Rengat

  @override
  void initState() {
    super.initState();
    _currentPosition = CameraPosition(target: alamatLatLng, zoom: 14.4746);
    _addMarker(alamatLatLng);

    fetchObats().then((result) {
      setState(() {
        obats = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Pesanan'),
      ),
      bottomNavigationBar: largetButton(
          label: "PESAN SEKARANG (${toRupiah(totalBiaya)})",
          iconData: Icons.shopping_cart,
          onPressed: () => _isFormValid() ? _saveData() : null),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Flexible(flex: 1, child: _map()),
              Flexible(
                flex: 1,
                child: ListView(
                  children: <Widget>[
                    _alamatText(),
                    const SizedBox(height: 10),
                    _ketText(),
                    const SizedBox(height: 10),
                    _obatCheckbox()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() async {
    String listPesanan = "";
    int totalBiaya = 0;
    obats.where((obat) => obat.isSelected).toList().forEach((obat) {
      listPesanan =
          "$listPesanan- ${obat.nama} (${obat.jumlah}) ${obat.satuan}\n";
      totalBiaya = totalBiaya + (obat.jumlah * obat.harga);
    });
    PesanObat pesanObat = PesanObat(
        alamat: alamatCont.text,
        lat: alamatLatLng.latitude.toString(),
        lng: alamatLatLng.longitude.toString(),
        listPesanan: listPesanan,
        totalBiaya: totalBiaya.toString(),
        ket: ketCont.text);

    final response = await pesanObatCreate(pesanObat);
    if (response != null) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        var jsonResp = json.decode(response.body);
        Navigator.pop(context, jsonResp['message']);
      } else {
        print(response.statusCode);
        print(response.body.toString());
        showCustomDialog(context, response.body.toString());
      }
    }
  }

  void _addMarker(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      if (_markers.isNotEmpty) _markers.clear();
      _markers.add(Marker(
          markerId: const MarkerId("myPosition"),
          position: position,
          icon: BitmapDescriptor.defaultMarker));

      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 18)));
      setState(() {
        alamatLatLng = position;
      });
    });
  }

  Widget _obatCheckbox() {
    return FutureBuilder(
        future: fetchObats(),
        builder: (context, snapshot) {
          Widget result;
          if (snapshot.hasData) {
            result = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: obats.map((obat) {
                return CheckboxListTile(
                    value: obat.isSelected,
                    title: Text(
                        "${obat.nama}/${obat.satuan} @ ${toRupiah(obat.harga)}"),
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: Visibility(
                        visible: obat.isSelected,
                        child: SizedBox(
                          width: 60,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue:
                                obats[obats.indexOf(obat)].jumlah.toString(),
                            decoration:
                                const InputDecoration(hintText: 'Jumlah'),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Tidak boleh kosong';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                obats[obats.indexOf(obat)].jumlah =
                                    int.parse(value);
                              });
                              _hitungTotalBiaya();
                            },
                          ),
                        )),
                    onChanged: (bool? val) {
                      setState(() {
                        obats[obats.indexOf(obat)].isSelected = val!;
                        if (!val) {
                          setState(() {
                            obats[obats.indexOf(obat)].jumlah = 1;
                          });
                        }
                        _hitungTotalBiaya();
                      });
                    });
              }).toList(),
            );
          } else if (snapshot.hasError) {
            result = Center(child: Text("${snapshot.error}"));
          } else {
            result = const Center(child: CircularProgressIndicator());
          }

          return result;
        });
  }

  bool _isFormValid() {
    List<String> message = [];
    if (alamatCont.text.isEmpty) {
      message.add("Alamat belum diisi");
    }

    if (obats.where((obat) => obat.isSelected).toList().isEmpty) {
      message.add("Obat belum dipilih");
    }

    if (message.isNotEmpty) {
      showCustomDialog(context, message.join(', '));
      return false;
    }

    return true;
  }

  void _hitungTotalBiaya() {
    totalBiaya = 0;
    List<Obat> obatsSelected = obats.where((obat) => obat.isSelected).toList();
    setState(() {
      obatsSelected.forEach(
          (obat) => totalBiaya = totalBiaya + (obat.harga * obat.jumlah));
      print('totalBiaya : $totalBiaya');
    });
  }

  Widget _alamatText() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: alamatCont,
      decoration: const InputDecoration(
          icon: Icon(Icons.store), hintText: 'Alamat Lengkap'),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _ketText() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: ketCont,
      decoration: const InputDecoration(
          icon: Icon(Icons.textsms), hintText: 'Keterangan'),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _map() {
    return SizedBox(
      height: 300,
      child: GoogleMap(
        markers: _markers,
        initialCameraPosition: _currentPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (LatLng latLng) => _addMarker(latLng),
      ),
    );
  }
}
