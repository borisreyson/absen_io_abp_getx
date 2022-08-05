import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/models/rkb_models.dart';
import '../../../../data/providers/provider.dart';
import '../../../../data/utils/constants.dart';

class RkbDeptController extends GetxController {
  final provider = Provider();
  final status = RxnString(null);
  final nik = RxnString(null);
  final nama = RxnString(null);
  final section = RxnString(null);
  final dept = RxnString(null);
  final perusahaan = RxnString(null);
  final username = RxnString(null);
  final page = 1.obs;
  final data = <Data>[].obs;
  final refreshController = RefreshController();
  final pullUp = true.obs;
  final lastPage = 1.obs;

  final listOption = ["ALL", "Waiting", "Approved", "Canceled", "Closed"];
  final indexSelect = RxnInt();
  final listColor = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.red
  ];
  @override
  void onInit() async {
    status.value = await Get.arguments['status'];
    indexSelect.value = await Get.arguments['index'];
    getPref();
    super.onInit();
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    nik.value = pref.getString(Constants.nik);
    nama.value = pref.getString(Constants.name);
    section.value = pref.getString(Constants.section);
    dept.value = pref.getString(Constants.departement);
    perusahaan.value = pref.getString(Constants.company);
    username.value = pref.getString(Constants.username);
    getRkb();
  }

  getRkb() async {
    await provider
        .getRkbDept(dept.value, "${page.value}", "${status.value}")
        .then((value) {
      if (value != null) {
        print("a");
        var rkb = value.rkb;
        if (rkb != null) {
          print("b");
          lastPage.value = rkb.lastPage!;
          if (rkb.data!.isNotEmpty) {
            print("c");
            data.addAll(rkb.data!);
          }
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        }
      } else {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
      }
    });
  }

  void onRefresh() {
    page.value = 0;
    data.clear();
    getRkb();
  }

  void loadMore() async {
    if (page.value < lastPage.value) {
      page.value++;
      print("page ${page.value}");

      await getRkb();
    } else {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      pullUp.value = false;
    }
  }

  tapNavigasi(index) async {
    page.value = 1;
    data.clear();
    status.value = listOption.elementAt(index);
    indexSelect.value = index;
    getRkb();
  }
}
