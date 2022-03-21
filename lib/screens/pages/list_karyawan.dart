import 'package:face_id_plus/screens/pages/add_karyawan.dart';
import 'package:face_id_plus/screens/pages/add_karyawan.dart';
import 'package:flutter/material.dart';

class ListKaryawan extends StatefulWidget {
  const ListKaryawan({ Key? key }) : super(key: key);

  @override
  State<ListKaryawan> createState() => _ListKaryawanState();
}

class _ListKaryawanState extends State<ListKaryawan> {
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
        "List Karyawan",
        style: TextStyle(color: Colors.black),
      ),
      ),

    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const FormKaryawan()));
      }, child: Icon(Icons.add),
    ),  

    body: ListView(
      children: [
        Stack(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hendra", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              SizedBox(height: 5),
                              Text("22020323", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              SizedBox(height: 5),
                              Text("HCGA", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              SizedBox(height: 5),
                              Text("IT Staff", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 345,
                  bottom: 60,
                  child: SizedBox(
                    width: 87,
                    height: 80,
                    child: Card(
                      elevation: 8,
                      shape: CircleBorder(),
                      color: Colors.amber,
                      child: Icon(Icons.camera_alt), 
                    )
                               
                    ),
                  ),
              ],
            ),
      ]),  
    );
  }
}