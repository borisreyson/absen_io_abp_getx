import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../data/models/last_absen_model.dart';
import '../controllers/list_absen_controller.dart';
import '../controllers/nav_list_absen_controller.dart';
import 'nav_list_absen_view.dart';

class ListAbsenView extends GetView<ListAbsenController> {
  var navigasiTap = Get.find<NavListAbsenController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            backgroundColor: (controller.status == "masuk")
                ? const Color.fromARGB(255, 12, 118, 15)
                : const Color.fromARGB(255, 160, 23, 13),
            title: const Text('List Absen'),
            centerTitle: true,
          ),
          bottomNavigationBar: NavListAbsenView(
            navigasiTap: navigasiTap,
          ),
          body: SmartRefresher(
            enablePullUp: true,
            onRefresh: controller.doRefresh,
            controller: controller.pullRefresh,
            onLoading: controller.loadingPage,
            child: ListView(
              children: controller.listAbsen.map((e) => cardAbsen(e)).toList(),
            ),
          )),
    );
  }

  Widget cardAbsen(Presensi presensi) {
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    return Stack(
      children: [
        Card(
          color: (presensi.status == "Masuk")
              ? const Color.fromARGB(255, 12, 118, 15)
              : const Color.fromARGB(255, 160, 23, 13),
          margin:
              const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 20),
          elevation: 10,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10, bottom: 10, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        "${presensi.gambar}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${controller.nama}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "${presensi.nik}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "${presensi.jam}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "${presensi.status}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          right: 0,
          top: 0,
          child: Card(
            elevation: 20,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Masuk"),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Card(
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(fmt.format(DateTime.parse("${presensi.tanggal}"))),
            ),
          ),
        )
      ],
    );
  }
}
