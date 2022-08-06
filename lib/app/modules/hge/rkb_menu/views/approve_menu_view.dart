import 'package:face_id_plus/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ApproveMenuView extends GetView {
  const ApproveMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: Get.width,
            color: Colors.red,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Approve Rencana Kebutuhan Barang",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 75,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Card(
                  elevation: 10,
                  child: InkWell(
                    onTap: () async {
                      await Get.toNamed(Routes.RKB_KABAG,
                          arguments: {"status": "ALL", "index": 0});
                    },
                    child: SizedBox(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Icon(Icons.list_alt_outlined),
                            Text("ALL"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.amber,
                  elevation: 10,
                  child: InkWell(
                    onTap: () async {
                      await Get.toNamed(Routes.RKB_KABAG,
                          arguments: {"status": "Waiting", "index": 1});
                    },
                    child: SizedBox(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Icon(Icons.refresh_outlined),
                            Text("WAITING"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.green,
                  elevation: 10,
                  child: InkWell(
                    onTap: () async {
                      await Get.toNamed(Routes.RKB_KABAG,
                          arguments: {"status": "Approved", "index": 2});
                    },
                    child: SizedBox(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Icon(Icons.approval_outlined),
                            Text("APPROVED"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.red,
                  elevation: 10,
                  child: InkWell(
                    onTap: () async {
                      await Get.toNamed(Routes.RKB_KABAG,
                          arguments: {"status": "Canceled", "index": 3});
                    },
                    child: SizedBox(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.cancel_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "CANCELED",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.red,
                  elevation: 10,
                  child: InkWell(
                    onTap: () async {
                      await Get.toNamed(Routes.RKB_KABAG,
                          arguments: {"status": "Closed", "index": 4});
                    },
                    child: SizedBox(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "CLOSED",
                              style: TextStyle(color: Colors.white),
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
        ],
      ),
    );
  }
}
