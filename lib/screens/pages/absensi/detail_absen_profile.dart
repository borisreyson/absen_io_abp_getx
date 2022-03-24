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
      body:ListView(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 575,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(dataAbsen.gambar!,fit: BoxFit.fill,)),
              ),
            ),
          ),
          
          Stack(
            children: <Widget> [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    margin: EdgeInsets.only(top: 10,right: 5,left: 5),
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dataAbsen.nik!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(dataAbsen.jam!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(dataAbsen.lupa_absen!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ]),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child:
                      Card(
                        elevation: 10,
                        color: Colors.blueGrey,
                        margin: EdgeInsets.only(left: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(fmt.format(tgl), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color:Colors.white )),
                        ),
                      )),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 87,
                  height: 36,
                  child: (dataAbsen.status == "Masuk") 
                        ? Card(
                          elevation: 8, 
                          color: Colors.green,
                          child: Center(
                            child: Text(dataAbsen.status!, 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                          )
                          ) 
                        : Card(
                          elevation: 8,
                          color: Colors.red,
                          child: Center(
                            child: Text(dataAbsen.status!, 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                          ))
                            
                  ),
                ),
            ],
          )
        ],
      )
    );
  }
}