import 'package:face_id_plus/app/data/models/list_presensi_models.dart';
import 'package:face_id_plus/app/data/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAbsensiController extends GetxController {
  final detail = ListPresensi().obs;
  final nama = RxnString(null);
  @override
  void onInit() {
    getPref();
    detail.value = Get.arguments['detail'];
    super.onInit();
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    nama.value = pref.getString("nama");
  }
}
