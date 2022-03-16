import 'package:face_id_plus/model/tigahariabsen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailProfile extends StatefulWidget {
  AbsenTigaHariModel? absenTigaHariModel;
  DetailProfile({ Key? key, this.absenTigaHariModel }) : super(key: key);

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  String? fotoProfile;
  @override
  Widget build(BuildContext context) {
    var dataAbsen = widget.absenTigaHariModel;
    if(fotoProfile != null){
      fotoProfile = dataAbsen!.gambar;
    }else{
      fotoProfile = null;
    }

    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tgl = DateTime.parse("${dataAbsen!.tanggal}");

    if(dataAbsen.status == "Masuk"){
      Text(dataAbsen.status!, style: TextStyle(color: Colors.green));
    }else if(dataAbsen.status == "Pulang"){
      Text(dataAbsen.status!, style: TextStyle(color: Colors.red));
    }else{

    }

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
                child: Image.network(dataAbsen.gambar!),
              ),
              Positioned(
                top: 500,
                left: 15,
                child: SizedBox(
                  width: 400,
                  height: 117,
                  child: Card(
                    elevation: 8,
                    color: Color.fromARGB(132, 255, 255, 255),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                       child: Padding(
                         padding: const EdgeInsets.only(top: 13),
                         child: Column(
                           children: [
                              Text(dataAbsen.nik!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(dataAbsen.status!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(fmt.format(tgl), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(dataAbsen.jam!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(dataAbsen.lupa_absen!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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