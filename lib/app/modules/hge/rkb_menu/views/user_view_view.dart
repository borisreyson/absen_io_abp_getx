import 'package:face_id_plus/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserViewView extends GetView {
  const UserViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      color: Colors.blue[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: Get.width,
            color: Colors.grey,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Rencana Kebutuhan Barang Anda",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                color: Colors.amber,
                elevation: 10,
                child: InkWell(
                  onTap: () async {
                    await Get.toNamed(Routes.RKB,
                        arguments: {"status": "waiting"});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: const [
                        Icon(Icons.refresh_rounded),
                        Text("Rkb Waiting"),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.green,
                elevation: 10,
                child: InkWell(
                  onTap: () async {
                    await Get.toNamed(Routes.RKB,
                        arguments: {"status": "approve"});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: const [
                        Icon(Icons.refresh_rounded),
                        Text("Rkb Approve"),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.red,
                elevation: 10,
                child: InkWell(
                  onTap: () async {
                    await Get.toNamed(Routes.RKB,
                        arguments: {"status": "cancel"});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          "Rkb Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
