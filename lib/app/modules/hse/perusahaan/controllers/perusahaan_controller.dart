import 'package:face_id_plus/app/sqlite_db/table.dart';
import 'package:get/get.dart';

import '../../../../data/models/perusahaan_model.dart';
import '../../../../data/repository/repository_sqlite.dart';
import '../../../../data/utils/constants.dart';

class PerusahaanController extends GetxController {
  final repository = ReporsitoryPerusahaan();
  final data = (List<Company>.of([])).obs();
  final isLoading = true.obs;
  @override
  void onInit() async {
    await repository.getAll(table: Constants.perusahaanTb).then((result) {
      if (result != null) {
        for (var element in result) {
          print("result ${element.namaPerusahaan}");

          data.add(element);
        }
      }
    }).whenComplete(() => isLoading.value = false);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
