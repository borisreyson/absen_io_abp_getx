import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rkb_menu_controller.dart';

class RkbMenuView extends GetView<RkbMenuController> {
  const RkbMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RkbMenuView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RkbMenuView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
