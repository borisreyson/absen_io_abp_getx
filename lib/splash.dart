import 'dart:async';

import 'package:face_id_plus/screens/auth/login.dart';
import 'package:face_id_plus/screens/auth/register.dart';
import 'package:face_id_plus/screens/pages/mainpage/absen_lokal.dart';
import 'package:face_id_plus/screens/pages/home.dart';
import 'package:face_id_plus/screens/pages/mainpage/home.dart';
import 'package:face_id_plus/services/notification.dart';
import 'package:face_id_plus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

int isLogin = 0;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final NetworkInfo _networkInfo = NetworkInfo();
  StreamController<bool> _pingServer = StreamController.broadcast();
  StreamController<bool> _pingLokal = StreamController.broadcast();
  StreamController<bool> _pingServerOnline = StreamController.broadcast();
  bool isOnline = false;
  bool lokalOnline = false;
  bool serverOnline = false;
  Timer? _timer;
  Duration _duration = Duration(seconds: 5);
  String? wifiBSSID;
  int isLogin = 0;
  @override
  void initState() {
    NotificationAPI.initNotif();
    pingServer();
    serverStream();
    getPref(context);
    super.initState();
  }

  _initNetworkInfo() async {
    try {} on PlatformException catch (e) {
      if (Platform.isIOS) {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _main();
  }

  Widget _main() {
    return Scaffold(
      body: SingleChildScrollView(
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
                SizedBox(
                  height: 40,
                ),
                (isOnline)
                    ? (isLogin == 1 && isLogin != null)
                        ? (serverOnline)
                            ? _lanjutOnline()
                            : offlineCheck()
                        : Container()
                    : offlineCheck(),
                (isOnline)
                    ? (isLogin == 0 && isLogin != null)
                        ? (serverOnline)
                            ? _submitButton()
                            : offlineCheck()
                        : Container()
                    : serverIsOffline(),
                const SizedBox(
                  height: 20,
                ),
                // _signUpButton(),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (!lokalOnline)
                        ? (serverOnline)
                            ? Text(
                                "Server : Online",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "Server : Offline",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                        : Text(
                            "Server : Online",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                (!lokalOnline)
                    ? (!serverOnline)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center()
                    : Center(),
                tombolKeluar(),
                // testNotif()
                // _label()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget offlineCheck() {
    return (lokalOnline)
        ? (isLogin == 1 && isLogin != null)
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
    var style = TextStyle(color: Colors.red);
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
        await Navigator.push(
                context, MaterialPageRoute(builder: (context) => AbsenLokal()))
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
      onTap: () {
        closePing();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const FormLogin()));
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
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
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
      isLogin = await sharedPref.getInt("isLogin")!;
      // if (isLogin == 1) {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => const HomePage()));
      // }
    } else {
      isLogin = 0;
    }
  }

  serverStream() {
    _pingServer.stream.listen((bool isConnected) {
      if (mounted) {
        setState(() {
          isOnline = isConnected;
          print("isConnected ${isConnected}");
        });
      }
    });
    _pingLokal.stream.listen((bool localConnected) {
      if (mounted) {
        setState(() {
          lokalOnline = localConnected;
          print("lokalOnline ${lokalOnline}");
        });
      }
    });
    _pingServerOnline.stream.listen((bool onlineServer) {
      if (mounted) {
        setState(() {
          serverOnline = onlineServer;
          print("onlineServer ${onlineServer}");
        });
      }
    });
  }

  pingServer() async {
    _pingServer.add(await Utils().pingServer());
    _pingLokal.add(await Utils().pingServerLokal());
    _pingServerOnline.add(await Utils().pingServerOnline());
    timerAddnew();
  }

  timerAddnew() async {
    _timer = Timer.periodic(_duration, (timer) async {
      _pingServer.add(await Utils().pingServer());
      _pingLokal.add(await Utils().pingServerLokal());
      _pingServerOnline.add(await Utils().pingServerOnline());
    });
  }

  reloadCekServer() {
    getPref(context);
    print("Login $isLogin");
    closePing();
    timerAddnew();
  }

  closePing() {
    isOnline = false;
    serverOnline = false;
    lokalOnline = false;
    _timer?.cancel();

    setState(() {});
  }

  Widget tombolKeluar() {
    return ElevatedButton(
        onPressed: () {
          SystemNavigator.pop();
        },
        child: Text("Keluar"));
  }

  Widget testNotif() {
    return ElevatedButton(
        onPressed: () async {
          NotificationAPI.showNotification(title: "BORIS", body: "REYSON");
        },
        child: Text("Test Notifikasi"));
  }
}
