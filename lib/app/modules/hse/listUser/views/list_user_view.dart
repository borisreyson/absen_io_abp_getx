import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_user_controller.dart';

class ListUserView extends GetView<ListUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListUserView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ListUserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
