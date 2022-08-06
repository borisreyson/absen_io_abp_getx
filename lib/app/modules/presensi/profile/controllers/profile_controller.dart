import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/utils/constants.dart';

class ProfileController extends GetxController {
  final nama = RxnString('');
  final nik = RxnString('');
  final foto = RxnString('');
  @override
  void onInit() {
    getPref();
    super.onInit();
  }


  @override
  void onClose() {}
  getPref() async {
    var pref = await SharedPreferences.getInstance();
    nama.value = pref.getString(Constants.namaAbsen);
    nik.value = pref.getString(Constants.nikAbsen);
    foto.value = pref.getString(Constants.fotoProfile);
  }

  logOut() async {
    var pref = await SharedPreferences.getInstance();
    if (await pref.remove(Constants.isLogin)) {
      Get.back(result: true);
    }
  }
}
