import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/barcode_security_controller.dart';

class BarcodeSecurityView extends GetView<BarcodeSecurityController> {
  const BarcodeSecurityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BarcodeSecurityView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BarcodeSecurityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
