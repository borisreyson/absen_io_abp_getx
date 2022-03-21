import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:face_id_plus/screens/pages/add_buletin.dart';
import 'package:face_id_plus/screens/pages/detail_buletin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class Buletin extends StatefulWidget {
  const Buletin({ Key? key }) : super(key: key);

  @override
  State<Buletin> createState() => _BuletinState();
}

class _BuletinState extends State<Buletin> {

  String buletin = ("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.");
  //String? _tanggal;
  //late DateTime now;

  @override
  void initState() {
    // DateFormat fmt = DateFormat("dd MMMM yyyy");
    // DateTime old = DateTime.now();
    // now = DateTime(old.year, old.month, old.day);
    // _tanggal = fmt.format(now);
    getTgl();
    super.initState();
  }

  String getTgl() {
      var tgl = DateTime.now();
      return DateFormat("EEEE, dd MMMM yyyy").format(tgl);
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
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: ((context) => AddBuletin())
              )
            );
          }, 
            child: const Icon(Icons.add_to_photos_sharp),
            tooltip: 'Tambah Buletin',
          ),

      body: ListView(
        children: <Widget> [
          SizedBox(
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
                        builder: (BuildContext context) => const DetailBuletin()));
                  },
                  child: Column(
                    children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 15),
                             child: Text("${getTgl()}"),
                           ),
                           _dropMenu(),
                         ]),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("Judul", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              subtitle: Text("${buletin}"),
                            ),
                          ),

                          Column(
                            children:<Widget> [
                             
                            ],
                          ) 
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

         SizedBox(
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
                        builder: (BuildContext context) => const DetailBuletin()));
                  },
                  child: Column(
                    children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 15),
                             child: Text("${getTgl()}"),
                           ),
                           _dropMenu(),
                         ]),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("Judul", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              subtitle: Text("${buletin}"),
                            ),
                          ),

                          Column(
                            children:<Widget> [
                             
                            ],
                          ) 
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
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
                        builder: (BuildContext context) => const DetailBuletin()));
                  },
                  child: Column(
                    children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 15),
                             child: Text("${getTgl()}"),
                           ),
                           _dropMenu(),
                         ]),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("Judul", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              subtitle: Text("${buletin}"),
                            ),
                          ),

                          Column(
                            children:<Widget> [
                             
                            ],
                          ) 
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
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
                        builder: (BuildContext context) => const DetailBuletin()));
                  },
                  child: Column(
                    children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 15),
                             child: Text("${getTgl()}"),
                           ),
                           _dropMenu(),
                         ]),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("Judul", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              subtitle: Text("${buletin}"),
                            ),
                          ),

                          Column(
                            children:<Widget> [
                             
                            ],
                          ) 
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _dropMenu(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: const Icon(Icons.more_horiz,size: 25),
          customItemsIndexes: const [3],
          customItemsHeight: 8,
            items: [
              ...MenuItems.firstItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
                ),
              ],
            onChanged: (value) {
              MenuItems.onChanged(context, value as MenuItem);
            },
          itemHeight: 48,
          itemPadding: const EdgeInsets.only(left: 16, right: 16),
          dropdownWidth: 160,
          dropdownPadding: const EdgeInsets.symmetric(vertical: 10),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF21BFBD),
          ),
          dropdownElevation: 8,
          offset: const Offset(0, 8),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [ubah, hapus];
  static const ubah = MenuItem(text: 'Ubah', icon: Icons.edit);
  static const hapus = MenuItem(text: 'Hapus', icon: Icons.delete);

static Widget buildItem(MenuItem item) {
  return Row(
    children: [
      Icon(
        item.icon,
          color: Colors.white,
          size: 22
      ),

      const SizedBox(
        width: 10,
      ),

      Text(
        item.text,
          style: const TextStyle(color: Colors.white)
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.ubah:
        Navigator.push(context, MaterialPageRoute(builder: ( 
          (context) => const AddBuletin())));
      break;

      case MenuItems.hapus:
        showDialog(context: context, builder: (context){
          return _dialogHapus(context);
          
        });
      break;
    }
  }
}

Widget _dialogHapus(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 8,
    title: Text("Konfirmasi"),
    content: Text("Yakin ingin mengapus buletin dengan judul ini: Ini Judul"),
    actions: [
      TextButton(
        onPressed:() {
          Navigator.of(context).pop();
        }, 
        child: Text("TIDAK", style: TextStyle(color: Colors.blue)), 
      ),
      TextButton(
        onPressed:() {
          Navigator.of(context).pop();
        }, 
        child: Text("IYA", style: TextStyle(color: Colors.blue),), 
      ),
    ],
  );
}
  
