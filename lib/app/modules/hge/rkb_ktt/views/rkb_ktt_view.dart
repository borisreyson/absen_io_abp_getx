import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rkb_ktt_controller.dart';

class RkbKttView extends GetView<RkbKttController> {
  const RkbKttView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RkbKttView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RkbKttView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
