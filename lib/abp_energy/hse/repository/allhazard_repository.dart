import 'package:face_id_plus/abp_energy/hse/models/all_hazard_model.dart';
import 'package:face_id_plus/abp_energy/hse/provider/allhazard_provider.dart';

class AllHazardRepository {
  final _provider = AllHazardProvider();
  Future<AllHazard?> fetchAllHazard(
      int disetujui, int page, String dari, String sampai) async {
    return _provider.getAllHazard(disetujui, page, dari, sampai);
  }
}
