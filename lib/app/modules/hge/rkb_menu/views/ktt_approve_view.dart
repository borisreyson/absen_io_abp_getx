import 'package:flutter/material.dart';

import 'package:get/get.dart';

class KttApproveView extends GetView {
  const KttApproveView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      color: Color.fromARGB(255, 95, 70, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: Get.width,
            color: Color.fromARGB(255, 8, 103, 11),
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Approve Rencana Kebutuhan Barang",
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
                  onTap: () {},
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
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: const [
                        Icon(Icons.refresh_rounded),
                        Text("Rkb Approved"),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.red,
                elevation: 10,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          "Rkb Canceled",
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
