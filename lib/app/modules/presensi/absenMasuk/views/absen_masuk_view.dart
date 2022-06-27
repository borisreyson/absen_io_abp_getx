import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absen_masuk_controller.dart';

class AbsenMasukView extends GetView<AbsenMasukController> {
  const AbsenMasukView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: Visibility(
          visible: (controller.visible.value)
              ? controller.visible.value
              : (controller.cameraInitialized.value),
          child: captureButton(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: const Text('Absen Masuk'),
          centerTitle: true,
        ),
        body: cameraWidget(context),
      ),
    );
  }

  Widget cameraWidget(context) {
    return Stack(
      children: [
        (controller.cameraInitialized.value)
            ? Container(
                child: cameraPreview(context),
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
                child: Text(controller.startClock.value),
              ),
            ))
      ],
    );
  }

  Widget cameraPreview(context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
            onDoubleTap: () {
              controller.initCameras();
            },
            child: (controller.cameraController != null)
                ? CameraPreview(controller.cameraController!)
                : const Center(
                    child: Text("Camera Tidak Tersedia!"),
                  )));
  }

  Widget captureButton() {
    return FloatingActionButton(
      onPressed: (controller.isBusy.value)
          ? null
          : () async {
              controller.isBusy.value = true;
              controller.waiting.value = true;
              controller.savFile =
                  await controller.cameraController?.takePicture();
              controller.saveImage();
            },
      tooltip: 'Scan Wajah',
      child: (controller.isBusy.value)
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : const Icon(Icons.camera),
    );
  }
}
