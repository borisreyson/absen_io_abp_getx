import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DeptViewView extends GetView {
  const DeptViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: Get.width,
            color: Colors.blue,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Rencana Kebutuhan Barang Dept",
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
