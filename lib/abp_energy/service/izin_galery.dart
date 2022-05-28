import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/landing/landing.dart';
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:shared_preferences/shared_preferences.dart';

class IzinMedia extends StatefulWidget {
  const IzinMedia({Key? key}) : super(key: key);

  @override
  State<IzinMedia> createState() => _IzinMediaState();
}

class _IzinMediaState extends State<IzinMedia> {
  bool izinStatus = false;
  int? isLogin;
  bool? intro = false;

  bool visbleIntro = false;
  bool enableGPS = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 177, 167, 242),
          Color.fromARGB(255, 60, 12, 133),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Penggunaan Galeri",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                const SizedBox(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.perm_media_outlined,
                        size: 100, color: Color.fromARGB(255, 250, 250, 250))),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Kami Membutuhkan Galeri Anda untuk melakukan pengambulan file pengguna, sebagai data yand dibutuhkan oleh aplikasi, jadi Izin untuk penggunaan Galeri sangat di perlukan",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Color.fromARGB(255, 254, 255, 251)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: statusIzin(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (!snapshot.data) {
                          return ElevatedButton.icon(
                              label: const Text("Meminta Izin Penyimpanan"),
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 11, 189, 97)),
                              onPressed: () {
                                getPermission();
                              },
                              icon: const Icon(Icons.perm_media_outlined));
                        } else {
                          return ElevatedButton.icon(
                              label: const Text("Selanjutnya"),
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 85, 189, 11)),
                              onPressed: () {
                                saveIntro(context);
                              },
                              icon: const Icon(Icons.chevron_right));
                        }
                      }
                      return Container();
                    }),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    label: const Text(
                      "Lewati",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      saveIntro(context);
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )),
              ]),
        ),
      ),
    );
  }

  getPermission() async {
    var mintaIzin = await handler.Permission.photos.status;
    if (mintaIzin == handler.PermissionStatus.denied ||
        mintaIzin == handler.PermissionStatus.limited) {
      await handler.Permission.photos.request();
      if (kDebugMode) {
        if (kDebugMode) {
          print("a $mintaIzin");
        }
      }
    } else if (mintaIzin == handler.PermissionStatus.permanentlyDenied) {
      if (kDebugMode) {
        print("b");
      }
      await handler.openAppSettings();
    }
    if (kDebugMode) {
      print("z");
    }
    setState(() {});
  }

  Future<bool> statusIzin() async {
    var lokasi = handler.Permission.photos;
    var status = await lokasi.status;
    if (status == handler.PermissionStatus.granted) {
      izinStatus = true;
    }
    if (status == handler.PermissionStatus.denied) {
      izinStatus = false;
    } else if (status == handler.PermissionStatus.permanentlyDenied) {
      izinStatus = false;
    }
    return izinStatus;
  }

  saveIntro(BuildContext context) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("introSlider", true);
    checkIntro(context);
  }

  checkIntro(BuildContext context) async {
    SharedPreferences? _pref = await SharedPreferences.getInstance();
    intro = _pref.getBool("introSlider");
    if (intro != null) {
      if (intro!) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LandingPage()));
      } else {
        setState(() {
          visbleIntro = true;
        });
      }
    } else {
      setState(() {
        visbleIntro = true;
      });
    }
  }
}
