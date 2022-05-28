// ignore_for_file: deprecated_member_use

import 'package:face_id_plus/abp_energy/master/model/berita.dart';
import 'package:face_id_plus/absensi/model/buletin_model.dart';
import 'package:flutter/material.dart';

class AddBuletin extends StatefulWidget {
  final Data? listBuletin;
  const AddBuletin({Key? key, this.listBuletin}) : super(key: key);

  @override
  State<AddBuletin> createState() => _AddBuletinState();
}

class _AddBuletinState extends State<AddBuletin> {
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulBuletin = TextEditingController();
  final TextEditingController _kontenBuletin = TextEditingController();
  final TextEditingController _tgl = TextEditingController();

  // ignore: non_constant_identifier_names
  int? id_info;

  @override
  void initState() {
    if (widget.listBuletin != null) {
      var buletinData = widget.listBuletin;
      id_info = buletinData!.idInfo;

      _judulBuletin.text = buletinData.judul!;
      _kontenBuletin.text = buletinData.pesan!;
      _tgl.text = buletinData.tgl!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leading: InkWell(
          splashColor: const Color(0xff000000),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff000000),
          ),
          onTap: () {
            Navigator.maybePop(context);
          },
        ),
        title: const Text(
          "Tambah Buletin",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: ListView(children: [
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                      cursorColor: Theme.of(context).cursorColor,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 10,
                              )),
                          labelText: "Judul",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: Colors.green,
                          hintText: 'Masukkan Judul Buletin'),
                      controller: _judulBuletin,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Judul Tidak Boleh Kosong";
                        }
                        return null;
                      }),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                      controller: _tgl,
                      onTap: () async {
                        DateTime? date;
                        FocusScope.of(context).requestFocus(FocusNode());
                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));

                        var _tanggal =
                            "${date!.day}-${date.month}-${date.year}";
                        _tgl.text = _tanggal;
                      },
                      readOnly: true,
                      cursorColor: Theme.of(context).cursorColor,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 10,
                              )),
                          labelText: "Tanggal",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: Colors.green,
                          hintText: 'Masukkan Tanggal Buletin'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Tanggal Tidak Boleh Kosong";
                        }
                        return null;
                      }),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: TextFormField(
                        minLines: 10,
                        keyboardType: TextInputType.multiline,
                        maxLines: 15,
                        cursorColor: Theme.of(context).cursorColor,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 10,
                              ),
                            ),
                            labelText: "Konten",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: Colors.white,
                            hintText: "Masukkan Isi Konten"),
                        controller: _kontenBuletin,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Konten Tidak Boleh Kosong";
                          }
                          return null;
                        }),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 19, right: 19, top: 5),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          var form = _formKey.currentState;
                          if (form!.validate()) {
                            if (widget.listBuletin == null) {
                              addBuletin();
                              setState(() {});
                            } else {
                              ubahBuletin(id_info!);
                              setState(() {});
                            }
                          }
                        },
                        child: const Text(
                          "Simpan",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  addBuletin() async {
    ListBuletin listBuletin = ListBuletin();

    listBuletin.judul = _judulBuletin.text.toString();
    listBuletin.tgl = _tgl.text.toString();
    listBuletin.pesan = _kontenBuletin.text.toString();
  }

  ubahBuletin(int idInfo) async {
    ListBuletin ubahBuletin = ListBuletin();

    ubahBuletin.judul = _judulBuletin.text.toString();
    ubahBuletin.tgl = _tgl.text.toString();
    ubahBuletin.pesan = _kontenBuletin.text.toString();
  }
}
