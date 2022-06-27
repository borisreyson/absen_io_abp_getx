import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hazard_user_controller.dart';

class HazardUserView extends GetView<HazardUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HazardUserView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HazardUserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
