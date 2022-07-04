import 'dart:math';

import 'package:face_id_plus/app/routes/app_pages.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/device_update_model.dart';
import '../../../data/providers/provider.dart';
import '../../../data/services/service.dart';
import '../../../data/services/sql_service.dart';
import '../../../data/utils/constants.dart';

class MenuAbpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final provider = DeviceUpdateProvider();
  final data = <DeviceUpdate>[];

  final listString = <String>[].obs;
  final _service = ApiService();
  final deviceService = DeviceUpdateService();
  final idDevice = RxnString(null);
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 1), vsync: this)
        ..repeat(reverse: true);

  late final Animation<double> animationRun =
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

  final isLoading = true.obs;
  @override
  void onInit() async {
    initIdDevice();

    super.onInit();
  }

  @override
  void onClose() {}

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    bool? isLogin = pref.getBool(Constants.isLoginAbp);
    var intro = pref.getBool(Constants.intro);
    if (isLogin != null && intro != null) {
      if (!isLogin) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        await deviceService
            .getBy(idDevice: "${idDevice.value}")
            .then((value) async {
          if (value.isNotEmpty) {
            isLoading.value = false;
            var stringList = [];
            var stringTime = [];
            value.forEach((element) {
              stringList.add(element.tipe);
              stringTime.add(element.timeUpdate);
            });

            await provider
                .getDeviceTipe(idDevice.value, stringList)
                .then((value) {
              if (value != null) {
                if (value.deviceUpdate != null) {
                  for (var element in value.deviceUpdate!) {
                    if (stringTime.contains(element.timeUpdate)) {
                      print(" true");
                    } else {
                      print(" false");
                    }
                  }
                }
              }
            });
          } else {
            loadingService();
          }
        });
      }
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
    print("islogin and intro $isLogin $intro");
  }

  loadingService() async {
    await _service.kemungkinanGet();
    listString.add("kemungkinan");
    await _service.keparahanGet();
    listString.add("keparahan");

    await _service.metrikGet();
    listString.add("metrik");

    await _service.perusahaanGet();
    listString.add("perusahaan");

    await _service.lokasiGet();
    listString.add("lokasi");

    await _service.detKeparahanGet();
    listString.add("detKeparahan");

    await _service.pengendalianGet();
    listString.add("pengendalian");

    await _service.detPengendalianGet();
    listString.add("detPengendalian");

    await _service.usersGet();
    listString.add("user");

    await provider
        .insertDeviceUpdate(idDevice.value, listString)
        .then((value) async {
      if (value.success) {
        await _service.deviceUpdateGet(idDevice.value);
        isLoading.value = false;
      }
    });
  }

  initIdDevice() async {
    String? _idDevice;
    try {
      _idDevice = await PlatformDeviceId.getDeviceId;
      if (_idDevice != null) {
        idDevice.value = _idDevice;
        getPref();
      } else {
        initIdDevice();
      }
    } on PlatformException {
      if (kDebugMode) {
        print("ERROR");
      }
    }
  }
}
