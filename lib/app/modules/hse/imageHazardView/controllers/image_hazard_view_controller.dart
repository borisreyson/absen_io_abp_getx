import 'package:get/get.dart';

class ImageHazardViewController extends GetxController {
  final urlImg = ''.obs;
  @override
  void onInit() async {
    urlImg.value = Get.arguments['image'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
