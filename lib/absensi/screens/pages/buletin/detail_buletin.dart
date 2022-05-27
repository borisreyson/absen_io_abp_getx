import 'package:face_id_plus/absensi/model/buletin_model.dart';
import 'package:flutter/material.dart';

class DetailBuletin extends StatefulWidget {

  ListBuletin? listBuletin;
  DetailBuletin({ Key? key, this.listBuletin }) : super(key: key);

  @override
  State<DetailBuletin> createState() => _DetailBuletinState();
}

class _DetailBuletinState extends State<DetailBuletin> {

  @override
  Widget build(BuildContext context) {
    var buletinData = widget.listBuletin;
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
      title: Text(
        "${buletinData!.judul}",
        style: TextStyle(color: Colors.black),
      ),
      ),
      
      body: ListView(
        children: <Widget> [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${buletinData.pesan}", style: TextStyle(fontSize: 16)),
                      )
                    ],
                  ),
                )
              ),
            ),
          )
        ],
      )
    );
  }
}