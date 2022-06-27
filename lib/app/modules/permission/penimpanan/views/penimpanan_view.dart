import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/penimpanan_controller.dart';

class PenimpananView extends GetView<PenimpananController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PenimpananView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PenimpananView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
