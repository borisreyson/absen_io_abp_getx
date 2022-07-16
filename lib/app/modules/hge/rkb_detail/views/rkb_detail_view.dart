import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rkb_detail_controller.dart';

class RkbDetailView extends GetView<RkbDetailController> {
  const RkbDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RkbDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RkbDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
