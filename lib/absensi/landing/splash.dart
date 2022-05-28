import 'dart:async';

import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:face_id_plus/absensi/screens/auth/login.dart';
import 'package:face_id_plus/absensi/screens/pages/mainpage/absen_lokal.dart';
import 'package:face_id_plus/absensi/screens/pages/mainpage/home.dart';
import 'package:face_id_plus/absensi/services/notification.dart';
import 'package:face_id_plus/absensi/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final StreamController<bool> _pingServer = StreamController.broadcast();
  final StreamController<bool> _pingLokal = StreamController.broadcast();
  final StreamController<bool> _pingServerOnline = StreamController.broadcast();
  bool isOnline = false;
  bool lokalOnline = false;
  bool serverOnline = false;
  Timer? _timer;
  final Duration _duration = const Duration(seconds: 5);
  String? wifiBSSID;
  int isLogin = 0;
  @override
  void initState() {
    NotificationAPI.initNotif();
    serverStream();
    pingServer();
    getPref(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _main();
  }

  Widget _main() {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Opacity(
              opacity: 1.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(2, 4),
                          blurRadius: 5,
                          spreadRadius: 2)
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffffffff), Color(0xffA6BF4B)])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _logo(),
                    const SizedBox(
                      height: 30,
                    ),
                    _title(),
                    const SizedBox(
                      height: 40,
                    ),
                    (isOnline)
                        ? (isLogin == 1)
                            ? (serverOnline)
                                ? _lanjutOnline()
                                : offlineCheck()
                            : Container()
                        : offlineCheck(),
                    (isOnline)
                        ? (isLogin == 0)
                            ? (serverOnline)
                                ? _submitButton()
                                : offlineCheck()
                            : Container()
                        : serverIsOffline(),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (!lokalOnline)
                            ? (serverOnline)
                                ? const Text(
                                    "Server : Online",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(
                                    "Server : Offline",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )
                            : const Text(
                                "Server : Online",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (!lokalOnline)
                        ? (!serverOnline)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Center()
                        : const Center(),
                    if (Platform.isAndroid) tombolKeluar(),
                    // testNotif()
                    // _label()
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 35,
                  color: Color(0xFF003F63),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget offlineCheck() {
    return (lokalOnline)
        ? (isLogin == 1)
            ? _lanjutOffline()
            : _submitButton()
        : Container();
  }

  Widget _logo() {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage((!lokalOnline)
                ? "https://abpjobsite.com/abp_prof.png"
                : "http://10.10.3.13/abp_prof.png"),
            fit: BoxFit.contain,
          )),
        ));
  }

  Widget serverIsOffline() {
    var style = const TextStyle(color: Colors.red);
    return Card(
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "Jika Server Offline",
                style: style,
              ),
              Text(
                "Coba Untuk Menggunakan Jaringan Wifi PT ABP",
                style: style,
              )
            ],
          ),
        ));
  }

  Widget _lanjutOnline() {
    return InkWell(
      onTap: () {
        closePing();
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const HomePageAndroid()))
            .then((value) => reloadCekServer());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: const Text(
          'Lanjut',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _lanjutOffline() {
    return InkWell(
      onTap: () async {
        closePing();
        await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AbsenLokal()))
            .then((value) => reloadCekServer());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.purple, width: 2),
        ),
        child: const Text(
          'Lanjut',
          style: TextStyle(fontSize: 20, color: Colors.purple),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      hoverColor: Colors.white60,
      onTap: () async {
        closePing();
        bool wait = await Constants().goTo(() => const FormLogin(), context);
        if (wait) {
          setState(() {
            lokalOnline = false;
          });
          reloadCekServer();
          if (kDebugMode) {
            print("State $wait");
          }
        } else {
          setState(() {
            lokalOnline = false;
          });
          reloadCekServer();
          if (kDebugMode) {
            print("State $wait");
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: const Color(0xffdf8e33).withAlpha(100),
                  offset: const Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: const [
          Text(
            "ABSENSI IO",
            style: TextStyle(
                color: Color(0xFF003F63),
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "RaleWay"),
          ),
          Text(
            "PT Alamjaya Bara Pratama",
            style: TextStyle(
                color: Color(0xFF003F63),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "RaleWay"),
          )
        ],
      ),
    );
  }

  getPref(BuildContext context) async {
    var sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.getInt("isLogin") != null) {
      isLogin = sharedPref.getInt("isLogin")!;
    } else {
      isLogin = 0;
    }
  }

  serverStream() {
    _pingServer.stream.listen((bool isConnected) {
      if (mounted) {
        setState(() {
          isOnline = isConnected;
          if (kDebugMode) {
            print("isConnected $isConnected");
          }
        });
      }
    });
    _pingLokal.stream.listen((bool localConnected) {
      if (mounted) {
        setState(() {
          lokalOnline = localConnected;
          if (kDebugMode) {
            print("lokalOnline $lokalOnline");
          }
        });
      }
    });
    _pingServerOnline.stream.listen((bool onlineServer) {
      if (mounted) {
        setState(() {
          serverOnline = onlineServer;
          if (kDebugMode) {
            print("onlineServer $onlineServer");
          }
        });
      }
    });
  }

  pingServer() async {
    _pingServer.add(await Utils().pingServer());
    _pingServerOnline.add(await Utils().pingServerOnline());
    _pingLokal.add(await Utils().pingServerLokal());
    timerAddnew();
  }

  timerAddnew() async {
    _timer = Timer.periodic(_duration, (timer) async {
      _pingServer.add(await Utils().pingServer());
      _pingServerOnline.add(await Utils().pingServerOnline());
      _pingLokal.add(await Utils().pingServerLokal());
    });
  }

  reloadCekServer() {
    closePing();
    getPref(context);
    timerAddnew();
  }

  closePing() {
    isOnline = false;
    serverOnline = false;
    lokalOnline = false;
    _timer?.cancel();
  }

  Widget tombolKeluar() {
    return ElevatedButton(
        onPressed: () {
          SystemNavigator.pop();
        },
        child: const Text("Keluar"));
  }

  Widget testNotif() {
    return ElevatedButton(
        onPressed: () async {
          NotificationAPI.showNotification(title: "BORIS", body: "REYSON");
        },
        child: const Text("Test Notifikasi"));
  }

  @override
  void dispose() {
    closePing();
    super.dispose();
  }
}
