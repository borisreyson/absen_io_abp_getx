import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_abp_controller.dart';

class ProfileAbpView extends GetView<ProfileAbpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileAbpView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProfileAbpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
