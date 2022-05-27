import 'dart:async';
import 'dart:ffi';
import 'package:face_id_plus/absensi/model/last_absen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:image/image.dart' as imglib;
import 'dart:math' as math;

// ignore: camel_case_types
typedef convert_func = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
typedef Convert = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

class IosPulang extends StatefulWidget {
  final String nik;
  final String status;
  final String lat;
  final String lng;
  final String id_roster;
  final JamServer? jam_server;

  const IosPulang(
      {Key? key,
      required this.nik,
      required this.status,
      required this.lat,
      required this.lng,
      required this.id_roster,
      required this.jam_server})
      : super(key: key);

  @override
  _IosPulangState createState() => _IosPulangState();
}

class _IosPulangState extends State<IosPulang> {
  final DynamicLibrary convertImageLib = Platform.isAndroid
      ? DynamicLibrary.open("libconvertImage.so")
      : DynamicLibrary.process();
  bool waiting = false;
  late Convert conv;
  XFile? savFile;
  late imglib.Image img;
  var externalDirectory;
  late CameraImage _savedImage;
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
          cameras[cameraPick], ResolutionPreset.medium,
          enableAudio: false);
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
          title: const Text("Absen Pulang"),
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
                          // waiting = true;
                          savFile = await _cameraController?.takePicture();
                          setState(() {});
                          saveImage();
                        },
                  tooltip: 'Scan Wajah',
                  child: (isBusy)
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white))
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
            child: (detect)
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
                  ),
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
        Align(
            alignment: Alignment.topCenter,
            child: Card(
              margin: const EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("$startClock"),
              ),
            ))
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

  Future<List<int>> convertImage(CameraImage image) async {
    if (Platform.isAndroid) {
      // Allocate memory for the 3 planes of the image
      Pointer<Uint8> p = calloc(_savedImage.planes[0].bytes.length);
      Pointer<Uint8> p1 = calloc(_savedImage.planes[1].bytes.length);
      Pointer<Uint8> p2 = calloc(_savedImage.planes[2].bytes.length);

      // Assign the planes data to the pointers of the image
      Uint8List pointerList = p.asTypedList(_savedImage.planes[0].bytes.length);
      Uint8List pointerList1 =
          p1.asTypedList(_savedImage.planes[1].bytes.length);
      Uint8List pointerList2 =
          p2.asTypedList(_savedImage.planes[2].bytes.length);
      pointerList.setRange(
          0, _savedImage.planes[0].bytes.length, _savedImage.planes[0].bytes);
      pointerList1.setRange(
          0, _savedImage.planes[1].bytes.length, _savedImage.planes[1].bytes);
      pointerList2.setRange(
          0, _savedImage.planes[2].bytes.length, _savedImage.planes[2].bytes);

      // Call the convertImage function and convert the YUV to RGB
      Pointer<Uint32> imgP = conv(
          p,
          p1,
          p2,
          _savedImage.planes[1].bytesPerRow,
          _savedImage.planes[1].bytesPerPixel!,
          _savedImage.planes[0].bytesPerRow,
          _savedImage.height);

      // Get the pointer of the data returned from the function to a List
      List<int> imgData = imgP.asTypedList(
          (_savedImage.planes[0].bytesPerRow * _savedImage.height));
      // Generate image from the converted data
      img = imglib.Image.fromBytes(
          _savedImage.height, _savedImage.planes[0].bytesPerRow, imgData);
      // Free the memory space allocated
      // from the planes and the converted data        calloc.free(p);
      calloc.free(p1);
      calloc.free(p2);
      calloc.free(imgP);
    } else if (Platform.isIOS) {
      img = imglib.Image.fromBytes(
        _savedImage.planes[0].bytesPerRow,
        _savedImage.height,
        _savedImage.planes[0].bytes,
        format: imglib.Format.bgra,
      );
    }
    img = imglib.flipVertical(img);
    img = imglib.copyCrop(img, 0, 100, img.width, img.height - 100);
    imglib.PngEncoder pngEncoder = imglib.PngEncoder();
    return pngEncoder.encodeImage(img);
  }

  savingImage() async {
    externalDirectory = await getApplicationDocumentsDirectory();
    String directoryPath = '${externalDirectory.path}/FaceIdPlus';
    await Directory(directoryPath).create(recursive: true);
    String filePath = '$directoryPath/${DateTime.now()}_pulang.jpg';
    File _files = await File(filePath).writeAsBytes(intImage!);
    absensiPulang(_files);
  }

  saveImage() async {
    externalDirectory = await getApplicationDocumentsDirectory();
    String directoryPath = '${externalDirectory.path}/FaceIdPlus';
    await Directory(directoryPath).create(recursive: true);
    File _files = File(savFile!.path);
    absensiPulang(_files);
  }

  absensiPulang(File files) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Absen Di Daftar!",
          style: TextStyle(color: Colors.white),
        )));
    visible = false;
    detect = true;
    waiting = false;
    isBusy = false;
    setState(() {});
  }
}
