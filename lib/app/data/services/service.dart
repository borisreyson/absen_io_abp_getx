import '../models/detail_keparahan_model.dart';
import '../models/detail_pengendalian_model.dart';
import '../models/device_update_model.dart';
import '../models/kemungkinan_model.dart';
import '../models/keparahan_model.dart';
import '../models/lokasi_model.dart';
import '../models/metrik_resiko_model.dart';
import '../models/pengendalian.dart';
import '../models/perusahaan_model.dart';
import '../models/users_model.dart';
import '../repository/repository_sqlite.dart';
import '../utils/constants.dart';

class KemungkinanService {
  late ReporsitoryKemungkinan _repository;
  KemungkinanService() {
    _repository = ReporsitoryKemungkinan();
  }

  save(data) async {
    return await _repository.insert(Constants.kemungkinanTb, data);
  }

  Future<Kemungkinan> getBy({int? idKemungkinan}) async {
    var res = await _repository.getById(
        table: Constants.kemungkinanTb, idKemungkinan: idKemungkinan);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.kemungkinanTb);
    return res;
  }
}

class KeparahanService {
  late RepositoryKeparahan _repository;
  KeparahanService() {
    _repository = RepositoryKeparahan();
  }

  save(data) async {
    return await _repository.insert(Constants.keparahanTb, data);
  }

  Future<Keparahan> getBy({int? idKeparahan}) async {
    var res = await _repository.getById(
        table: Constants.keparahanTb, idKeparahan: idKeparahan);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.keparahanTb);
    return res;
  }
}

class MetrikService {
  late RepositoryMetrik _repository;
  MetrikService() {
    _repository = RepositoryMetrik();
  }

  save(data) async {
    return await _repository.insert(Constants.metrikTb, data);
  }

  Future<MetrikResiko> getBy({int? nilai}) async {
    var res =
        await _repository.getById(table: Constants.metrikTb, nilai: nilai);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.metrikTb);
    return res;
  }
}

class PerusahaanService {
  late ReporsitoryPerusahaan _repository;
  PerusahaanService() {
    _repository = ReporsitoryPerusahaan();
  }

  save(data) async {
    return await _repository.insert(Constants.perusahaanTb, data);
  }

  Future<Company> getBy({int? idPerusahaan}) async {
    var res = await _repository.getById(
        table: Constants.perusahaanTb, idPerusahaan: idPerusahaan);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.perusahaanTb);
    return res;
  }
}

class LokasiService {
  late ReporsitoryLokasi _repository;
  LokasiService() {
    _repository = ReporsitoryLokasi();
  }

  save(data) async {
    return await _repository.insert(Constants.lokasiTb, data);
  }

  Future<Lokasi> getBy({int? idLok}) async {
    var res =
        await _repository.getById(table: Constants.lokasiTb, idLok: idLok);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.lokasiTb);
    return res;
  }
}

class DetaikKeparahanService {
  late RepositoryDetKeparahan _repository;
  DetaikKeparahanService() {
    _repository = RepositoryDetKeparahan();
  }

  save(data) async {
    return await _repository.insert(Constants.detKeparahanTb, data);
  }

  Future<List<DetKeparahan>> getBy({int? idKep}) async {
    var res = await _repository.getById(
        table: Constants.detKeparahanTb, idKep: idKep);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.detKeparahanTb);
    return res;
  }
}

class PengendalianService {
  late RepositoryPengendalian _repository;
  PengendalianService() {
    _repository = RepositoryPengendalian();
  }

  save(data) async {
    return await _repository.insert(Constants.pengendalianTb, data);
  }

  Future<List<Hirarki>> getBy({int? idHirarki}) async {
    var res = await _repository.getById(
        table: Constants.pengendalianTb, idHirarki: idHirarki);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.pengendalianTb);
    return res;
  }
}

class DetailPengendalianService {
  late RepositoryDetPengendalian _repository;
  DetailPengendalianService() {
    _repository = RepositoryDetPengendalian();
  }

  save(data) async {
    return await _repository.insert(Constants.detPengendalianTb, data);
  }

  Future<List<DetHirarki>> getBy({int? idHirarki}) async {
    var res = await _repository.getById(
        table: Constants.detPengendalianTb, idHirarki: idHirarki);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.detPengendalianTb);
    return res;
  }
}

class UsersService {
  late RepositoryUsers _repository;
  UsersService() {
    _repository = RepositoryUsers();
  }

  save(data) async {
    return await _repository.insert(Constants.usersTb, data);
  }

  Future<List<UsersList>> getBy({int? idUser}) async {
    var res =
        await _repository.getById(table: Constants.usersTb, idUser: idUser);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.usersTb);
    return res;
  }
}

class DeviceUpdateService {
  late RepositoryDeviceUpdate _repository;
  DeviceUpdateService() {
    _repository = RepositoryDeviceUpdate();
  }

  save(data) async {
    return await _repository.insert(Constants.deviceUpdatTb, data);
  }

  update(data) async {
    return await _repository.update(Constants.deviceUpdatTb, data);
  }

  Future<List<DeviceUpdate>> getAll() async {
    var res = await _repository.getAll(table: Constants.deviceUpdatTb);
    return res;
  }

  Future<List<DeviceUpdate>> getBy({String? idDevice}) async {
    var res = await _repository.getById(
        table: Constants.deviceUpdatTb, idDevice: idDevice);
    return res;
  }

  deletAll() async {
    var res = await _repository.deleteAll(Constants.deviceUpdatTb);
    return res;
  }
}
