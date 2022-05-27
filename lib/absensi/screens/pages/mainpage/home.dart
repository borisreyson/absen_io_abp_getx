import 'dart:async';
import 'dart:io' show Platform;
import 'dart:typed_data';
import 'package:face_id_plus/absensi/model/last_absen.dart';
import 'package:face_id_plus/absensi/model/map_area.dart';
import 'package:face_id_plus/absensi/model/tigahariabsen.dart';
import 'package:face_id_plus/absensi/screens/pages/absensi/detail_absen_profile.dart';
import 'package:face_id_plus/absensi/screens/pages/absensi/kamera/masuk.dart';
import 'package:face_id_plus/absensi/screens/pages/absensi/kamera/pulang.dart';
import 'package:face_id_plus/absensi/screens/pages/area.dart';
import 'package:face_id_plus/absensi/screens/pages/page_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as iosLocation;
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:shared_preferences/shared_preferences.dart';

class HomePageAndroid extends StatefulWidget {
  const HomePageAndroid({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageAndroid> {
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(-0.5634222, 117.0139606), zoom: 14.2746);
  final _map_controller = Completer();
  late GoogleMapController _googleMapController;
  bool serviceEnable = false, _enMasuk = false, _enPulang = false;
  Position? position;
  late Position currentPosition;
  LatLng? myLocation;
  bool outside = false;
  bool iosMapLocation = false;
  bool lokasiPalsu = false;
  double _diluarAbp = 0.0;
  int? isLogin = 0, showAbsen = 0;
  String? nama, nik, _jam_kerja, kode_roster, jamPulang, jamMasuk, id_roster;
  double? _masuk = 0.0, _pulang = 0.0;
  late handler.PermissionStatus _permissionStatus;
  late final handler.Permission _permission = handler.Permission.location;
  late BitmapDescriptor customIcon;
  ui.Codec? codec;
  late Set<Marker> markers = {};
  late Marker marker;
  final markerID = MarkerId("abpenergy");
  Uint8List? markerIcon;
  StreamController<bool> _getLokasi = StreamController.broadcast();
  StreamController<String> _streamClock = StreamController.broadcast();
  Timer? _timer, _timerClock;
  String startClock = "00:00:00";
  int jamS = 0, menitS = 0, detikS = 0;
  bool permanenDitolak = false;
  bool statusLokasi = false;
  Widget loader = const Center(child: CircularProgressIndicator());
  Presensi? jamAbsen, jamAbsenPulang;
  String? _tanggal;
  JamServer? jam_server;
  @override
  void initState() {
    getPref(context);
    setCustomMapPin();
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    DateTime now = DateTime.now();
    _tanggal = fmt.format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _mainContent();
  }

  Widget _mainContent() {
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
                          builder: (BuildContext context) => const MenuPage()))
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
      body: FutureBuilder<List<MapAreModel>>(
        future: _loadArea(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<LatLng> pointAbp = [];
            List<MapAreModel> data = snapshot.data;
            for (var p in data) {
              pointAbp.add(LatLng(p.lat!, p.lng!));
            }
            if (myLocation != null) {
              bool _insideAbp = _checkIfValidMarker(myLocation!, pointAbp);
              if (_insideAbp) {
                _diluarAbp = 0.0;
                outside = true;
              } else {
                outside = false;
                _diluarAbp = 1.0;
              }
            }
            return _headerContent(pointAbp);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _headerContent(List<LatLng> pointABP) {
    return Stack(children: [googleMaps(pointABP), topContent(), _contents()]);
  }

  Widget mapABP() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
            onPressed: () async {
              closeStream();
              await _googleMapController
                  .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
            },
            child: const Text("Lokasi ABP")),
      ),
    );
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
          child: Column(
            children: [
              roster(),
              Row(
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
        (serviceEnable)
            ? (outside)
                ? _btnAbsen()
                : diluarArea()
            : diluarArea(),
      ],
    );
  }

