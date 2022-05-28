import 'package:face_id_plus/abp_energy/master/model/berita.dart' as berita;
import 'package:face_id_plus/absensi/api/provider.dart';
import 'package:face_id_plus/absensi/model/buletin_model.dart';
import 'package:face_id_plus/buletin/add_buletin.dart';
import 'package:face_id_plus/buletin/detail_buletin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Buletin extends StatefulWidget {
  ListBuletin? listBuletin;

  Buletin({Key? key, this.listBuletin}) : super(key: key);

  @override
  State<Buletin> createState() => _BuletinState();
}

class _BuletinState extends State<Buletin> {
  late AbsenProvider _provider;
  berita.BeritaModel? _buletin;
  List<berita.Data>? infoListBuletin;

  @override
  void initState() {
    _provider = AbsenProvider();
    loadBuletin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Buletin",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF21BFBD),
        elevation: 8,
        onPressed: () async {
          var tambahData = await Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const AddBuletin())));
          if (tambahData == "Ok") {
            setState(() {});
          }
        },
        child: const Icon(Icons.add_to_photos_sharp),
        tooltip: 'Tambah Buletin',
      ),
      body: FutureBuilder(
          future: loadBuletin(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return ListView(
                children: (infoListBuletin != null)
                    ? infoListBuletin!.map((b) => _content(b)).toList()
                    : [
                        Padding(
                          padding: const EdgeInsets.only(top: 250),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          ),
                        )
                      ]);
          }),
    );
  }

  Widget _content(berita.Data _list) {
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tanggal = DateTime.parse("${_list.tgl}");
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 8,
          color: const Color(0xFFF2E638),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DetailBuletin(listBuletin: _list)));
            },
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 17, top: 10, bottom: 10),
                    child: Text(fmt.format(tanggal)),
                  ),
                ]),
                Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text("${_list.judul}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text("\n${_list.pesan}", maxLines: 6),
                    ),
                  )
                ]),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Ubah',
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AddBuletin(listBuletin: _list)))
                                .then((value) => setState(() {}));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Hapus',
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Konfirmasi"),
                                    content: const Text(
                                        "Yakin ingin mengapus data ini: "),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("TIDAK",
                                            style:
                                                TextStyle(color: Colors.blue)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          hapusBuletin(_list.idInfo!);
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                        child: const Text(
                                          "IYA",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadBuletin() async {
    var load = _provider.getBuletin();
    await load.then((value) {
      _buletin = value;
      if (_buletin != null) {
        var _dataBerita = _buletin!.data;
        var infoBuletin = _dataBerita;
        if (infoBuletin != null) {
          infoListBuletin = infoBuletin;
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Data Tidak Ada")));
        }
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Jaringan ${onError.toString()}")));
    });
  }

  hapusBuletin(int idInfo) async {
    await _provider.deleteBuletin(idInfo).then((value) {
      if (value!.success!) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Data Berhasil Dihapus",
                style: TextStyle(color: Colors.white))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Data Gagal Dihapus",
                style: TextStyle(color: Colors.white))));
      }
      setState(() {});
    });
  }
}
