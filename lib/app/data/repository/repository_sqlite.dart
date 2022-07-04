import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../../sqlite_db/db_helper.dart';
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

class ReporsitoryKemungkinan {
  late DbHelper _dbHelper;
  ReporsitoryKemungkinan() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, data) async {
    var conn = await db;
    var qRes = await conn!.rawQuery(
        "SELECT * FROM $table WHERE idKemungkinan = '${data.idKemungkinan}'");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['kemungkinan_update'] != data.kemungkinanUpdate) {
          if (kDebugMode) {
            print("data 100");
          }
          return await conn.update(table, data.toJson(),
              where: "idKemungkinan = ?", whereArgs: ['${data.idKemungkinan}']);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<Kemungkinan> getById({String? table, int? idKemungkinan}) async {
    var conn = await db;
    List<Kemungkinan> data = [];
    var res = await conn!.rawQuery(
        "SELECT * FROM $table WHERE idKemungkinan = '$idKemungkinan'");
    for (var e in res) {
      data.add(Kemungkinan.fromJson(e));
    }
    return data.first;
  }

  Future<List<Kemungkinan>> getAll({String? table}) async {
    var conn = await db;
    List<Kemungkinan> data = [];
    var res = await conn!
        .rawQuery("SELECT * FROM $table order by idKemungkinan desc");
    for (var e in res) {
      data.add(Kemungkinan.fromJson(e));
    }
    return data;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}

class RepositoryKeparahan {
  late DbHelper _dbHelper;
  RepositoryKeparahan() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, Keparahan data) async {
    var conn = await db;
    var qRes = await conn!.rawQuery(
        "SELECT * FROM $table WHERE idKeparahan = '${data.idKeparahan}'");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['keparahan_update'] != data.keparahanUpdate) {
          return await conn.update(table, data.toJson(),
              where: "idKeparahan = ?", whereArgs: ['${data.idKeparahan}']);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<Keparahan> getById({String? table, int? idKeparahan}) async {
    var conn = await db;
    List<Keparahan> data = [];
    var res = await conn!
        .rawQuery("SELECT * FROM $table WHERE idKeparahan = '$idKeparahan'");
    for (var e in res) {
      data.add(Keparahan.fromJson(e));
    }
    return data.first;
  }

  Future<List<Keparahan>> getAll({String? table}) async {
    var conn = await db;
    List<Keparahan> data = [];
    var res = await conn!.rawQuery("SELECT * FROM $table");
    for (var e in res) {
      data.add(Keparahan.fromJson(e));
    }
    return data;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}

class RepositoryMetrik {
  late DbHelper _dbHelper;
  RepositoryMetrik() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, MetrikResiko data) async {
    var conn = await db;
    var qRes = await conn!
        .rawQuery("SELECT * FROM $table WHERE idResiko = '${data.idResiko}'");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['resiko_update'] != data.resikoUpdate) {
          return await conn.update(table, data.toJson(),
              where: "idResiko = ?", whereArgs: ['${data.idResiko}']);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<MetrikResiko> getById({String? table, int? nilai}) async {
    var conn = await db;
    List<MetrikResiko> data = [];
    var res = await conn!
        .rawQuery("SELECT * FROM $table WHERE max >= $nilai and min <= $nilai");
    for (var e in res) {
      data.add(MetrikResiko.fromJson(e));
    }
    return data.first;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}

class ReporsitoryPerusahaan {
  late DbHelper _dbHelper;
  ReporsitoryPerusahaan() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, Company data) async {
    var conn = await db;
    var qRes = await conn!.rawQuery(
        "SELECT count(*) FROM $table WHERE id_perusahaan = ${data.idPerusahaan}");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['time_in'] != data.timeIn) {
          return await conn.update(table, data.toJson(),
              where: "id_perusahaan = ?", whereArgs: [data.idPerusahaan]);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<Company> getById({String? table, int? idPerusahaan}) async {
    var conn = await db;
    List<Company> data = [];
    var res = await conn!
        .rawQuery("SELECT * FROM $table WHERE id_perusahaan =$idPerusahaan");
    for (var e in res) {
      data.add(Company.fromJson(e));
    }
    return data.first;
  }

  Future<List<Company>> getAll({String? table}) async {
    var conn = await db;
    List<Company> data = [];
    var res = await conn!.rawQuery("SELECT * FROM $table");
    for (var e in res) {
      data.add(Company.fromJson(e));
    }
    return data;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}

class ReporsitoryLokasi {
  late DbHelper _dbHelper;
  ReporsitoryLokasi() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, Lokasi data) async {
    var conn = await db;
    var qRes = await conn!
        .rawQuery("SELECT count(*) FROM $table WHERE idLok = ${data.idLok}");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['tgl_input'] != data.tglInput) {
          return await conn.update(table, data.toJson(),
              where: "idLok = ?", whereArgs: [data.idLok]);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<Lokasi> getById({String? table, int? idLok}) async {
    var conn = await db;
    List<Lokasi> data = [];
    var res = await conn!.rawQuery("SELECT * FROM $table WHERE idLok =$idLok");
    for (var e in res) {
      data.add(Lokasi.fromJson(e));
    }
    return data.first;
  }

  Future<List<Lokasi>> getAll({String? table}) async {
    var conn = await db;
    List<Lokasi> data = [];
    var res = await conn!.rawQuery("SELECT * FROM $table");
    for (var e in res) {
      data.add(Lokasi.fromJson(e));
    }
    return data;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}

class RepositoryDetKeparahan {
  late DbHelper _dbHelper;
  RepositoryDetKeparahan() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, DetKeparahan data) async {
    var conn = await db;
    var qRes = await conn!
        .rawQuery("SELECT count(*) FROM $table WHERE id_det = ${data.idDet}");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['time_input'] != data.timeInput) {
          return await conn.update(table, data.toJson(),
              where: "id_det = ?", whereArgs: [data.idDet]);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<List<DetKeparahan>> getById({String? table, int? idKep}) async {
    var conn = await db;
    List<DetKeparahan> data = [];
    var res =
        await conn!.rawQuery("SELECT * FROM $table WHERE idKeparahan =$idKep");
    for (var e in res) {
      data.add(DetKeparahan.fromJson(e));
    }
    return data;
  }

  Future<List<DetKeparahan>> getAll({String? table}) async {
    var conn = await db;
    List<DetKeparahan> data = [];
    var res = await conn!.rawQuery("SELECT * FROM $table");
    for (var e in res) {
      data.add(DetKeparahan.fromJson(e));
    }
    return data;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}

class RepositoryPengendalian {
  late DbHelper _dbHelper;
  RepositoryPengendalian() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, Hirarki data) async {
    var conn = await db;
    var qRes = await conn!.rawQuery(
        "SELECT count(*) FROM $table WHERE idHirarki = ${data.idHirarki}");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['tgl_input'] != data.tglInput) {
          return await conn.update(table, data.toJson(),
              where: "idHirarki = ?", whereArgs: [data.idHirarki]);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<List<Hirarki>> getById({String? table, int? idHirarki}) async {
    var conn = await db;
    List<Hirarki> data = [];
    var res = await conn!
        .rawQuery("SELECT * FROM $table WHERE idHirarki =$idHirarki");
    for (var e in res) {
      data.add(Hirarki.fromJson(e));
    }
    return data;
  }

  Future<List<Hirarki>> getAll({String? table}) async {
    var conn = await db;
    List<Hirarki> data = [];
    var res = await conn!.rawQuery("SELECT * FROM $table");
    for (var e in res) {
      data.add(Hirarki.fromJson(e));
    }
    return data;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}

class RepositoryDetPengendalian {
  late DbHelper _dbHelper;
  RepositoryDetPengendalian() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, DetHirarki data) async {
    var conn = await db;
    var qRes = await conn!
        .rawQuery("SELECT count(*) FROM $table WHERE id_ket = ${data.idKet}");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['time_input'] != data.timeInput) {
          return await conn.update(table, data.toJson(),
              where: "id_ket = ?", whereArgs: [data.idKet]);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<List<DetHirarki>> getById({String? table, int? idHirarki}) async {
    var conn = await db;
    List<DetHirarki> data = [];
    var res = await conn!
        .rawQuery("SELECT * FROM $table WHERE id_hirarki =$idHirarki");
    for (var e in res) {
      data.add(DetHirarki.fromJson(e));
    }
    return data;
  }

  Future<List<DetHirarki>> getAll({String? table}) async {
    var conn = await db;
    List<DetHirarki> data = [];
    var res = await conn!.rawQuery("SELECT * FROM $table");
    for (var e in res) {
      data.add(DetHirarki.fromJson(e));
    }
    return data;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}

class RepositoryUsers {
  late DbHelper _dbHelper;
  RepositoryUsers() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, UsersList data) async {
    var conn = await db;
    var qRes = await conn!
        .rawQuery("SELECT count(*) FROM $table WHERE id_user = ${data.idUser}");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['user_update'] != data.userUpdate) {
          return await conn.update(table, data.toJson(),
              where: "id_user = ?", whereArgs: [data.idUser]);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<List<UsersList>> getById({String? table, int? idUser}) async {
    var conn = await db;
    List<UsersList> data = [];
    var res =
        await conn!.rawQuery("SELECT * FROM $table WHERE id_user =$idUser");
    for (var e in res) {
      data.add(UsersList.fromJson(e));
    }
    return data;
  }

  Future<List<UsersList>> cariNama({String? table, nama}) async {
    var conn = await db;
    List<UsersList> data = [];
    var res = await conn!.rawQuery(
        "SELECT * FROM $table WHERE nama_lengkap LIKE '%" + nama + "%'");
    for (var e in res) {
      data.add(UsersList.fromJson(e));
    }
    return data;
  }

  Future<List<UsersList>> getAll({String? table}) async {
    var conn = await db;
    List<UsersList> data = [];
    var res = await conn!.rawQuery("SELECT * FROM $table");
    for (var e in res) {
      data.add(UsersList.fromJson(e));
    }
    return data;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}

class RepositoryDeviceUpdate {
  late DbHelper _dbHelper;
  RepositoryDeviceUpdate() {
    _dbHelper = DbHelper();
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _dbHelper.setDatabase();
      return _db;
    }
  }

  insert(table, DeviceUpdate data) async {
    var conn = await db;
    var qRes = await conn!.rawQuery(
        "SELECT count(*) FROM $table WHERE idDevice = '${data.idDevice}' and tipe ='${data.tipe}'");
    var res = Sqflite.firstIntValue(qRes);
    if (res != null) {
      if (res > 0) {
        if (qRes[0]['timeUpdate'] != data.timeUpdate) {
          return await conn.update(table, data.toJson(),
              where: "idDevice = ?", whereArgs: [data.idDevice]);
        }
        return 0;
      } else {
        return await conn.insert(table, data.toJson());
      }
    } else {
      return await conn.insert(table, data.toJson());
    }
  }

  Future<List<DeviceUpdate>> getById({String? table, String? idDevice}) async {
    var conn = await db;
    List<DeviceUpdate> data = [];
    var res = await conn!
        .rawQuery("SELECT * FROM $table WHERE idDevice ='$idDevice'");
    for (var e in res) {
      data.add(DeviceUpdate.fromJson(e));
    }
    return data;
  }

  Future<List<DeviceUpdate>> cariNama({String? table, idDevice}) async {
    var conn = await db;
    List<DeviceUpdate> data = [];
    var res = await conn!.rawQuery(
        "SELECT * FROM $table WHERE idDevice LIKE '%" + idDevice + "%'");
    for (var e in res) {
      data.add(DeviceUpdate.fromJson(e));
    }
    return data;
  }

  Future<List<DeviceUpdate>> getAll({String? table}) async {
    var conn = await db;
    List<DeviceUpdate> data = [];
    var res = await conn!.rawQuery("SELECT * FROM $table");
    for (var e in res) {
      data.add(DeviceUpdate.fromJson(e));
    }
    return data;
  }

  deleteAll(table) async {
    var conn = await db;
    var res = await conn?.delete(table);
    return res;
  }
}