  Widget diluarArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Opacity(
                opacity: _diluarAbp,
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                          child: Column(
                        children: const [
                          Text(
                            "Anda Diluar Area",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            "PT Alamjaya Bara Pratama",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ))),
                )))
      ],
    );
  }

  @override
  void dispose() {
    codec?.dispose();
    markers.clear();
    // if(_googleMapController!=null){
    // _googleMapController.dispose();
    // }
    closeStream();
    closJam();
    super.dispose();
  }

  Widget googleMaps(List<LatLng> pointABP) {
    List<Polygon> _polygons = [];
    _polygons.add(Polygon(
        polygonId: const PolygonId("ABP"),
        points: pointABP,
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.green.withOpacity(0.25)));

    return Container(
      margin: EdgeInsets.only(top: 215),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: (serviceEnable)
          ? Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) async {
                    _map_controller.complete(controller);
                    _googleMapController = await controller;
                    if (_googleMapController != null) {
                      if (markerID != null) {
                        _googleMapController.showMarkerInfoWindow(markerID);
                      }
                      streamLokasi();
                    }
                  },
                  polygons: Set<Polygon>.of(_polygons),
                  markers: markers,
                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                lokasiSaya(),
                mapABP(),
                btnListAbsen()
              ],
            )
          : enableGPS(),
    );
    ;
  }

  Widget btnListAbsen() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 10),
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 77,
              height: 160,
              child: InkWell(
                onTap: (() => btmSheet()),
                child: ListView(
                  children: [
                    Visibility(
                      visible: (jamAbsen != null) ? true : false,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              "https://abpjobsite.com/face_id/$nik/${jamAbsen?.gambar}",
                              fit: BoxFit.fill,
                              height: 70,
                            )),
                      ),
                    ),
                    Visibility(
                      visible: (jamAbsenPulang != null) ? true : false,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              "https://abpjobsite.com/face_id/$nik/${jamAbsenPulang?.gambar}",
                              fit: BoxFit.fill,
                              height: 70,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  btmSheet() {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return lastAbsenTigaHari();
        });
  }

  Widget lastAbsenTigaHari() {
    return FutureBuilder(
      future: _loadTigaHari(nik),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<AbsenTigaHariModel> _absensi = snapshot.data;
          if (_absensi.isNotEmpty) {
            return Stack(
              children: [
                Card(
                  margin: EdgeInsets.only(top: 40),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                    child: ListView(
                        children:
                            _absensi.map((ab) => _cardAbsen(ab)).toList()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                        )),
                  ),
                )
              ],
            );
          }
        }
        return Card(
          margin: EdgeInsets.only(top: 40),
          child: loader,
          color: Colors.white,
        );
      },
    );
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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => DetailProfile(
                        absenTigaHariModel: _absen,
                      ))));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageResolve(_absen.gambar!),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
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
              ),
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
          Text("$_tanggal"),
        ],
      ),
    );
  }

  Widget lokasiSaya() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(150),
            ),
            child: InkWell(
              onTap: () {
                closeStream();
                streamLokasi();
              },
              customBorder: CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.gps_fixed),
              ),
            )),
      ),
    );
  }

  Future<List<AbsenTigaHariModel>> _loadTigaHari(String? nik) async {
    var absensi = await AbsenTigaHariModel.apiAbsenTigaHari(nik);
    return absensi;
  }

  Widget enableGPS() {
    return ListView(
      children: <Widget>[
        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              "GPS",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Center(child: Text("GPS anda Masih Mati.")),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
                "Aplikasi membutuhkan Lokasi anda untuk mengetahui apakah anda berada di dalam area yang di tentukan!"),
          ),
        ),
        Center(
            child: Image.asset(
          "assets/images/abp_maps.png",
          width: 200,
          height: 200,
        )),
        const Center(child: Text("Area Lokasi yang dimaksud")),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                bool reqService = await iosLocation.Location().requestService();
                if (reqService) {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePageAndroid()));
                }
              },
              child: const Text("Aktifkan Lokasi?")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                appClose();
              },
              child: const Text("Tidak, Keluar!")),
        ),
      ],
    );
  }

  Widget izinLokasi() {
    return ListView(
      children: <Widget>[
        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              "GPS",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Center(child: Text("Izin Lokasi (GPS) Tidak Ada.")),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
                "Aplikasi membutuhkan Lokasi anda untuk mengetahui apakah anda berada di dalam area yang di tentukan!"),
          ),
        ),
        Center(
            child: Image.asset(
          "assets/images/abp_maps.png",
          width: 200,
          height: 200,
        )),
        const Center(child: Text("Area Lokasi yang dimaksud")),
        (permanenDitolak)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      var lokasi =
                          await handler.Permission.locationWhenInUse.status;
                      if (lokasi.isPermanentlyDenied) {
                        await handler.openAppSettings();
                      }
                    },
                    child: const Text("Buka Pengaturan")),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      var lokasi =
                          await handler.Permission.locationWhenInUse.status;
                      if (!lokasi.isGranted) {
                        await handler.Permission.locationWhenInUse.request();
                      }
                    },
                    child: const Text("Minta Izin?")),
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return appClose();
                    });
              },
              child: const Text("Tidak, Keluar!")),
        ),
      ],
    );
  }

  Widget appClose() {
    return AlertDialog(
      title: const Text('Lokasi'),
      content: const Text('Aplikasi Fake Gps / Lokasi Palsu Dideteksi!'),
      actions: <Widget>[
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: const Text('Keluar'),
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
                                                      lat:
                                                          "${myLocation?.latitude}",
                                                      lng:
                                                          "${myLocation?.longitude}",
                                                      id_roster: id_roster!,
                                                      jam_server: jam_server,
                                                    )
                                                  : IosMasuk(
                                                      nik: nik!,
                                                      status: "Masuk",
                                                      lat:
                                                          "${myLocation?.latitude}",
                                                      lng:
                                                          "${myLocation?.longitude}",
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
                                              lat: "${myLocation?.latitude}",
                                              lng: "${myLocation?.longitude}",
                                              id_roster: id_roster!,
                                              jam_server: jam_server,
                                            )
                                          : IosPulang(
                                              nik: nik!,
                                              status: "Pulang",
                                              lat: "${myLocation?.latitude}",
                                              lng: "${myLocation?.longitude}",
                                              id_roster: id_roster!,
                                              jam_server: jam_server,
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

  Future<bool> locatePosition() async {
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (serviceEnable) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition = position!;
      myLocation = LatLng(currentPosition.latitude, currentPosition.longitude);
      lokasiPalsu = position!.isMocked;

      if (myLocation != null) {
        if (!iosMapLocation) {
          iosMapLocation = true;
        }

        return true;
      } else {
        return false;
      }
    } else {
      outside = false;
      _diluarAbp = 1.0;
      return false;
    }
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
    } else {
      Navigator.pop(context);
    }
  }

  loadLastAbsen(String _nik) async {
    _diluarAbp = 1.0;
    // outside = false;
    var lastAbsen = await LastAbsen.apiAbsenTigaHari(_nik);
    if (lastAbsen != null) {
      _jam_kerja = lastAbsen.jamKerja;
      kode_roster = lastAbsen.kodeRoster;
      id_roster = "${lastAbsen.idRoster}";
      if (lastAbsen.lastAbsen != null) {
        var absenTerakhir = lastAbsen.lastAbsen;
        jamAbsen = lastAbsen.presensiMasuk;
        jamAbsenPulang = lastAbsen.presensiPulang;
        if (absenTerakhir == "Masuk") {
          if (lastAbsen.lastNew == "Pulang") {
            outside = false;
            _masuk = 1.0;
            _enMasuk = true;
            _enPulang = false;
            _pulang = 0.0;
            jamPulang = "${jamAbsenPulang?.jam}";
            jamMasuk = "";
          } else {
            jamMasuk = "${jamAbsen?.jam}";
            jamPulang = "${jamAbsenPulang?.jam}";
            outside = false;
            _enMasuk = false;
            _enPulang = true;
            _masuk = 0.0;
            _pulang = 1.0;
          }
        } else if (absenTerakhir == "Pulang") {
          jamMasuk = "${jamAbsen?.jam}";
          jamPulang = "${jamAbsenPulang?.jam}";
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
        setState(() {
          jam_server = lastAbsen.jamServer;
        });
        jamS = int.parse("${jam_server?.jam}");
        menitS = int.parse("${jam_server?.menit}");
        detikS = int.parse("${jam_server?.detik}");
        // startClock = "${jamS.toString().padLeft(2,"0")}:${menitS.toString().padLeft(2,"0")}:${detikS.toString().padLeft(2,"0")}";
        streamJam();
      }
    }
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
    _timerClock?.cancel();
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

  Future<List<MapAreModel>> _loadArea() async {
    await cekGps();
    _permissionStatus = await _permission.status;
    var area = await MapAreModel.mapAreaApi("0");
    return area;
  }

  bool _checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }

  cekGps() async {
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (serviceEnable) {
    } else {
      closeStream();
    }
  }

  void setCustomMapPin() async {
    markerIcon = await getBytesFromAsset('assets/images/abp_60x60.png', 60);
    customIcon = await BitmapDescriptor.fromBytes(markerIcon!);
    marker = Marker(
      markerId: markerID,
      position: const LatLng(-0.5634222, 117.0139606),
      icon: customIcon,
      infoWindow: const InfoWindow(
        title: 'PT Alamjaya Bara Pratama',
      ),
    );
    markers.add(marker);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec!.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  streamLokasi() async {
    createStream();
    _getLokasi.add(await locatePosition());
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      _getLokasi.add(await locatePosition());
    });
  }

  createStream() {
    _getLokasi.stream.listen((bool e) async {
      if (e) {
        if (mounted) {
          setState(() {});
          if (lokasiPalsu == true) {
            closeStream();
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return appClose();
                });
          } else {
            if (serviceEnable) {
              CameraPosition cameraPosition =
                  CameraPosition(target: myLocation!, zoom: 17.5756);
              await _googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
            }
          }
        }
      }
    });
  }

  closeStream() {
    _timer?.cancel();
    // _getLokasi.close();
  }

  closJam() {
    _timerClock?.cancel();
  }

  izinTidakAda() async {
    var lokasi = await handler.Permission.locationWhenInUse;
    var status = await lokasi.status;
    if (status == handler.PermissionStatus.granted) {
      statusLokasi = true;
      permanenDitolak = false;
    } else if (status == handler.PermissionStatus.denied) {
      statusLokasi = false;
      permanenDitolak = false;
    } else if (status == handler.PermissionStatus.permanentlyDenied) {
      statusLokasi = false;
      permanenDitolak = true;
    }
  }
}
