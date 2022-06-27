import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/image_hazard_view_controller.dart';

class ImageHazardViewView extends GetView<ImageHazardViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.blue,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.download,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            _loadImage(context),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _loadImage(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
          elevation: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: controller.urlImg.value,
              fit: BoxFit.fitWidth,
              placeholder: (contex, url) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
    );
  }
}
