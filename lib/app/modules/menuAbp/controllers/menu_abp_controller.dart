import 'package:face_id_plus/app/routes/app_pages.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/services/sql_service.dart';
import '../../../data/utils/constants.dart';

class MenuAbpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _service = ApiService();

  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 1), vsync: this)
        ..repeat(reverse: true);

  late final Animation<double> animationRun =
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

  final isLoading = true.obs;
  @override
  void onInit() async {
    await _service.kemungkinanGet();
    await _service.keparahanGet();
    await _service.metrikGet();
    await _service.perusahaanGet();
    await _service.lokasiGet();
    await _service.detKeparahanGet();
    await _service.pengendalianGet();
    await _service.detPengendalianGet();
    await _service.usersGet();
    _getPref();
    super.onInit();
  }

  @override
  void onClose() {}

  _getPref() async {
    var pref = await SharedPreferences.getInstance();
    bool? isLogin = pref.getBool(Constants.isLoginAbp);
    if (isLogin != null) {
      if (!isLogin) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        isLoading.value = false;
      }
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
