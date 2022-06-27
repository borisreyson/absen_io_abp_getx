import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotifikasiView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotifikasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
