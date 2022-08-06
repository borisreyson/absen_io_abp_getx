import 'package:face_id_plus/app/data/models/last_absen_models.dart';
import 'package:get/get.dart';

class LastAbsenProvider extends GetConnect {
  Future<LastAbsenModels?> getLastAbsen(String nik, String company) async {
    print(nik);
    final response = await get(
        'https://lp.abpjobsite.com/api/v1/presensi/lastAbsen?nik=$nik&company=$company');
    return LastAbsenModels.fromJson(response.body);
  }
}
