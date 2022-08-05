import 'package:cached_network_image/cached_network_image.dart';
import 'package:face_id_plus/app/data/utils/background.dart';
import 'package:face_id_plus/app/data/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_abp_controller.dart';

class ProfileAbpView extends GetView<ProfileAbpController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back(result: false);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: Stack(
          children: [
            const Background(
                topPrimary: Colors.blue,
                topSecondary: Colors.amberAccent,
                bottomPrimary: Colors.grey,
                bottomSecondary: Colors.red,
                bgColor: Colors.white),
            ListView(
              children: [
                foto(),
                nama(),
                nik(),
              ],
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                      onPressed: () async {
                        var res = await Constants()
                            .showMyDialog(context, "Keluarkan Akun?");
                        if (res) {
                          var exit = await Constants().sign_out(context);
                          Get.back(result: exit);
                        }
                      },
                      icon: const Icon(Icons.key_rounded),
                      label: const Text("Ganti Sandi"),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () async {
                        var res = await Constants()
                            .showMyDialog(context, "Keluarkan Akun?");
                        if (res) {
                          var exit = await Constants().sign_out(context);
                          Get.back(result: exit);
                        }
                      },
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text("Keluar"),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget foto() {
    return Container(
      child: (controller.foto.value != null)
          ? Center(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: "${controller.foto.value}",
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(radius: 40),
                    ),
                    errorWidget: (context, url, err) => const Center(
                      child: CupertinoActivityIndicator(radius: 40),
                    ),
                  ),
                ),
              ),
            )
          : CupertinoActivityIndicator(
              radius: 20,
              color: Colors.red,
            ),
    );
  }

  Widget nama() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Center(
          child: Text(
        "${controller.nama.value}",
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline),
      )),
    );
  }

  Widget nik() {
    return Container(
      child: Center(child: Text("${controller.nik.value}")),
    );
  }

  Widget jabatan() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(child: Text("${controller.jabatan.value}")),
    );
  }

  Widget dept() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(child: Text("${controller.dept.value}")),
    );
  }

  Widget perusahaan() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(child: Text("${controller.perusahaan.value}")),
    );
  }
}
