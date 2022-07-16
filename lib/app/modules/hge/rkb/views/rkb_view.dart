import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rkb_controller.dart';

class RkbView extends GetView<RkbController> {
  const RkbView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('RkbView'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'RkbView is working ${controller.status.value}',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
