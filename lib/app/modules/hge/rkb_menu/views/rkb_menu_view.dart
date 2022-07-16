import 'package:face_id_plus/app/modules/hge/rkb_menu/views/approve_menu_view.dart';
import 'package:face_id_plus/app/modules/hge/rkb_menu/views/dept_view_view.dart';
import 'package:face_id_plus/app/modules/hge/rkb_menu/views/ktt_approve_view.dart';
import 'package:face_id_plus/app/modules/hge/rkb_menu/views/user_view_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rkb_menu_controller.dart';

class RkbMenuView extends GetView<RkbMenuController> {
  const RkbMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rencana Kebutuhan Barang'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView(
            children: const [
              UserViewView(),
              DeptViewView(),
              ApproveMenuView(),
              KttApproveView()
            ],
          ),
        ));
  }
}
