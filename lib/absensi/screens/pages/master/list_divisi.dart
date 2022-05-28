import 'package:face_id_plus/absensi/screens/pages/master/add_divisi.dart';
import 'package:flutter/material.dart';

class ListDivisi extends StatefulWidget {
  const ListDivisi({ Key? key }) : super(key: key);

  @override
  State<ListDivisi> createState() => _ListDivisiState();
}

class _ListDivisiState extends State<ListDivisi> {
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
        "List Divisi",
        style: TextStyle(color: Colors.black),
      ),
      ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const AddDivisi()));
      }, child: const Icon(Icons.add),
    ),

    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("ID Divisi"),
                      ElevatedButton(
                        onPressed: (){

                        }, child: const Text("Ubah")),
                    ],
                  ),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Nama Divisi"),
                      ElevatedButton(
                        onPressed: (){

                        }, child: const Text("Hapus")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),    
    );
  }
}