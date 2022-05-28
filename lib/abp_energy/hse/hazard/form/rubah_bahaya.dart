import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/hse/models/data_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class RubahBahaya extends StatefulWidget {
  final Data? data;
  final String? tipe;
  const RubahBahaya({Key? key, this.data, this.tipe}) : super(key: key);

  @override
  State<RubahBahaya> createState() => _RubahBahayaState();
}

class _RubahBahayaState extends State<RubahBahaya> {
  final _formKey = GlobalKey<FormState>();
  final _repository = HazardRepository();

  final Color _warna = const Color.fromARGB(255, 8, 19, 147);
  final _deskripsi = TextEditingController();
  final _deskripsiSebelumnya = TextEditingController();
  late Data _data;
  @override
  void initState() {
    _data = widget.data!;
    _deskripsiSebelumnya.text = (widget.tipe == "bahaya")
        ? "${_data.deskripsi}"
        : (widget.tipe == "perbaikan")
            ? "${_data.keteranganUpdate}"
            : "${_data.tindakan}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text((widget.tipe == "bahaya")
            ? "Rubah Bahaya"
            : (widget.tipe == "perbaikan")
                ? "Rubah Tindakan"
                : "Rubah Keterangan Perbaikan"),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              children: [
                deskBahayaSebelumnya(),
                deskBahaya(),
              ],
            ),
          ),
          btnAksi(),
        ],
      ),
    );
  }

  Widget deskBahayaSebelumnya() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _warna)),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _warna)),
                      labelStyle: TextStyle(color: _warna),
                      alignLabelWithHint: true,
                      labelText: (widget.tipe == "bahaya")
                          ? "Deskripsi Bahaya Sebelumnya"
                          : (widget.tipe == "perbaikan")
                              ? "Keterangan Perbaikan Sebelumnya"
                              : "Tindakan Sebelumnya",
                      hintText: (widget.tipe == "bahaya")
                          ? "Deskripsi Bahaya Sebelumnya"
                          : (widget.tipe == "perbaikan")
                              ? "Keterangan Perbaikan Sebelumnya"
                              : "Tindakan Sebelumnya",
                    ),
                    controller: _deskripsiSebelumnya,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return (widget.tipe == "bahaya")
                            ? "Deskripsi Bahaya Sebelumnya"
                            : (widget.tipe == "perbaikan")
                                ? "Keterangan Perbaikan Sebelumnya"
                                : "Tindakan Sebelumnya";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deskBahaya() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    maxLines: 10,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _warna)),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _warna)),
                      labelStyle: TextStyle(color: _warna),
                      alignLabelWithHint: true,
                      labelText: (widget.tipe == "bahaya")
                          ? "Deskripsi Bahaya"
                          : (widget.tipe == "perbaikan")
                              ? "Keterangan Perbaikan"
                              : "Tindakan",
                    ),
                    controller: _deskripsi,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return (widget.tipe == "bahaya")
                            ? "Deskripsi Bahaya Sebelumnya Wajib Di Isi"
                            : (widget.tipe == "perbaikan")
                                ? "Keterangan Perbaikan Sebelumnya Wajib Di Isi"
                                : "Tindakan Sebelumnya Wajib Di Isi";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnAksi() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding:
            const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Card(
                color: Colors.blue.shade700,
                elevation: 10,
                child: InkWell(
                  onTap: () {
                    _submit();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Simpan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.red.shade700,
                elevation: 10,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Batal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      Constants().showAlert(
        context,
        dismiss: false,
        loading: true,
        enBtn: false,
      );

      var uid = _data.uid;
      var tipe = widget.tipe;
      var deskripsi = _deskripsi.text;
      await _repository.postUpdateDeskripsi(uid, tipe, deskripsi).then((res) {
        if (res != null) {
          if (res.success) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          } else {
            Navigator.pop(context);
          }
        } else {
          Navigator.pop(context);
        }
      }).catchError((onError) {
        if (kDebugMode) {
          print("Error $onError");
        }
        Navigator.pop(context);
      });
    }
  }
}
