import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rkb_menu_controller.dart';

class RkbMenuView extends GetView<RkbMenuController> {
  const RkbMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView(
            children: controller.listMenu,
          ),
        ),
      ),
    );
  }
}
