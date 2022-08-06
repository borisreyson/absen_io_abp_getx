import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lokasi_mati_controller.dart';

class LokasiMatiView extends GetView<LokasiMatiController> {
  const LokasiMatiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LokasiMatiView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LokasiMatiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
