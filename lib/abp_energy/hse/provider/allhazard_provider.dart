import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:face_id_plus/abp_energy/hse/models/all_hazard_model.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class AllHazardProvider {
  Future<AllHazard?> getAllHazard(
      int disetujui, int page, String dari, String sampai) async {
    var api = await http.get(Uri.parse(
        "${Constants.BASEURL}api/v1/hazard/safety?user_valid=$disetujui&page=$page&dari=$dari&sampai=$sampai"));

    var jsonObject = json.decode(api.body);
    var decoJson = AllHazard.fromJson(jsonObject);
    return decoJson;
  }
}
