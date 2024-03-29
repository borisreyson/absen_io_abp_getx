import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import '../controllers/absen_masuk_controller.dart';
import 'dart:math' as math;

class AbsenMasukView extends GetView<AbsenMasukController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Absen Masuk'),
          centerTitle: true,
        ),
        body: cameraWidget(context),
      ),
    );
  }

  Widget imagePreview() {
    return SizedBox(
      width: Get.width,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: Image.file(
          File(controller.savFile!.path),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget cameraWidget(context) {
    return Stack(
      children: [
        (controller.cameraInitialized.value)
            ? Container(
                child: (controller.absenSukses.value)
                    ? imagePreview()
                    : cameraPreview(context),
              )
            : const Positioned(
                bottom: 0,
                top: 0,
                right: 0,
                left: 0,
                child: CupertinoActivityIndicator(),
              ),
        Align(
          alignment: Alignment.topCenter,
          child: Card(
            margin: const EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(controller.startClock.value),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: captureButton(),
          ),
        ),
        if (!controller.absenSukses.value)
          Visibility(
            visible: !controller.gagal.value,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: focusButton(),
              ),
            ),
          ),
        Visibility(
          visible: controller.gagal.value,
          child: Positioned(
            bottom: 10,
            right: 10,
            child: reloadButton(),
          ),
        ),
        (controller.absenSukses.value)
            ? const Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Card(
                  color: Color.fromARGB(255, 21, 111, 24),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Absen Di Daftar!",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget cameraPreview(context) {
    return SizedBox(
        width: Get.width,
        child: GestureDetector(
          onDoubleTap: () {
            controller.initCameras();
          },
          child: (controller.cameraController != null)
              ? (controller.isBusy.value)
                  ? const SizedBox(
                      child: CupertinoActivityIndicator(
                      radius: 40,
                      color: Color.fromARGB(255, 5, 54, 94),
                    ))
                  : CameraPreview(controller.cameraController!)
              : const Center(
                  child: Text("Camera Tidak Tersedia!"),
                ),
        ));
  }

  Widget captureButton() {
    return FloatingActionButton(
      onPressed: (controller.isBusy.value)
          ? null
          : (controller.absenSukses.value)
              ? () {
                  Get.back(result: true);
                }
              : () async {
                  controller.isBusy.value = true;
                  controller.waiting.value = true;
                  controller.savFile =
                      await controller.cameraController?.takePicture();
                  controller.saveImage();
                },
      tooltip: 'Scan Wajah',
      backgroundColor: (controller.absenSukses.value)
          ? Color.fromARGB(255, 10, 165, 15)
          : Color.fromARGB(255, 10, 73, 125),
      child: (controller.isBusy.value)
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : (controller.absenSukses.value)
              ? const Icon(Icons.check_rounded)
              : const Icon(Icons.camera),
    );
  }

  Widget reloadButton() {
    return FloatingActionButton(
        onPressed: () async {
          controller.savFile = null;
          controller.isBusy.value = false;
          controller.waiting.value = false;
          controller.detect.value = true;
          controller.absenSukses.value = false;
          controller.initializeCamera();
          controller.initCameras();
        },
        tooltip: 'Ambil Ulang',
        backgroundColor: Colors.orange,
        child: const Icon(Icons.refresh_rounded));
  }

  Widget focusButton() {
    return FloatingActionButton(
      onPressed: () async {
        await controller.cameraController?.setFocusMode(FocusMode.auto);
      },
      tooltip: 'Focus',
      backgroundColor: Colors.blueGrey,
      child: const Icon(Icons.filter_center_focus_rounded),
    );
  }
}
