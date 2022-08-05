import 'package:cached_network_image/cached_network_image.dart';
import 'package:face_id_plus/app/data/models/list_presensi_models.dart';
import 'package:face_id_plus/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../controllers/absensi_controller.dart';

// ignore: must_be_immutable
class AbsensiView extends GetView<AbsensiController> {
  AbsensiView({Key? key}) : super(key: key);
  Widget loader = const Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          Future.delayed(Duration(seconds: 1), () async {
            await controller.closeStream();
          });
          return true;
        },
        child: Scaffold(
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
                    var res = await Get.toNamed(Routes.PROFILE);
                    if (res != null) {
                      if (res) {
                        Get.offAllNamed('/login-absen');
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ))
            ],
            title: Text(
              "${controller.nama.value}",
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
                "${controller.rosterKerja.value}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${controller.tanggal.value}"),
            ],
          ),
        ),
        Text(
          "${controller.startClock.value}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 0.1,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${controller.jamKerja.value}"),
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
                        onPressed: (controller.absenTerakhir.value == "Masuk")
                            ? () async {
                                var res = await Get.toNamed(Routes.ABSEN_MASUK,
                                    arguments: {
                                      "jam": controller.serverJam.value,
                                      "lokasi": controller.myLocation
                                    });
                                controller.closeStream();
                                controller.getPref();
                                controller.streamLokasi();
                              }
                            : null,
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
                        onPressed: (controller.absenTerakhir.value == "Pulang")
                            ? () async {
                                var res = await Get.toNamed(Routes.ABSEN_MASUK,
                                    arguments: {
                                      "jam": controller.serverJam.value,
                                      "lokasi": controller.myLocation
                                    });
                                controller.closeStream();
                                controller.getPref();
                                controller.streamLokasi();
                              }
                            : null,
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
      height: MediaQuery.of(context).size.height / 1.55,
      child: GoogleMap(
        initialCameraPosition: controller.kGooglePlex.value,
        mapType: MapType.normal,
        onMapCreated: controller.onMapCreated,
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
              visible: (controller.presensi.value.checkin != null),
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
                          child: CachedNetworkImage(
                            placeholder: (contex, url) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  size: 95,
                                  color: Color.fromARGB(255, 235, 104, 95),
                                ),
                              );
                            },
                            imageUrl:
                                "https://abpjobsite.com/face_id/${controller.nik}/${controller.presensi.value.faceIn}",
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
                              (controller.presensi.value.checkin != null)
                                  ? "Masuk"
                                  : "Pulang",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              (controller.presensi.value.tanggal != null)
                                  ? fmt.format(DateTime.parse(
                                      "${controller.presensi.value.tanggal}"))
                                  : "",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${controller.presensi.value.checkin}",
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
              visible: (controller.presensi.value.checkout != null),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Color.fromARGB(255, 120, 8, 8),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          color: Colors.grey.shade200,
                          width: 60,
                          height: 60,
                          child: CachedNetworkImage(
                            placeholder: (contex, url) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  size: 95,
                                  color: Color.fromARGB(255, 235, 104, 95),
                                ),
                              );
                            },
                            imageUrl:
                                "https://abpjobsite.com/face_id/${controller.nik}/${controller.presensi.value.faceOut}",
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
                              (controller.presensi.value.checkout != null)
                                  ? "Pulang"
                                  : "Masuk",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              (controller.presensi.value.tanggal != null)
                                  ? fmt.format(DateTime.parse(
                                      "${controller.presensi.value.tanggal}"))
                                  : "",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${controller.presensi.value.checkout}",
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
          ListPresensiModels absensi = snapshot.data;
          if (absensi != null) {
            List<ListPresensi>? presensi = absensi.listPresensi;
            if (presensi!.isNotEmpty) {
              print("presensi ${presensi}");

              return Stack(
                children: [
                  Card(
                    margin: const EdgeInsets.only(top: 40),
                    color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 8, right: 8),
                      child: ListView(
                          children: presensi
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
            } else {
              return Container();
            }
          }
        }
        return Card(
          margin: const EdgeInsets.only(top: 40),
          color: Colors.white,
          child: loader,
        );
      },
    );
  }

  Widget _cardAbsen(ListPresensi absen, context) {
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tgl = DateTime.parse("${absen.tanggal}");
    TextStyle style = const TextStyle(fontSize: 12, color: Colors.white);
    return Column(
      children: [
        Card(
          margin: EdgeInsets.only(bottom: 20),
          elevation: 10,
          shadowColor: Colors.black87,
          color: Color.fromARGB(255, 203, 199, 199),
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.DETAIL_ABSENSI, arguments: {"detail": absen});
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: imageResolve(
                          "https://abpjobsite.com/face_id/${absen.nik}/${absen.faceIn}"),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: imageResolve(
                          "https://abpjobsite.com/face_id/${absen.nik}/${absen.faceOut}"),
                    )
                  ],
                ),
                Text(
                  fmt.format(tgl),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${controller.nama.value}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${absen.nik}",
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Masuk",
                                  style: style,
                                ),
                                Text(
                                  "${absen.checkin}",
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Pulang",
                                  style: style,
                                ),
                                Text(
                                  "${absen.checkout}",
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget imageResolve(String gambar) {
    return CachedNetworkImage(
      placeholder: (contex, url) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(
            Icons.broken_image_rounded,
            size: 95,
            color: Color.fromARGB(255, 235, 104, 95),
          ),
        );
      },
      imageUrl: gambar,
      fit: BoxFit.cover,
      height: 100,
      width: 100,
    );
  }
}
