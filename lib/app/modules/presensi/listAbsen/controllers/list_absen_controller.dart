import 'package:face_id_plus/app/data/models/last_absen_model.dart';
import 'package:face_id_plus/app/data/providers/provider.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/models/list_absen.dart';
import '../../../../data/utils/constants.dart';


class ListAbsenController extends GetxController {
  final _provider = Provider();
  final nik = ''.obs;
  final nama = ''.obs;
  final status = 'masuk'.obs;
  final listAbsen = <Presensi>[].obs;
  final page = 1.obs;
  late RefreshController pullRefresh;
  final lastPage = 1.obs;
  @override
  void onInit() {
    listAbsen.value.clear();
    pullRefresh = RefreshController();
    getpref();
    super.onInit();
  }

  @override
  void onClose() {}
  loadListAbsen(int hal) async {
    await _provider
        .listAbsensiUser(nik: nik.value, status: status.value, page: hal)
        .then((AbsenList? result) {
      if (result != null) {
        var presensi = result.listAbsen;
        if (presensi != null && presensi.data != null) {
          lastPage.value = presensi.lastPage!;
          presensi.data?.forEach((element) {
            // ignore: invalid_use_of_protected_member
            listAbsen.add(element);
            print("Loop ${element.status}");
          });
          pullRefresh.loadComplete();
        }
      }
    });
  }

  getpref() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getBool(Constants.isLogin) != null) {
      nik.value = pref.getString(Constants.nik)!;
      nama.value = pref.getString(Constants.name)!;
      loadListAbsen(page.value);
    }
  }

  void loadingPage() async {
    if (page.value < lastPage.value) {
      page.value++;
    }
    loadListAbsen(page.value);
    pullRefresh.loadComplete();
    pullRefresh.refreshCompleted();
  }

  doRefresh() {
    listAbsen.clear();
    page.value = 1;
    loadListAbsen(page.value);
    pullRefresh.loadComplete();
    pullRefresh.refreshCompleted();
  }
}
