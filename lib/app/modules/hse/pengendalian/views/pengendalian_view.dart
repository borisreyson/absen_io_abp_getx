import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengendalian_controller.dart';

class PengendalianView extends GetView<PengendalianController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PengendalianView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PengendalianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
