import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/buletin_controller.dart';

class BuletinView extends GetView<BuletinController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BuletinView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BuletinView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
