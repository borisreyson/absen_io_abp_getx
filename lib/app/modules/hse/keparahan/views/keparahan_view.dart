import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/keparahan_controller.dart';

class KeparahanView extends GetView<KeparahanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KeparahanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'KeparahanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
