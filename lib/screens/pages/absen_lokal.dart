import 'dart:io' show Platform;
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:face_id_plus/model/last_absen.dart';
import 'package:face_id_plus/model/face_login_model.dart';
import 'package:face_id_plus/model/tigahariabsen.dart';
import 'package:face_id_plus/screens/pages/absen_lokal.dart';
import 'package:face_id_plus/screens/pages/detail_absen_profile.dart';
import 'package:face_id_plus/screens/pages/lihat_absensi.dart';
import 'package:face_id_plus/splash.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ios/masuk_ios.dart';
import 'ios/pulang_ios.dart';

class AbsenLokal extends StatefulWidget {
  const AbsenLokal({ Key? key }) : super(key: key);

  @override
  State<AbsenLokal> createState() => _AbsenLokalState();
}

class _AbsenLokalState extends State<AbsenLokal> {

  String? jamMasuk;
  String? jamPulang;
  bool _enMasuk = false;
  bool _enPulang = false;
  bool permanenDitolak = false;
  double _masuk = 0.0;
  double _pulang = 0.0;

  String? _jam;
  String? _menit;
  String? _detik;
  String? _tanggal;
  String? _nama, _nik;
  String? _jam_kerja;
  String? id_roster;
  String? connStat;
  String? kode_roster;

  late String nama;
  late String nik;
  late int _showAbsen;
  Widget loader = const Center(child: CircularProgressIndicator());

  void initState() {
    _nama = "";
    _nik = "";
    _jam = "";
    _menit = "";
    _detik = "";
    jamMasuk = "";
    jamPulang = "";
    kode_roster = "";
    
    getPref(context);
    _getPref();
    nik = "";
    _showAbsen = 0;

    super.initState();
  }

  String getTgl() {
      var tgl = DateTime.now();
      return DateFormat("dd MMMM yyyy").format(tgl);
  }
  
