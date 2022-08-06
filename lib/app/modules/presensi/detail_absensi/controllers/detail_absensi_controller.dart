import 'package:face_id_plus/app/data/models/last_absen_model.dart';
import 'package:face_id_plus/app/data/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAbsensiController extends GetxController {
  var detail = Presensi().obs;
  final nama = RxnString(null);
  DateFormat fmt = DateFormat("dd MMMM yyyy");
  final fromList = false.obs;
  @override
  void onInit() async {
    getPref();
    var det = await Get.arguments['detail'] as Presensi;
    var fr = Get.arguments['fromList'];
    if (fr != null) {
      fromList.value = fr;
    }
    if (det != null) {
      detail.value = det;
    }
    print("detail ${detail.value.faceIn}");
    super.onInit();
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    nama.value = pref.getString(Constants.namaAbsen);
    print("nama ${nama.value}");
  }
}
