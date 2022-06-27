import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lokasi_hazard_controller.dart';

class LokasiHazardView extends GetView<LokasiHazardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LokasiHazardView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LokasiHazardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