  String getSystemTime() {
      var now = DateTime.now();
      return DateFormat("HH:mm:ss").format(now);
  }
  @override
  Widget build(BuildContext context) {
    return _mainContent();
  }

Widget _mainContent() {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LihatAbsen()));
            },
            icon: const Icon(Icons.menu),
            color: Colors.white,
          ),
        ],
        backgroundColor: const Color(0xFF21BFBD),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: <Widget>[
          (Platform.isAndroid) ? _headerContent() : _headerIos(),
          const SizedBox(height: 8),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Absen 3 Hari Terakhir", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          Container(
            width: 450,
            height: 473,
            child: _topContent()),
        ],
      ),
    );
  }

  Widget _headerContent() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.only(bottom: 55),
          color: const Color(0xFF21BFBD),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "$_nama",
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
                      "$_nik",
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
        ),
        _contents(),
      ]),
    );
  }

   Widget _headerIos() {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.only(bottom: 55),
        color: const Color(0xFF21BFBD),
        child: Column(
          children: <Widget>[
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Selamat Datang,",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    "$_nama",
                    style: const TextStyle(
                        fontFamily: 'Montserrat', color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Text(
                    "$_nik",
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
      ),
      _contents(),
    ]);
  }

  Widget _contents() {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
      color: const Color(0xFFF2E638),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            roster(),
            _jamWidget(),
            _btnAbsen(),
          ],
        ),
      ),
    );
  }

  Widget roster() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Jadwal",
                style: TextStyle(color: Colors.black87),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "$kode_roster",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          Text("${getTgl()}"),
        ],
      ),
    );
  }

  Widget _jamWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                         return  Text("${getSystemTime()}", 
                                 style: 
                                 TextStyle(
                                   fontWeight: FontWeight.bold, 
                                   fontSize: 25,
                                   color: Color(0xFF8C6A03),));
                }
              ),       
            ],
          ),
        ),
        Center(
          child: Text(
            (_jam_kerja != null) ? "$_jam_kerja" : 
            "Jam Kerja",
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _jamIos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                         return  Text("${getSystemTime()}", 
                                 style: 
                                 TextStyle(
                                   fontWeight: FontWeight.bold, 
                                   fontSize: 25,
                                   color: Color(0xFF8C6A03),));
                }
              ),       
            ],
          ),
        ),
        Center(
          child: Text(
            "$_tanggal",
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _btnAbsen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (_enMasuk)
            ? Expanded(
                child: Opacity(
                  opacity: _masuk,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: const Text(
                        "Masuk",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _enMasuk
                          ? () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              (Platform.isIOS)
                                                  ? IosMasuk(
                                                      nik: _nik!,
                                                      status: "Masuk",
                                                      lat: "0",
                                                      lng: "0",
                                                      id_roster: id_roster!,
                                                    )
                                                  : IosMasuk(
                                                      nik: _nik!,
                                                      status: "Masuk",
                                                      lat: "0",
                                                      lng: "0",
                                                      id_roster: id_roster!,
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
                  opacity: _pulang,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: const Text(
                        "Pulang",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _enPulang
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => (Platform.isIOS)
                                          ? IosPulang(
                                              nik: _nik!,
                                              status: "Pulang",
                                              lat: "0",
                                              lng: "0",
                                              id_roster: id_roster!,
                                            )
                                          : IosPulang(
                                              nik: _nik!,
                                              status: "Pulang",
                                              lat: "0",
                                              lng: "0",
                                              id_roster: id_roster!,
                                            ))).then(
                                  (value) => getPref(context));
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

  Widget _topContent() {
    return FutureBuilder(
        future: _getPref(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              Datalogin fUsers = Datalogin();
              fUsers = snapshot.data;
              nik = fUsers.nik!;
              _showAbsen = fUsers.showAbsen!;
              return Stack(
                children: [
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: ListView(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: _contentAbsensi()),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //_bottomContent()
                ],
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        });
  }

  Widget _contentAbsensi() {
    return FutureBuilder(
        future: _loadTigaHari(nik),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              List<AbsenTigaHariModel> _absensi = snapshot.data;
              print("NIK $nik");
              if (_absensi.isNotEmpty) {
                return Column(
                    children: _absensi.map((ab) => _cardAbsen(ab)).toList());
              }
              return loader;
            case ConnectionState.waiting:
              return loader;
            default:
              return loader;
          }
        });
  }  

  Widget _cardAbsen(AbsenTigaHariModel _absen) {
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tgl = DateTime.parse("${_absen.tanggal}");
    TextStyle _style = const TextStyle(fontSize: 12, color: Colors.white);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black87,
        color: (_absen.status == "Masuk") ? Colors.green : Colors.red,
        child: InkWell(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: ( (context) => AbsenLokal(
                
            //   ))));
             Navigator.push(context, MaterialPageRoute(builder: ( (context) => DetailProfile(
                absenTigaHariModel: _absen,
              ))));
          },
          child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageResolve(_absen.gambar!),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text(nama, style: _style),
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
    isLogin = sharedPref.getInt("isLogin")!;
    if (isLogin == 1) {
      _nama = sharedPref.getString("nama");
      _nik = sharedPref.getString("nik");
      int? showAbsen = sharedPref.getInt("show_absen");
      loadLastAbsen(_nik!);
    } else {
      _nama = "";
      _nik = "";
    }
  }

  loadLastAbsen(String _nik) async {
    var lastAbsen = await LastAbsen.apiAbsenTigaHari(_nik);
    if (lastAbsen != null) {
      _jam_kerja = lastAbsen.jamKerja;
      kode_roster = lastAbsen.kodeRoster;
      id_roster = "${lastAbsen.idRoster}";
      if (lastAbsen.lastAbsen != null) {
        var absenTerakhir = lastAbsen.lastAbsen;
        var jamAbsen = lastAbsen.presensiMasuk;
        if (absenTerakhir == "Masuk") {
          if (lastAbsen.lastNew == "Pulang") {
            _masuk = 1.0;
            _pulang = 0.0;
            _enMasuk = true;
            _enPulang = false;
            jamPulang = "${jamAbsen?.jam}";
            jamMasuk = "";
          } else {
            jamMasuk = "${jamAbsen?.jam}";
            jamPulang = "";
            _enMasuk = false;
            _enPulang = true;
            _masuk = 0.0;
            _pulang = 1.0;
          }
        } else if (absenTerakhir == "Pulang") {
          jamMasuk = "";
          jamPulang = "";
          _enMasuk = true;
          _enPulang = false;
          _masuk = 1.0;
          _pulang = 0.0;
        }
      } else {
        jamMasuk = "";
        jamPulang = "";
        _enMasuk = true;
        _enPulang = false;
        _masuk = 1.0;
        _pulang = 0.0;
      
      }
    }
  }

  Future<Datalogin> _getPref() async {
    Datalogin _users = Datalogin();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    nama = _pref.getString("nama").toString();
    String nik = _pref.getString("nik").toString();
    String devisi = _pref.getString("devisi").toString();
    int? _showAbsen = _pref.getInt("show_absen");
    _users.nama = nama;
    _users.nik = nik;
    _users.devisi = devisi;
    print("showAbsen $_showAbsen");

    _users.showAbsen = (_showAbsen==null)?0:_showAbsen;

    return _users;
  }

  Future<List<AbsenTigaHariModel>> _loadTigaHari(String nik) async {
    var absensi = await AbsenTigaHariModel.apiAbsenTigaHari(nik);
    print("Ini ${nik}");
    return absensi;
  }


}