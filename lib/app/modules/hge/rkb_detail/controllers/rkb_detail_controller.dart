import 'package:face_id_plus/app/data/models/rkb_models.dart';
import 'package:get/get.dart';

import '../../../../data/models/rkb_detail_models.dart';
import '../../../../data/providers/provider.dart';

class RkbDetailController extends GetxController {
  final provider = Provider();
  final idHeader = RxnString();
  final noRkb = RxnString();
  final data = <RkbDetail>[].obs;
  @override
  void onInit() {
    idHeader.value = Get.arguments['idHeader'];
    noRkb.value = Get.arguments['noRkb'];

    getDetail();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getDetail() async {
    await provider.getRkbDetail(idHeader.value).then((value) {
      if (value != null) {
        if (value.rkbDetail != null) {
          data.addAll(value.rkbDetail!);
        }
      }
    });
  }
}
