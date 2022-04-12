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
  int? isLogin,showAbsen;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("Keluar / Logout"),
                SizedBox(width: 5),
                Icon(Icons.logout)
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: menuGrid(),
        ));
  }

  Widget menuGrid() {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: GridView.count(
        crossAxisSpacing: 30,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ProfilePage()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.person, size: 80, color: Colors.blue),
                    Text("PROFIL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LihatAbsen()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.list, size: 80, color: Colors.blue),
                    Text("List Absen",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
          if(showAbsen == 1) Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ListKaryawan()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.people_alt_sharp, size: 80, color: Colors.blue),
                    Text("List Karyawan",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
          if(showAbsen == 1) Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ListDepartemen()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.business_rounded, size: 80, color: Colors.blue),
                    Text("List Departemen",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
          if(showAbsen == 1) Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const ListDivisi()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.business_center_rounded,
                        size: 80, color: Colors.blue),
                    Text("List Divisi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
          if(showAbsen == 1) Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.access_time_filled_rounded,
                        size: 80, color: Colors.blue),
                    Text("Jam Kerja",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const RosterKerja()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.date_range, size: 80, color: Colors.blue),
                    Text("Roster Kerja",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const RosterCuti()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.calendar_month, size: 80, color: Colors.blue),
                    Text("Roster Cuti",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Buletin()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.newspaper_rounded, size: 80, color: Colors.blue),
                    Text("Buletin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
          if(showAbsen == 1) Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AreaAbp()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
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
          if(showAbsen == 1) Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const AdminListAbsen()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.boy_rounded, size: 80, color: Colors.blue),
                    Text("Admin Absen",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
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

  getPref(BuildContext context) async {
    var sharedPref = await SharedPreferences.getInstance();
    isLogin = sharedPref.getInt("isLogin");
    if (isLogin != null) {
      if (isLogin == 1) {
        showAbsen = sharedPref.getInt("show_absen");
      } else {
        showAbsen = 0;
      }
    } else {
      showAbsen = 0;
    }
  }
}
