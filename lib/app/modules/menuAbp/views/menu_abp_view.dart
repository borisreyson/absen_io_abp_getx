import 'package:face_id_plus/app/controllers/navigasi_controller.dart';
import 'package:face_id_plus/app/modules/menuAbp/views/loading_abp_view.dart';
import 'package:face_id_plus/app/routes/app_pages.dart';
import 'package:face_id_plus/app/views/views/navigasi_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/menu_abp_controller.dart';

class MenuAbpView extends GetView<MenuAbpController> {
  final navigasiTap = Get.find<NavigasiController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.isLoading.value)
          ? const LoadingAbpView()
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "ABP Energy",
                  style: TextStyle(
                      color: Colors.white, fontStyle: FontStyle.italic),
                ),
                backgroundColor: const Color(0xFF732937),
                actions: [
                  IconButton(
                      onPressed: () async {
                        var res = await Get.toNamed(Routes.PROFILE_ABP);
                      },
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
              backgroundColor: Colors.white,
              bottomNavigationBar: NavigasiView(navigasiTap: navigasiTap),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  crossAxisCount: 3,
                  children: [
                    hazard(),
                    sarpras(),
                    monitoring(),
                    rkb(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget hazard() {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.CORRECTIVE_ACTION);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/car_ic.png",
                width: 60,
              ),
              const Text(
                "Corrective Action",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sarpras() {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/sarana_add.png",
              ),
              const Text(
                "Sarpras",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  monitoring() {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                Icons.display_settings_sharp,
                color: Colors.black,
                size: 30,
              ),
              Text(
                "Monitoring",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  rkb() {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                Icons.content_paste_go_sharp,
                color: Colors.blue,
                size: 30,
              ),
              Text(
                "Rencana Kebutuhan Barang",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  menuAbsensi() {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                Icons.content_paste_go_sharp,
                color: Colors.blue,
                size: 30,
              ),
              Text(
                "Absensi",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
