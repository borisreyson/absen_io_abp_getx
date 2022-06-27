import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/perusahaan_controller.dart';

class PerusahaanView extends GetView<PerusahaanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PerusahaanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PerusahaanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
