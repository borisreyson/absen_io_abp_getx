import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rkb_kabag_controller.dart';

class RkbKabagView extends GetView<RkbKabagController> {
  const RkbKabagView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RkbKabagView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RkbKabagView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
