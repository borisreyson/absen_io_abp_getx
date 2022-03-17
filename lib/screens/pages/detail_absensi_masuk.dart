import 'dart:ffi';

import 'package:face_id_plus/model/last_absen.dart';
import 'package:face_id_plus/model/list_absen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailMasuk extends StatefulWidget {
  Presensi? absensi;
  DetailMasuk({ Key? key, this.absensi }) : super(key: key);

  @override
  State<DetailMasuk> createState() => _DetailMasukState();
}

class _DetailMasukState extends State<DetailMasuk> {
  String? fotoMasuk;
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

      body: Column(
         children: <Widget> [
           Card(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
             child: Image.network(masukData.gambar!),
           ),

           SizedBox(
             width: 400,
             child: Card(
               child: Padding(
                 padding: const EdgeInsets.only(top: 4),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget> [
                   Text(masukData.nik!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                   Text(masukData.status!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                   Text(fmt.format(tgl), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                   Text(masukData.jam!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                   Text(masukData.lupaAbsen!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                 ]),
               ),
             ),
           )
         ],
       ) 
    );
  }
}