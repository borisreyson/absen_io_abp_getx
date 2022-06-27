import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back(result: false);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                namaWidget(),
                InkWell(
                  onTap: () {
                    Get.toNamed('/list-absen');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(color: Colors.black, width: 1),
                    )),
                    child: Row(
                      children: const [
                        Icon(Icons.people),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Text("List Absen"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Card(
                color: const Color.fromARGB(255, 144, 24, 15),
                child: InkWell(
                  onTap: () {
                    controller.logOut();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.exit_to_app, color: Colors.white),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Text(
                            "Keluar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget namaWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              width: 100,
              height: 100,
              child: (controller.foto != null && controller.foto != '')
                  ? Image.network(
                      "${controller.foto}",
                      fit: BoxFit.fitWidth,
                    )
                  : Icon(
                      Icons.person,
                      size: 70,
                    ),
              color: Colors.grey.shade200,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.nama.value),
                Text(controller.nik.value),
              ],
            ),
          )
        ],
      ),
    );
  }
}
