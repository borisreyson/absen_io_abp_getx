import 'dart:math';

import 'package:face_id_plus/screens/pages/absensi/admin_absen.dart';
import 'package:face_id_plus/screens/pages/area.dart';
import 'package:face_id_plus/screens/pages/buletin/buletin.dart';
import 'package:face_id_plus/screens/pages/absensi/lihat_absensi.dart';
import 'package:face_id_plus/screens/pages/master/list_departemen.dart';
import 'package:face_id_plus/screens/pages/master/list_divisi.dart';
import 'package:face_id_plus/screens/pages/master/list_karyawan.dart';
import 'package:face_id_plus/screens/pages/profile_page.dart';
import 'package:face_id_plus/screens/pages/cuti/roster_cuti.dart';
import 'package:face_id_plus/screens/pages/cuti/roster_kerja.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

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
            onPressed: () {
              _askLogout();
            },
            child: Text("Keluar"),
          ),
        ),
        body: SafeArea(
          child: menu(),
        )
        // Container(
        //   color: Colors.white,
        //   child: ListView(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget> [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Expanded(
        //                   child: TextButton(
        //                     style: TextButton.styleFrom(
        //                       textStyle: const TextStyle(fontSize: 20),

        //                     ),
        //                     onPressed: () {
        //                       Navigator.push(
        //                         context,
        //                         MaterialPageRoute(
        //                           builder: (BuildContext context) => const ProfilePage()));
        //                     },
        //                     child: Align(
        //                       alignment: Alignment.centerLeft,
        //                       child: const Text('Profile')
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 10,
        //               ),
        //             ),

        //             TextButton(

        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (BuildContext context) => ListKaryawan()));
        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('List Karyawan')),
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 25,
        //               ),
        //             ),

        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (BuildContext context) => const ListDepartemen()));
        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('List Departemen')),
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 10,
        //               ),
        //             ),

        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {
        //                  Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (BuildContext context) => const ListDivisi()));
        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('List Divisi')),
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 25,
        //               ),
        //             ),

        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {
        //                  Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (BuildContext context) => const LihatAbsen()));
        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('List Absen')),
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 10,
        //               ),
        //             ),

        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {
        //                  Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (BuildContext context) => const LihatAbsen()));
        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('List Jam Kerja')),
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 20,
        //               ),
        //             ),

        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {

        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('Admin Absen')),
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 20,
        //               ),
        //             ),

        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (BuildContext context) => const RosterKerja()));
        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('Roster Kerja')),
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 20,
        //               ),
        //             ),

        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {
       
        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('Roster Cuti')),
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 20,
        //               ),
        //             ),

        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (BuildContext context) => Buletin()));
        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('Buletin')),
        //             ),

        //             Padding(
        //               padding: const EdgeInsets.only(left: 8, right: 8),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 20,
        //               ),
        //             ),

        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 textStyle: const TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {

        //               },
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: const Text('Area ABP')),
        //             ),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // )
        );
  }

  Widget menu() {
    return ListView(children: <Widget> [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ProfilePage()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 80, color: Colors.blue),
                      Text("PROFIL",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LihatAbsen()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list,
                          size: 80, color: Colors.blue),
                      Text("List Absen",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      Column(
        children: [
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ListKaryawan()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people_alt, size: 80, color: Colors.blue),
                      Text("List Karyawan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ListDepartemen()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.business_rounded,
                          size: 80, color: Colors.blue),
                      Text("List Departemen",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ]),

      Column(
        children: [
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ListDivisi()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.business_center_rounded, size: 80, color: Colors.blue),
                      Text("List Divisi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => const LihatAbsen()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time_filled,
                          size: 80, color: Colors.blue),
                      Text("List Jam Kerja",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ]),

      Column(
        children: [
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const RosterKerja()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range_rounded, size: 80, color: Colors.blue),
                      Text("Roster Kerja",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const RosterCuti()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month_sharp,
                          size: 80, color: Colors.blue),
                      Text("Roster Cuti",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ]),

      Column(
        children: [
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Buletin()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.newspaper_outlined, size: 80, color: Colors.blue),
                      Text("Buletin",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const AreaAbp()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 80, color: Colors.blue),
                      Text("Area ABP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ]),

      Column(
        children: [
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AdminListAbsen()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_people, size: 80, color: Colors.blue),
                      Text("Admin Absen",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ])
      ]) 
    ]);
  }

  void _askLogout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Apakah Anda Ingin Keluar?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _doLogOut();
                },
                child: const Text('Ya, Keluar!'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  child: const Text('Tidak')),
            ],
          );
        });
  }

  _doLogOut() async {
    var _pref = await SharedPreferences.getInstance();
    var isLogin = _pref.getInt("isLogin");
    if (isLogin == 1) {
      await _pref.clear();
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
