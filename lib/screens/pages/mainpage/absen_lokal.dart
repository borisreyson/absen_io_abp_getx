import 'dart:io' show Platform;
import 'dart:ui' as ui;
import 'dart:async';
import 'package:face_id_plus/model/tigahariabsen.dart';
import 'package:face_id_plus/screens/pages/area.dart';
import 'package:face_id_plus/screens/pages/absensi/detail_absen_profile.dart';
import 'package:face_id_plus/screens/pages/page_menu.dart';
import 'package:flutter/material.dart';
import 'package:face_id_plus/model/last_absen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ios/masuk_ios.dart';
import '../ios/pulang_ios.dart';

class AbsenLokal extends StatefulWidget {
  const AbsenLokal({Key? key}) : super(key: key);

  @override
  State<AbsenLokal> createState() => _AbsenLokalState();
}

class _AbsenLokalState extends State<AbsenLokal> {
  bool serviceEnable = false, _enMasuk = false, _enPulang = false;
  bool outside = false;
  bool iosMapLocation = false;
  bool lokasiPalsu = false;
  int? isLogin = 0, showAbsen = 0;
  String? nama, nik, _jam_kerja, kode_roster, jamPulang, jamMasuk, id_roster;
  double? _masuk = 0.0, _pulang = 0.0;
  StreamController<bool> _getLokasi = StreamController.broadcast();
  StreamController<String> _streamClock = StreamController.broadcast();
  Widget loader = const Center(child: CircularProgressIndicator());

