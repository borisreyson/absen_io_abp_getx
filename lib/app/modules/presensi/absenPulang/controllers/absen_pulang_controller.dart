import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:face_id_plus/app/data/models/device_update_model.dart';
import 'package:face_id_plus/app/data/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/models/last_absen_models.dart';
import '../../../../data/providers/provider.dart';

class AbsenPulangController extends GetxController {
  final cameraInitialized = false.obs;
  late List<CameraDescription> cameras;
  CameraController? cameraController;
  int cameraPick = 1;
  int jamS = 0, menitS = 0, detikS = 0;
  final serverJam = JamServer().obs;
  final startClock = ''.obs;
  final StreamController<String> _streamClock = StreamController.broadcast();
  Timer? _timerClock;
  final isBusy = false.obs;
  final visible = true.obs;
  final detect = false.obs;
  XFile? savFile;
  final doAbsen = DoPresensi();
  // ignore: prefer_typing_uninitialized_variables
  var externalDirectory;
  final waiting = false.obs;
  final nik = RxnString(null);
  late LatLng lokasi;
  final idDevice = RxnString(null);
  final absenSukses = false.obs;
  final gagal = false.obs;
  @override
  void onInit() async {
    initializeCamera();

    var data = await Get.arguments;
    serverJam.value = data['jam'];
    lokasi = data['lokasi'];

    super.onInit();
  }

  @override
  void onReady() {
    jamS = int.parse("${serverJam.value.jam}");
    menitS = int.parse("${serverJam.value.menit}");
    detikS = int.parse("${serverJam.value.detik}");
    streamJam();
    super.onReady();
  }

  @override
  void onClose() {
    cameraController?.dispose();
  }

  void initializeCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraController = CameraController(
          cameras[cameraPick], ResolutionPreset.medium,
          enableAudio: false);
      await cameraController?.initialize().then((_) async {
        cameraController?.buildPreview();
        cameraController?.setFlashMode(FlashMode.off);
        cameraInitialized.value = true;
        cameraController?.setFocusMode(FocusMode.auto);
      });
    }
    getPref();
  }

  Future<void> initCameras() async {
    if (cameras.isNotEmpty) {
      if (cameras.isNotEmpty) {
        cameraPick = 1;
      }
    }
    cameraPick = cameraPick < cameras.length - 1 ? cameraPick + 1 : 0;
  }

  String doJam() {
    if (detikS >= 59) {
      if (menitS >= 59) {
        if (jamS >= 23) {
          jamS = 00;
          menitS = 00;
          detikS = 00;
        } else {
          jamS = jamS + 1;
          menitS = 00;
          detikS = 00;
        }
      } else {
        menitS = menitS + 1;
        detikS = 00;
      }
    } else {
      detikS = detikS + 1;
    }
    return "${jamS.toString().padLeft(2, "0")}:${menitS.toString().padLeft(2, "0")}:${detikS.toString().padLeft(2, "0")}";
  }

  streamJam() {
    _timerClock?.cancel();
    createJamStream();
    _streamClock.add(doJam());
    _timerClock = Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamClock.add(doJam());
    });
  }

  createJamStream() {
    _streamClock.stream.listen((String jam) {
      startClock.value = jam;
    });
  }
  saveImage() async {
    externalDirectory = await getApplicationDocumentsDirectory();
    String directoryPath = '${externalDirectory.path}/FaceIdPlus';
    await Directory(directoryPath).create(recursive: true);
    File files = File(savFile!.path);
    absensiPulang(files);
  }

  absensiPulang(File files) async {
    visible.value = false;
    detect.value = true;
    waiting.value = false;
    isBusy.value = false;
    PostAbsen data = PostAbsen();
    data.fileToUpload = files;
    data.nik = nik.value;
    data.lat = "${lokasi.latitude}";
    data.lng = "${lokasi.longitude}";
    data.status = "Pulang";
    await doAbsen.takePresensi(data, "${idDevice.value}").then((value) {
      if (value != null) {
        print(" absensiStatus ${value.absensi}");
        if (value.absensi) {
          Get.snackbar(
            "Success",
            "Absen Di Daftar!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          absenSukses.value = value.absensi;
        } else {
          absenSukses.value = value.absensi;
        }
      }
    }).onError((error, stackTrace) {
      absenSukses.value = false;
    });
    print("absenSukses ${absenSukses.value}");
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    nik.value = pref.getString(Constants.nik);
    initIdDevice();
  }

  initIdDevice() async {
    try {
      var id = await PlatformDeviceId.getDeviceId;
      idDevice.value = "$id";
      print("idDevice ${idDevice}");
      initCameras();
    } on PlatformException {
      if (kDebugMode) {
        print("ERROR");
      }
    }
  }
}
