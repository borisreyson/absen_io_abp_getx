import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/kemungkinan_controller.dart';

class KemungkinanView extends GetView<KemungkinanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KemungkinanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'KemungkinanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
