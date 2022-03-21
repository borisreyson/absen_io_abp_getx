import 'package:face_id_plus/screens/pages/buletin.dart';
import 'package:face_id_plus/screens/pages/lihat_absensi.dart';
import 'package:face_id_plus/screens/pages/list_departemen.dart';
import 'package:face_id_plus/screens/pages/list_divisi.dart';
import 'package:face_id_plus/screens/pages/list_karyawan.dart';
import 'package:face_id_plus/screens/pages/profile_page.dart';
import 'package:face_id_plus/screens/pages/roster_cuti.dart';
import 'package:face_id_plus/screens/pages/roster_kerja.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({ Key? key }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
      ),

      bottomNavigationBar: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){
                    
          }, child: Text("Keluar"),
        ),
      ),          

      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const ProfilePage()));
                        },
                        child: const Text('Profile'),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const ListKaryawan()));
                    },
                    child: const Text('List Karyawan'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 25,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const ListDepartemen()));
                    },
                    child: const Text('List Department'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const ListDivisi()));
                    },
                    child: const Text('List Divisi'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 25,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const LihatAbsen()));
                    },
                    child: const Text('List Absen'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const LihatAbsen()));
                    },
                    child: const Text('List Jam Kerja'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      
                    },
                    child: const Text('Admin Absen'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const RosterKerja()));
                    },
                    child: const Text('Roster Kerja'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const RosterCuti()));
                    },
                    child: const Text('Roster Cuti'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Buletin()));
                    },
                    child: const Text('Buletin'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      
                    },
                    child: const Text('Area ABP'),
                  ),     
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}