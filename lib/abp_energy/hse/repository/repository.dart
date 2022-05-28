import 'package:face_id_plus/abp_energy/hse/models/all_hazard_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/counter_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/data_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_post.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_user.dart';
import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/metrik_resiko_model.dart';
import 'package:face_id_plus/abp_energy/hse/provider/provider.dart';
import 'package:face_id_plus/abp_energy/master/model/detail_keparahan_model.dart';
import 'package:face_id_plus/abp_energy/master/model/detail_pengendalian_model.dart';
import 'package:face_id_plus/abp_energy/master/model/lokasi_model.dart';
import 'package:face_id_plus/abp_energy/master/model/pengendalian.dart';
import 'package:face_id_plus/abp_energy/master/model/perusahaan_model.dart';
import 'package:face_id_plus/abp_energy/master/model/user_profile.dart';
import 'package:face_id_plus/abp_energy/master/model/users_model.dart';
import 'package:face_id_plus/abp_energy/master/model/berita.dart' as berita;

class KemungkinanRepository {
  final _provider = KemungkinanProvider();
  Future<KemungkinanResiko?> fetchAll() async {
    return await _provider.getKemungkinan();
  }
}

class KeparahanRepository {
  final _provider = KeparahanProvider();
  Future<KeparahanResiko?> fetchAll() async {
    return await _provider.getKeparahan();
  }
}

class MetrikRepository {
  final _provider = MertikResikoProvider();
  Future<MetrikModel?> fetchAll() async {
    return await _provider.getMetrik();
  }
}

class PerusahaanRepository {
  final _provider = PerusahaanProvider();
  Future<PerusahaanModel?> fetchAll() async {
    return await _provider.getPerusahaan();
  }
}

class LokasiRepository {
  final _provider = LokasiProvider();
  Future<LokasiModel?> fetchAll() async {
    return await _provider.getLokasi();
  }
}

class DetKeparahanRepository {
  final _provider = DetKeparahanProvider();
  Future<DetailKeparahanModel?> fetchAll() async {
    return await _provider.getDetKeparahan();
  }
}

class PengendalianRepository {
  final _provider = PengendalianProvider();
  Future<PengendalianModel?> fetchAll() async {
    return await _provider.getPengendalian();
  }
}

class DetPengendalianRepository {
  final _provider = DetPengendalianProvider();
  Future<DetPengendalianModel?> fetchAll() async {
    return await _provider.getDetPengendalian();
  }
}

class UsersRepository {
  final _provider = UsersProvider();
  Future<UsersModel?> fetchAll() async {
    return await _provider.getUsers();
  }

  Future<UserProfileModel?> fetchUserProfile(username) async {
    return await _provider.getUsersProfile(username);
  }
}

class HazardPostRepository {
  final _provider = HazardProvider();
  Future<ResultHazardPost?> postHazard(data, idDevice) async {
    return await _provider.postHazard(data, idDevice);
  }

  Future<ResultHazardPost?> postHazardSelesai(data, idDevice) async {
    return await _provider.postHazardSelesai(data, idDevice);
  }

  Future<ResultHazardPost?> postUpdateHazard(data, idDevice) async {
    return await _provider.postUpdateHazard(data, idDevice);
  }
}

class HazardRepository {
  final _provider = HazardProvider();
  Future<AllHazard?> getAllHazard(
      int disetujui, int page, String dari, String sampai) async {
    return await _provider.getAllHazard(disetujui, page, dari, sampai);
  }

  Future<CounterHazard?> counterHazard(username, nik) async {
    return await _provider.counterHazard(username, nik);
  }

  Future<HazardUser?> getHazardUser(
      username, disetujui, page, dari, sampai) async {
    return await _provider.getHazardUser(
        username, disetujui, page, dari, sampai);
  }

  Future<HazardUser?> getHazardKeSaya(
      nik, disetujui, page, dari, sampai) async {
    return await _provider.getHazardKeSaya(nik, disetujui, page, dari, sampai);
  }

  Future<Data?> getHazardDetail(uid) async {
    return await _provider.getHazardDetail(uid);
  }

  Future<ResultHazardPost?> postGambarBukti(data, idDevice) async {
    return await _provider.postGambarBukti(data, idDevice);
  }

  Future<ResultHazardPost?> postGambarPerbaikan(data, idDevice) async {
    return await _provider.postGambarPerbaikan(data, idDevice);
  }

  Future<ResultHazardPost?> postUpdateDeskripsi(uid, tipe, deskripsi) async {
    return await _provider.postUpdateDeskripsi(uid, tipe, deskripsi);
  }

  Future<ResultHazardPost?> postUpdateResiko(uid, tipe, idResiko) async {
    return await _provider.postUpdateResiko(uid, tipe, idResiko);
  }

  Future<ResultHazardPost?> postUpdatePengendalian(uid, idPengendalian) async {
    return await _provider.postUpdatePengendalian(uid, idPengendalian);
  }

  Future<ResultHazardPost?> postUpdateKatBahaya(uid, katBahaya) async {
    return await _provider.postUpdateKatBahaya(uid, katBahaya);
  }
}

class BeritaRepository {
  final _provider = BeritaProvider();
  Future<berita.BeritaModel?> getBuletin(page) async {
    return await _provider.getBuletin(page);
  }
}
