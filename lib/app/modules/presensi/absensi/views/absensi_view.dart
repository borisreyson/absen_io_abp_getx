import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/absentigahari_model.dart';
import '../controllers/absensi_controller.dart';

// ignore: must_be_immutable
class AbsensiView extends GetView<AbsensiController> {
  AbsensiView({Key? key}) : super(key: key);
  Widget loader = const Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back(result: false);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () async {
                  bool res = await Get.toNamed('/profile');
                  if (res) {
                    Get.offAllNamed('/login-absen');
                  }
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ))
          ],
          title: Text(
            controller.nama.value,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: false,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            contentBody(context),
            absenImage(context),
          ],
        ),
      ),
    );
  }

  Widget contentBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: gogleMap(context),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: jam(context),
        ),
      ],
    );
  }

  Widget jam(context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 10,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.rosterKerja.value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(controller.tanggal.value),
            ],
          ),
        ),
        Text(
          controller.startClock.value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 0.1,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(controller.jamKerja.value),
        ),
        Container(
          height: 0.2,
          color: Colors.black,
        ),
        (controller.outside.value)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 11, 143, 22)),
                        onPressed: () async {
                          var res = await Get.toNamed('/absen-masuk',
                              arguments: controller.serverJam.value);
                        },
                        child: const Text("MASUK"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 190, 36, 25)),
                        onPressed: () async {
                          var res = await Get.toNamed('/absen-pulang',
                              arguments: controller.serverJam.value);
                        },
                        child: const Text("Pulang"),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Anda Di Luar PT ALAMJAYA BARA PRATAMA",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
      ]),
    );
  }

  gogleMap(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: GoogleMap(
        initialCameraPosition: controller.kGooglePlex.value,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController _controller) async {
          controller.googleMapController = _controller;
          controller.mapController.complete(_controller);
          controller.streamLokasi();
        },
        markers: controller.markers,
        polygons: Set<Polygon>.of(controller.polygons),
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
      ),
    );
  }

  Widget absenImage(context) {
    var fmt = DateFormat("dd MMMM yyyy");
    return Positioned(
      bottom: 10,
      left: 10,
      child: InkWell(
        onTap: () {
          btmSheet(context);
          if (kDebugMode) {
            print("Tapped");
          }
        },
        child: Column(
          children: [
            Visibility(
              visible: (controller.masuk.value.status != null),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: const Color.fromARGB(255, 8, 120, 11),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          color: Colors.grey.shade200,
                          width: 60,
                          height: 60,
                          child: Image.network(
                            "https://abpjobsite.com/face_id/${controller.nik}/${controller.masuk.value.gambar}",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.masuk.value.status}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              (controller.masuk.value.tanggal != null)
                                  ? fmt.format(DateTime.parse(
                                      "${controller.masuk.value.tanggal}"))
                                  : "",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${controller.masuk.value.jam}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: (controller.pulang.value.status != null),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: const Color.fromARGB(255, 177, 29, 18),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          color: Colors.grey.shade200,
                          width: 50,
                          height: 50,
                          child: Image.network(
                            "https://abpjobsite.com/face_id/${controller.nik}/${controller.pulang.value.gambar}",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.pulang.value.status}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${controller.pulang.value.jam}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  btmSheet(context) {
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
      future: controller.loadTigaHari(controller.nik.value),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<AbsenTigaHariModel> _absensi = snapshot.data;
          if (_absensi.isNotEmpty) {
            return Stack(
              children: [
                Card(
                  margin: const EdgeInsets.only(top: 40),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                    child: ListView(
                        children: _absensi
                            .map((ab) => _cardAbsen(ab, context))
                            .toList()),
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
          margin: const EdgeInsets.only(top: 40),
          child: loader,
          color: Colors.white,
        );
      },
    );
  }

  Widget _cardAbsen(AbsenTigaHariModel _absen, context) {
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tgl = DateTime.parse("${_absen.tanggal}");
    TextStyle _style = const TextStyle(fontSize: 12, color: Colors.white);
    return Card(
      elevation: 10,
      shadowColor: Colors.black87,
      color: (_absen.status == "Masuk") ? Colors.green : Colors.red,
      child: InkWell(
        onTap: () {},
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
                  Text(controller.nama.value, style: _style),
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
}
