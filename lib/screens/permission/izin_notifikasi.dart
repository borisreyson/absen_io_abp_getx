import 'package:face_id_plus/screens/permission/izin_kamera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class IzinNotifikasi extends StatefulWidget {
  const IzinNotifikasi({Key? key}) : super(key: key);

  @override
  State<IzinNotifikasi> createState() => _IzinNotifikasiState();
}

class _IzinNotifikasiState extends State<IzinNotifikasi> {
  bool izinStatus = false;

  bool? intro = false;

  bool visbleIntro = false;
  bool enableGPS = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFF2D0A7),
              Color(0xFF5D768C),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Penggunaan Notifikasi",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 75, 115, 2)),
                  ),
                ),
                Container(
                    width: 100, height: 100, child: const Icon(Icons.notifications,size:100 ,color: Color(0xFFBF6734))),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Kami Membutuhkan Izin untuk mengakses Notifikasi, dilakukan pengiriman notifikasi dari server",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Color.fromARGB(255, 45, 2, 115)),
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
                              label: const Text("Meminta Izin Notifikasi"),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 11, 189, 100)),
                              onPressed: () {
                                getPermission();
                              },
                              icon: const Icon(Icons.camera_alt_outlined));
                        } else {
                          return ElevatedButton.icon(
                              label: const Text("Selanjutnya"),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 11, 189, 100)),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        const IzinKamera()));
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const IzinKamera()));
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
    var flutterNotification = FlutterLocalNotificationsPlugin();
    await flutterNotification.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true,badge: true,sound: true);
        setState(() {
          
        });
  }
  Future<bool> statusIzin() async {
    var lokasi = await handler.Permission.notification;
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




}
