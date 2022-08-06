import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LokasiMatiController extends GetxController {
  late bool serviceEnable = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> locatePosition() async {
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (serviceEnable) {
      return true;
    } else {
      return false;
    }
  }
}
