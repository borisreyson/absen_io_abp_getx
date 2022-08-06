import 'dart:async';
import 'package:face_id_plus/app/data/models/sarana_models.dart';
import 'package:face_id_plus/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../data/models/sarpras_list.dart';
import '../controllers/sarpras_ktt_controller.dart';

class SarprasKttView extends GetView<SarprasKttController> {
  const SarprasKttView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Keluar Masuk Sarana'),
          centerTitle: true,
        ),
        body: SmartRefresher(
          footer: footer(),
          header: header(),
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          controller: controller.refreshCtrl,
          enablePullUp: controller.pullUp.value,
          enablePullDown: true,
          child: ListView(
              children:
                  controller.listSarpras.map((e) => cardSarpras(e)).toList()),
        ),
      ),
    );
  }

  Widget header() {
    return const WaterDropMaterialHeader(
      backgroundColor: Colors.orange,
      color: Colors.black,
    );
  }

  Widget footer() {
    return const ClassicFooter(
      loadingIcon: CupertinoActivityIndicator(
        color: Colors.orange,
        radius: 20,
      ),
      canLoadingIcon: Icon(
        Icons.autorenew,
        color: Colors.orange,
        size: 20,
      ),
      idleIcon: Icon(
        Icons.arrow_upward,
        size: 20,
        color: Colors.orange,
      ),
      textStyle: TextStyle(color: Colors.orange, fontSize: 16),
    );
  }

  Widget cardSarpras(Data e) {
    var now = DateTime.now();
    var dbTime = DateTime.parse("${e.tglOut} ${e.jamOut}");
    var start = dbTime.add(Duration(minutes: 30));
    var selisih = start.difference(now);
    var selisihHari = now.difference(dbTime);
    print("hari ${selisihHari.inDays}");
    var sisa = 0.obs;
    var detik = 0.obs;
    if (selisih.inMinutes > 0) {
      sisa.value = selisih.inMinutes;
      detik.value = selisih.inSeconds % 60;
      Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) {
          if (detik.value == 0) {
            timer.cancel();
          } else {
            sisa.value = selisih.inMinutes;
            detik.value--;
          }
        },
      );
    }

    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nomor",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${e.nomor?.padLeft(4, '0')}"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pemohon",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${e.nama}"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tanggal Keluar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text((e.tglOut != null)
                    ? controller.fmt.format(DateTime.parse("${e.tglOut}"))
                    : ""),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Jam Keluar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${e.jamOut}"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dibuat",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (e.tglEntry != null)
                          ? controller.fmt
                              .format(DateTime.parse("${e.tglDibuat}"))
                          : "",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      (e.tanggalEntry != null)
                          ? controller.jam.format(DateTime.parse(e.tglDibuat!))
                          : "",
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              height: 1,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Keperluan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "${e.keperluan}",
                    textAlign: TextAlign.justify,
                  ),
                )),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      color: (e.flagAppr == '1')
                          ? Colors.green
                          : (e.flagAppr == '0')
                              ? Colors.red
                              : Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (e.flagAppr == '1')
                              ? "Disetujui | ${controller.fmt.format(DateTime.parse("${e.tanggalAppr}"))} ${controller.jam.format(DateTime.parse("${e.tanggalAppr}"))}"
                              : (e.flagAppr == '0')
                                  ? "Dibatalkan : ${controller.fmt.format(DateTime.parse("${e.tanggalAppr}"))} ${controller.jam.format(DateTime.parse("${e.tanggalAppr}"))}"
                                  : "Menunggu Di Approve",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    if (e.flagAppr == '1')
                      Card(
                        color: const Color.fromARGB(255, 22, 9, 61),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Disetujui Oleh ${e.namaLengkap}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    if (e.flagAppr == '0')
                      Card(
                        color: const Color.fromARGB(255, 124, 6, 6),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Dibatalkan Oleh ${e.namaLengkap}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if ((e.flagAppr == '1'))
                          Card(
                            elevation: 10,
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.SARPRAS_PDF,
                                    arguments: {"noSarpras": "${e.noidOut}"});
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "PDF",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        Card(
                          elevation: 10,
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.SARPRAS_DETAIL,
                                  arguments: {"noidOut": e.noidOut});
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Lihat",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
