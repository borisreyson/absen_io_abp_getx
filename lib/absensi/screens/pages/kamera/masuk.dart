import 'dart:async';
import 'dart:ffi';
import 'package:face_id_plus/absensi/model/last_absen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as imglib;
import 'dart:math' as math;

// ignore: camel_case_types
typedef convert_func = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
typedef Convert = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

class IosMasuk extends StatefulWidget {
  final String nik;
  final String status;
  final String lat;
  final String lng;
  // ignore: non_constant_identifier_names
  final String id_roster;
  // ignore: non_constant_identifier_names
  final JamServer? jam_server;
  const IosMasuk(
      {Key? key,
      required this.nik,
      required this.status,
      required this.lat,
      required this.lng,
      // ignore: non_constant_identifier_names
      required this.id_roster,
      // ignore: non_constant_identifier_names
      required this.jam_server})
      : super(key: key);

  @override
  _IosMasukState createState() => _IosMasukState();
}

class _IosMasukState extends State<IosMasuk> {
  bool isLoading = false;
  final DynamicLibrary convertImageLib = Platform.isAndroid
      ? DynamicLibrary.open("libconvertImage.so")
      : DynamicLibrary.process();
  bool waiting = false;
  late Convert conv;
  XFile? savFile;
  late imglib.Image img;
  // ignore: prefer_typing_uninitialized_variables
  var externalDirectory;
  bool _cameraInitialized = false;
  bool isBusy = false;
  CustomPaint? customPaint;
  CameraController? _cameraController;
  bool visible = true;
  bool detect = false;
  File? imageFile;
  int cameraPick = 1;
  late List<CameraDescription> cameras;
  List<int>? intImage;
  bool startCamera = false;

  int jamS = 0, menitS = 0, detikS = 0;
  JamServer? serverJam;
  String? startClock;
  final StreamController<String> _streamClock = StreamController.broadcast();
  Timer? _timerClock;


  void initializeCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _cameraController = CameraController(
        cameras[cameraPick],
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _cameraController?.initialize().then((_) async {
        _cameraController?.buildPreview();
        _cameraController?.setFlashMode(FlashMode.off);
        setState(() {
          _cameraInitialized = true;
        });
      });
    }
  }


  Future<void> initCameras() async {
    if (cameras.isNotEmpty) {
      if (cameras.isNotEmpty) {
        cameraPick = 1;
      }
    }
    setState(() {
      cameraPick = cameraPick < cameras.length - 1 ? cameraPick + 1 : 0;
    });
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
      if (mounted) {
        setState(() {
          startClock = jam;
        });
      }
    });
  }

  @override
  void initState() {
    serverJam = widget.jam_server;
    jamS = int.parse("${serverJam?.jam}");
    menitS = int.parse("${serverJam?.menit}");
    detikS = int.parse("${serverJam?.detik}");
    streamJam();
    initializeCamera();
    if (_cameraInitialized) {
      conv = convertImageLib
          .lookup<NativeFunction<convert_func>>('convertImage')
          .asFunction<Convert>();
    }
    super.initState();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  Future _stopLiveFeed() async {
    // await _cameraController?.stopImageStream();
    await _cameraController?.dispose();
    _cameraController = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Absen Masuk"),
          leading: InkWell(
            splashColor: const Color(0xff000000),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.maybePop(context);
            },
          )),
      body: (waiting)
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color(0xf0D9D9D9),
              child: (visible)
                  ? (isBusy)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : cameraFrame()
                  : imgFrame()),
      floatingActionButton: (visible)
          ? (_cameraInitialized)
              ? FloatingActionButton(
                  onPressed: (isBusy)
                      ? null
                      : () async {
                          isBusy = true;
                          // _processImageStream(_savedImage);
                          // waiting = true;
                          savFile = await _cameraController?.takePicture();
                          setState(() {});
                        },
                  tooltip: 'Scan Wajah',
                  child: (isBusy)
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : const Icon(Icons.camera),
                )
              : Visibility(
                  visible: false,
                  child: Container(),
                )
          : Visibility(
              visible: visible,
              child: Container(),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget imgFrame() {
    return Stack(
      children: [
        Positioned(
            child: Stack(
          fit: StackFit.expand,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: (intImage != null)
                      ? Image.memory(Uint8List.fromList(intImage!))
                      : Image.file(File(savFile!.path))),
            ),
            if (customPaint != null) customPaint!,
          ],
        )),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: ((detect)
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    child: const Text("Selesai"))
                : Visibility(
                    visible: (isBusy) ? false : true,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            visible = true;
                            detect = false;
                            initializeCamera();
                            conv = convertImageLib
                                .lookup<NativeFunction<convert_func>>(
                                    'convertImage')
                                .asFunction<Convert>();
                          });
                        },
                        child: const Text("Scan Ulang")),
                  )),
          ),
        )
      ],
    );
  }

  Widget cameraFrame() {
    return Stack(
      children: [
        (_cameraInitialized)
            ? Container(
                child: cameraPreview(),
              )
            : const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              ),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text("Boris"),
          ),
        )
      ],
    );
  }

  Widget cameraPreview() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
            onDoubleTap: () {
              initCameras();
            },
            child: (_cameraController != null)
                ? CameraPreview(_cameraController!)
                : const Center(
                    child: Text("Camera Tidak Tersedia!"),
                  )));
  }



}
