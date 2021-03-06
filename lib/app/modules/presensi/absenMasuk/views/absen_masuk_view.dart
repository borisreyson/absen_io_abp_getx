import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absen_masuk_controller.dart';

class AbsenMasukView extends GetView<AbsenMasukController> {
  const AbsenMasukView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // floatingActionButton: Visibility(
        //   visible: (controller.visible.value)
        //       ? controller.visible.value
        //       : (controller.cameraInitialized.value),
        //   child: captureButton(),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: const Text('Absen Masuk'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back(result: false);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: cameraWidget(context),
      ),
    );
  }

  Widget cameraWidget(context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: (controller.cameraInitialized.value)
              ? Container(
                  child: (controller.absenSukses.value)
                      ? imagePreview()
                      : cameraPreview(),
                )
              : const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
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
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: captureButton(),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: (controller.absenSukses.value) ? focusButton() : Container(),
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
            : Container()
      ],
    );
  }

  Widget imagePreview() {
    return SizedBox(
        width: Get.width,
        height: Get.height,
        child: (controller.savFile != null)
            ? Image.file(
                File(
                  controller.savFile!.path,
                ),
                fit: BoxFit.cover,
              )
            : const CupertinoActivityIndicator());
  }

  Widget cameraPreview() {
    return SizedBox(
        width: Get.width,
        height: Get.height,
        child: GestureDetector(
            onTap: () {
              controller.cameraController?.setFocusMode(FocusMode.auto);
            },
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
          controller.gagal.value = false;
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
