import 'package:get/get.dart';
import '../models/last_absen_model.dart';

class LastAbsenProvider extends GetConnect {
  Future<LastAbsen?> getLastAbsen(String nik, String company) async {
    final response = await get(
        'https://lp.abpjobsite.com/api/v1/presensi/lastAbsen?nik=$nik&company=$company');
    return LastAbsen.fromJson(response.body);
  }
}
