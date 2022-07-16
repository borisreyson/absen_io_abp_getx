import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/utils/constants.dart';

class ProfileController extends GetxController {
  final nama = ''.obs;
  final nik = ''.obs;
  final foto = ''.obs;
  @override
  void onInit() {
    getPref();
    super.onInit();
  }


  @override
  void onClose() {}
  getPref() async {
    var pref = await SharedPreferences.getInstance();
    nama.value = pref.getString("nama")!;
    nik.value = pref.getString("nik")!;
    foto.value = pref.getString(Constants.fotoProfile)!;
  }

  logOut() async {
    var pref = await SharedPreferences.getInstance();
    if (await pref.remove(Constants.isLogin)) {
      Get.back(result: true);
    }
  }
}
