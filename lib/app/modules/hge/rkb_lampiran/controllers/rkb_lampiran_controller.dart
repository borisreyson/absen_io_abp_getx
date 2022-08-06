import 'package:face_id_plus/app/data/models/lampiran_rkb.dart';
import 'package:get/get.dart';

import '../../../../data/providers/provider.dart';

class RkbLampiranController extends GetxController {
  final provider = Provider();
  final data = <Lampiran>[].obs;
  final noRkb = RxnString(null);
  final loaded = false.obs;
  @override
  void onInit() async {
    noRkb.value = Get.arguments['noRkb'];
    if (noRkb.value != null) {
      print("noRKb ${noRkb.value}");

      await provider.getLampiranRKB(noRkb.value).then((value) {
        if (value != null) {
          var lampiran = value.lampiran;
          if (lampiran != null) {
            data.addAll(lampiran);
            loaded.value = true;
          }
        } else {
          print("noRKb ${noRkb.value}");
        }
      });
    } else {
      print("noRKb ${noRkb.value}");
    }
    super.onInit();
  }
}
