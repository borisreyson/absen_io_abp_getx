import 'package:face_id_plus/app/data/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RkbController extends GetxController {
  final status = RxnString(null);
  final nik = RxnString(null);
  final nama = RxnString(null);
  final section = RxnString(null);
  final dept = RxnString(null);
  final perusahaan = RxnString(null);

  @override
  void onInit() {
    getPref();
    status.value = Get.arguments['status'];
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

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    nik.value = pref.getString(Constants.nik);
    nama.value = pref.getString(Constants.name);
    section.value = pref.getString(Constants.section);
    dept.value = pref.getString(Constants.departement);
    perusahaan.value = pref.getString(Constants.company);
  }
}
