import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../data/models/last_absen_model.dart';

class AbsenMasukController extends GetxController {
  final cameraInitialized = false.obs;
  late List<CameraDescription> cameras;
  CameraController? cameraController;
  int cameraPick = 1;
  int jamS = 0, menitS = 0, detikS = 0;
  JamServer? serverJam;
  final startClock = ''.obs;
  final StreamController<String> _streamClock = StreamController.broadcast();
  Timer? _timerClock;
  final isBusy = false.obs;
  final visible = true.obs;
  final detect = false.obs;
  XFile? savFile;
  var externalDirectory;
  final waiting = false.obs;

  @override
  void onInit() {
    var data = Get.arguments;
    serverJam = data;
    super.onInit();
  }

  @override
  void onReady() {
    jamS = int.parse("${serverJam?.jam}");
    menitS = int.parse("${serverJam?.menit}");
    detikS = int.parse("${serverJam?.detik}");
    streamJam();
    initializeCamera();
    super.onReady();
  }

  @override
  void onClose() {}
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
      });
    }
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
    File _files = File(savFile!.path);
    absensiMasuk(_files);
  }

  absensiMasuk(File files) async {
    Get.snackbar("Success", "Absen Di Daftar!");
    visible.value = false;
    detect.value = true;
    waiting.value = false;
    isBusy.value = false;
  }
}
