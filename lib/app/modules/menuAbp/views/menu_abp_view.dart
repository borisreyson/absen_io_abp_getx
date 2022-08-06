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
                        if (res) {
                          controller.isLoading.value = true;
                          await controller.getPref();
                        }
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
                  children: controller.widgetList,
                ),
              ),
            ),
    );
  }
}
