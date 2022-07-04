import 'package:face_id_plus/app/data/utils/background.dart';
import 'package:face_id_plus/app/data/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_abp_controller.dart';

class ProfileAbpView extends GetView<ProfileAbpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        centerTitle: true,
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
            children: [],
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton.icon(
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
              ))
        ],
      ),
    );
  }
}
