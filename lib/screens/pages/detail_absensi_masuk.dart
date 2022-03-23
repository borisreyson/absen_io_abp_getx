import 'dart:ffi';

import 'package:face_id_plus/model/face_login_model.dart';
import 'package:face_id_plus/model/last_absen.dart';
import 'package:face_id_plus/model/list_absen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailMasuk extends StatefulWidget {
  Presensi? absensi;
  DetailMasuk({ Key? key, this.absensi }) : super(key: key);

  @override
  State<DetailMasuk> createState() => _DetailMasukState();
}

class _DetailMasukState extends State<DetailMasuk> {
  String? fotoMasuk;
  late String nama;

  
  @override
  Widget build(BuildContext context) {
    var masukData = widget.absensi;
    if(fotoMasuk != null){
      fotoMasuk = masukData!.gambar;
    }else{
      fotoMasuk = null;
    }

    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tgl = DateTime.parse("${masukData!.tanggal}");
    
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
        "Detail Profile",
        style: TextStyle(color: Colors.black),
      ),
      ),

      body: ListView(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(masukData.gambar!,fit: BoxFit.fill,)),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget> [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(masukData.nik!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(fmt.format(tgl), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(masukData.jam!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(masukData.lupaAbsen!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ]),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: MediaQuery.of(context).size.width / 200,
                  child: SizedBox(
                    width: 87,
                    height: 36,
                    child: (masukData.status == "Masuk") 
                           ? Card(
                             elevation: 8, 
                             color: Colors.green,
                             child: Center(
                               child: Text(masukData.status!, 
                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                             )
                             ) 
                           : Card(
                             elevation: 8,
                             color: Colors.red,
                             child: Center(
                               child: Text(masukData.status!, 
                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                             ))
                               
                    ),
                  ),
              ],
            ),
          )
        ],
      )
    );
  }

    Future<Datalogin> _getPref() async {
    Datalogin _users = Datalogin();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    nama = _pref.getString("nama").toString();
    String nik = _pref.getString("nik").toString();
    String devisi = _pref.getString("devisi").toString();
    int? _showAbsen = _pref.getInt("show_absen");
    _users.nama = nama;
    _users.nik = nik;
    _users.devisi = devisi;
    print("showAbsen $_showAbsen");

    _users.showAbsen = (_showAbsen==null)?0:_showAbsen;

    return _users;
  }
}