  Timer? _timer, _timerClock;
  String startClock = "00:00:00";
  int jamS = 0, menitS = 0, detikS = 0;
  JamServer? jam_server;
  @override
  void initState() {
    getPref(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (nik != null)
        ? _mainContent(nik!)
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _mainContent(String nik) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            splashColor: const Color(0xfff8f8f8f8),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xffffffff),
            ),
            onTap: () {
              Navigator.maybePop(context);
            },
          ),
          actions: <Widget>[
            (showAbsen == 1)
                ? IconButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AreaAbp()));
                    },
                    icon: const Icon(Icons.map_sharp),
                    color: Colors.white,
                  )
                : Container(),
            IconButton(
              onPressed: () async {
                await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const MenuPage()))
                    .then((value) => getPref(context));
              },
              icon: const Icon(Icons.menu),
              color: Colors.white,
            ),
          ],
          backgroundColor: const Color(0xFF21BFBD),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: _headerContent(nik));
  }

  Widget _headerContent(String nik) {
    return Stack(children: [_listAbsen(nik), topContent(), _contents()]);
  }

  Widget topContent() {
    return Container(
      height: 125,
      padding: const EdgeInsets.only(bottom: 55),
      color: const Color(0xFF21BFBD),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "$nama",
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 15.0),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "$nik",
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 15.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contents() {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
      color: const Color(0xFFF2E638),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _jamWidget(),
      ),
    );
  }

  Widget _jamWidget() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$startClock",
                style: const TextStyle(
                    color: Color(0xFF8C6A03),
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            (_jam_kerja != null)
                ? (kode_roster != "OFF")
                    ? "$_jam_kerja"
                    : ""
                : "",
            style: const TextStyle(color: Colors.black87),
          ),
        ),
        _btnAbsen(),
      ],
    );
  }

  @override
  void dispose() {
    closeStream();
    super.dispose();
  }

  Widget _btnAbsen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (_enMasuk)
            ? Expanded(
                child: Opacity(
                  opacity: _masuk!,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: const Text(
                        "Masuk",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _enMasuk
                          ? () async {
                              await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              (Platform.isIOS)
                                                  ? IosMasuk(
                                                      nik: nik!,
                                                      status: "Masuk",
                                                      lat: "0.0",
                                                      lng: "0.0",
                                                      id_roster: id_roster!,
                                                      jam_server: jam_server,
                                                    )
                                                  : IosMasuk(
                                                      nik: nik!,
                                                      status: "Masuk",
                                                      lat: "0.0",
                                                      lng: "0.0",
                                                      id_roster: id_roster!,
                                                      jam_server: jam_server,
                                                    )))
                                  .then((value) => getPref(context));
                            }
                          : null,
                    ),
                  ),
                ),
              )
            : Expanded(
                child: ElevatedButton(
                onPressed: null,
                child: Text("$jamMasuk"),
              )),
        (_enPulang)
            ? Expanded(
                child: Opacity(
                  opacity: _pulang!,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: const Text(
                        "Pulang",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _enPulang
                          ? () async {
                              await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => (Platform.isIOS)
                                              ? IosPulang(
                                                  nik: nik!,
                                                  status: "Pulang",
                                                  lat: "0.0",
                                                  lng: "0.0",
                                                  id_roster: id_roster!,
                                                  jam_server: jam_server,
                                                )
                                              : IosPulang(
                                                  nik: nik!,
                                                  status: "Pulang",
                                                  lat: "0.0",
                                                  lng: "0.0",
                                                  id_roster: id_roster!,
                                                  jam_server: jam_server,
                                                )))
                                  .then((value) => getPref(context));
                            }
                          : null,
                    ),
                  ),
                ),
              )
            : Expanded(
                child:
                    ElevatedButton(onPressed: null, child: Text("$jamPulang")))
      ],
    );
  }

  Widget _listAbsen(String nik) {
    return Container(
        margin: EdgeInsets.only(top: 215),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 200,
        child: FutureBuilder(
            future: _loadTigaHari(nik),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<AbsenTigaHariModel> _absensi = snapshot.data;
                return ListView(
                    children: _absensi.map((ab) => _cardAbsen(ab)).toList());
              } else {
                return loader;
              }
            }));
  }

  Widget _cardAbsen(AbsenTigaHariModel _absen) {
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tgl = DateTime.parse("${_absen.tanggal}");
    TextStyle _style = const TextStyle(fontSize: 12, color: Colors.white);
    return Card(
      elevation: 10,
      shadowColor: Colors.black87,
      color: (_absen.status == "Masuk") ? Colors.green : Colors.red,
      child: InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => DetailProfile(
                        absenTigaHariModel: _absen,
                      )))).then((value) => _loadTigaHari(nik!));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageResolve(_absen.gambar!),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama!, style: _style),
                Text("${_absen.status}", style: _style),
                Text(fmt.format(tgl), style: _style),
                Text("${_absen.jam}", style: _style),
                Text("${_absen.nik}", style: _style),
                Text("${_absen.lupa_absen}", style: _style),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageResolve(String gambar) {
    NetworkImage image = NetworkImage(gambar);
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
          image: DecorationImage(
            image: image,
            fit: BoxFit.fitWidth,
          ),
          color: Colors.white),
    );
  }

  getPref(BuildContext context) async {
    var sharedPref = await SharedPreferences.getInstance();
    isLogin = sharedPref.getInt("isLogin");
    if (isLogin != null) {
      if (isLogin == 1) {
        nama = sharedPref.getString("nama");
        nik = sharedPref.getString("nik");
        showAbsen = sharedPref.getInt("show_absen");
        loadLastAbsen(nik!);
      } else {
        nama = "";
        nik = "";
        Navigator.pop(context);
      }
      setState(() {});
    } else {
      Navigator.pop(context);
    }
  }

  loadLastAbsen(String _nik) async {
    var lastAbsen = await LastAbsen.apiAbsenTigaHariOffline(_nik);
    if (lastAbsen != null) {
      _jam_kerja = lastAbsen.jamKerja;
      kode_roster = lastAbsen.kodeRoster;
      id_roster = "${lastAbsen.idRoster}";
      if (lastAbsen.lastAbsen != null) {
        var absenTerakhir = lastAbsen.lastAbsen;
        var jamAbsen = lastAbsen.presensiMasuk;
        if (absenTerakhir == "Masuk") {
          if (lastAbsen.lastNew == "Pulang") {
            outside = false;
            _masuk = 1.0;
            _enMasuk = true;
            _enPulang = false;
            _pulang = 0.0;
            jamPulang = "${jamAbsen?.jam}";
            jamMasuk = "";
          } else {
            jamMasuk = "${jamAbsen?.jam}";
            jamPulang = "";
            outside = false;
            _enMasuk = false;
            _enPulang = true;
            _masuk = 0.0;
            _pulang = 1.0;
          }
        } else if (absenTerakhir == "Pulang") {
          jamMasuk = "";
          jamPulang = "";
          outside = false;
          _enMasuk = true;
          _enPulang = false;
          _masuk = 1.0;
          _pulang = 0.0;
        }
      } else {
        jamMasuk = "";
        jamPulang = "";
        _enMasuk = true;
        outside = false;
        _enPulang = false;
        _masuk = 1.0;
        _pulang = 0.0;
      }
      if (lastAbsen.jamServer != null) {
        jam_server = lastAbsen.jamServer;
        print("JamServer ${jam_server?.menit}");
        jamS = int.parse("${jam_server?.jam}");
        menitS = int.parse("${jam_server?.menit}");
        detikS = int.parse("${jam_server?.detik}");
        streamJam();
      }
    }
    setState(() {});
  }

  Future<List<AbsenTigaHariModel>> _loadTigaHari(String nik) async {
    var absensi = await AbsenTigaHariModel.apiAbsenTigaHariOffline(nik);
    return absensi;
  }

  String doJam() {
    if (detikS >= 59) {
      if (menitS >= 59) {
        if (jamS >= 23) {
          jamS = 00;
          menitS = 00;
          detikS = 00;
        } else {
          jamS = jamS + 1;
          menitS = 00;
          detikS = 00;
        }
      } else {
        menitS = menitS + 1;
        detikS = 00;
      }
    } else {
      detikS = detikS + 1;
    }
    return "${jamS.toString().padLeft(2, "0")}:${menitS.toString().padLeft(2, "0")}:${detikS.toString().padLeft(2, "0")}";
  }

  streamJam() {
    createJamStream();
    _streamClock.add(doJam());
    _timerClock = Timer.periodic(Duration(seconds: 1), (timer) {
      _streamClock.add(doJam());
    });
  }

  createJamStream() {
    _streamClock.stream.listen((String jam) {
      if (jam != null) {
        if (mounted) {
          setState(() {
            startClock = jam;
          });
        }
      }
    });
  }

  closeStream() {
    _timerClock?.cancel();
    _timer?.cancel();
  }
}
