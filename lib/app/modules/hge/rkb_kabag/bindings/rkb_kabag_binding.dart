import 'package:get/get.dart';

import '../controllers/rkb_kabag_controller.dart';

class RkbKabagBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RkbKabagController>(
      () => RkbKabagController(),
    );
  }
}
