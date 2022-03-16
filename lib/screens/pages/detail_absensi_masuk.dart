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

      body: ListView(
        children:<Widget> [
          Stack(
            children:<Widget> [
              Container(
                height: 700,
                child: Image.network(masukData.gambar!),
              ),
              Positioned(
                top: 500,
                left: 15,
                child: SizedBox(
                  width: 400,
                  height: 112,
                  child: Card(
                    elevation: 8,
                    color: Color.fromARGB(132, 255, 255, 255),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                       child: Padding(
                         padding: const EdgeInsets.only(top: 9),
                         child: Column(
                           children: [
                              Text(masukData.nik!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(masukData.status!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(fmt.format(tgl), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(masukData.jam!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(masukData.lupaAbsen!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ]),
                       ),
              ),
                  )
                    
                )
               
            ],
          )
        ],
      ),
    );
  }
}