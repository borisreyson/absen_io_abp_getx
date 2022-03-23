import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:face_id_plus/model/buletin_model.dart';
import 'package:face_id_plus/screens/pages/add_buletin.dart';
import 'package:face_id_plus/screens/pages/detail_buletin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Options {edit, delete}

class Buletin extends StatefulWidget {

  ListBuletin? listBuletin;

  Buletin({ Key? key, this.listBuletin }) : super(key: key);

  @override
  State<Buletin> createState() => _BuletinState();
}

class _BuletinState extends State<Buletin> {

  ApiBuletin? _buletin;
  List<ListBuletin>? infoListBuletin;
  var _popupMenuIndex = 0;
  int? id_info;

  @override
  void initState() {
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
          var tambahData = await Navigator.push(
              context, 
              MaterialPageRoute(
                builder: ((context) => AddBuletin())));
              if(tambahData == "Ok"){
                    setState(() {
                   
                    });
              }  
          }, 
            child: const Icon(Icons.add_to_photos_sharp),
            tooltip: 'Tambah Buletin',
          ),

      body: FutureBuilder(
              future: loadBuletin(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              return ListView(
                children: (infoListBuletin != null) 
                ? infoListBuletin!.map((b) =>    _content(b)).toList() 
                : [ Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  ]       
                );
              }  
            ),
        );
  }

  Widget _content(ListBuletin _list) {
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tanggal = DateTime.parse("${_list.tgl}");
    return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                color: const Color(0xFFF2E638),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailBuletin(
                          listBuletin: _list
                        )));
                    },
                    child: Column(
                      children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(left: 17, top: 10, bottom: 10),
                               child: 
                               Text("${fmt.format(tanggal)}"),
                             ),
                           ]),

                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                title: Text("${_list.judul}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                subtitle: Text("${_list.pesan}", maxLines: 6),
                              ),
                            )
                          ]
                        ),

                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  tooltip: 'Ubah',
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => AddBuletin(
                                          listBuletin: _list
                                        ))).then((value) => setState(() {}));
                                  },
                                ),

                                IconButton(
                                  icon: Icon(Icons.delete),
                                  tooltip: 'Hapus',
                                  onPressed: (){
                                    showDialog(context: context, builder: (context){
                                      return AlertDialog(
                                        title: Text("Konfirmasi"),
                                        content: Text("Yakin ingin mengapus data ini: "),
                                        actions: [
                                          TextButton(
                                            onPressed:() {
                                              Navigator.of(context).pop();
                                            }, 
                                        child: Text("TIDAK", style: TextStyle(color: Colors.blue)), 
                                      ),
                                      TextButton(
                                        onPressed:() {
                                          hapusBuletin(_list.id_info!);
                                          Navigator.of(context).pop();
                                          setState(() {
                                            
                                          });
                                        }, 
                                        child: Text("IYA", style: TextStyle(color: Colors.blue),), 
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

  var load = ApiBuletin.getBuletin();
  await load.then((value) {
  _buletin = value;
    if(_buletin != null){
        var infoBuletin = _buletin?.info; 
          if(infoBuletin != null){
              infoListBuletin = infoBuletin as List<ListBuletin>?;
            
          } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Data Tidak Ada")
              ));
            
            }
            }
          }).catchError((onError) {
            print(onError.toString());

             ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                content: Text("Error Jaringan ${onError.toString()}")));
        }
          ); 
  }

  hapusBuletin(int id_info) async {
    var api = await ApiBuletin.deleteBuletin(id_info).then((value) {
      print("data ${value?.success}");
      if (id_info != null){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          backgroundColor: Colors.green,
          content: Text("Data Berhasil Dihapus", style: TextStyle(color: Colors.white))));
      }else {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          backgroundColor: Colors.red,
          content: Text("Data Gagal Dihapus", style: TextStyle(color: Colors.white))));
      }
    });
  }
}

