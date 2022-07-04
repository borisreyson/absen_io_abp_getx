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
          print(" getBy ${value.length}");

          if (value.isNotEmpty) {
            var stringList = [];
            var stringTime = [];
            for (var element in value) {
              stringList.add(element.tipe);
              stringTime.add(element.timeUpdate);
            }
            var z = 0;
            await provider
                .getDeviceTipe(idDevice.value, stringList)
                .then((value) async {
              if (value != null) {
                if (value.deviceUpdate != null) {
                  for (var element in value.deviceUpdate!) {
                    if (stringTime.contains(element.timeUpdate) &&
                        stringList.contains(element.tipe)) {
                      print("true $z ${element.tipe}");
                    } else {
                      print(" false $z ${element.tipe}");
                      await updateLokal(element.tipe);
                      print(" false $z ${element.tipe} 1");

                      var data = DeviceUpdate();
                      data.idDevice = idDevice.value;
                      data.idUpdate = element.idUpdate;
                      data.tipe = element.tipe;
                      data.timeUpdate = element.timeUpdate;
                      var res = await DeviceUpdateService().update(data);
                      if (kDebugMode) {
                        print("deviceUpdateGet $res");
                      }
                    }
                    z++;
                  }
                }
              }
              isLoading.value = false;
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
    listString.clear();

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

  updateLokal(tipe) async {
    listString.clear();
    switch (tipe) {
      case "kemungkinan":
        await _service.kemungkinanGet();
        listString.add("kemungkinan");
        print("tipe $tipe 1");
        break;
      case "keparahan":
        await _service.keparahanGet();
        listString.add("keparahan");
        print("tipe $tipe 2");

        break;
      case "metrik":
        await _service.metrikGet();
        listString.add("metrik");
        print("tipe $tipe 3");
        break;
      case "perusahaan":
        await _service.perusahaanGet();
        listString.add("perusahaan");
        print("tipe $tipe 4");
        break;
      case "lokasi":
        await _service.lokasiGet();
        listString.add("lokasi");
        print("tipe $tipe 5");
        break;
      case "detKeparahan":
        await _service.detKeparahanGet();
        listString.add("detKeparahan");
        print("tipe $tipe 6");
        break;
      case "pengendalian":
        await _service.pengendalianGet();
        listString.add("pengendalian");
        print("tipe $tipe 7");
        break;
      case "detPengendalian":
        await _service.detPengendalianGet();
        listString.add("detPengendalian");
        print("tipe $tipe 8");
        break;
      case "user":
        await _service.usersGet();
        listString.add("user");
        print("tipe $tipe 9");
        break;
    }
  }
}
