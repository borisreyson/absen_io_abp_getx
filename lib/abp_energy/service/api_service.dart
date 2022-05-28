import 'package:flutter/foundation.dart';
import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/metrik_resiko_model.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/master/model/detail_keparahan_model.dart';
import 'package:face_id_plus/abp_energy/master/model/detail_pengendalian_model.dart';
import 'package:face_id_plus/abp_energy/master/model/lokasi_model.dart';
import 'package:face_id_plus/abp_energy/master/model/pengendalian.dart';
import 'package:face_id_plus/abp_energy/master/model/perusahaan_model.dart';
import 'package:face_id_plus/abp_energy/master/model/users_model.dart';
import 'package:face_id_plus/abp_energy/service/service.dart';

class ApiService {
  Future kemungkinanGet() async {
    await KemungkinanRepository().fetchAll().then((data) async {
      if (data != null) {
        if (data.kemungkinan != null) {
          var _data = data.kemungkinan;
          for (var e in _data!) {
            var _kemungkinan = Kemungkinan();
            _kemungkinan.idKemungkinan = e.idKemungkinan;
            _kemungkinan.kemungkinan = e.kemungkinan;
            _kemungkinan.keterangan = e.keterangan;
            _kemungkinan.nilai = e.nilai;
            _kemungkinan.flag = e.flag;
            _kemungkinan.kemungkinanUpdate = e.kemungkinanUpdate;
            var res = await KemungkinanService().save(_kemungkinan);
            if (kDebugMode) {
              print("Kemungkinan $res");
            }
          }
        }
      }
    });
  }

  Future keparahanGet() async {
    await KeparahanRepository().fetchAll().then((data) async {
      if (data != null) {
        if (data.keparahan != null) {
          var _data = data.keparahan;
          for (var e in _data!) {
            var _keparahan = Keparahan();
            _keparahan.idKeparahan = e.idKeparahan;
            _keparahan.keparahan = e.keparahan;
            _keparahan.nilai = e.nilai;
            _keparahan.flag = e.flag;
            _keparahan.keparahanUpdate = e.keparahanUpdate;
            var res = await KeparahanService().save(_keparahan);
            if (kDebugMode) {
              print("Keparahan $res");
            }
          }
        }
      }
    });
  }

  Future metrikGet() async {
    await MetrikRepository().fetchAll().then((data) async {
      if (data != null) {
        if (data.metrikResiko != null) {
          var _data = data.metrikResiko;
          for (var e in _data!) {
            var _metrik = MetrikResiko();
            _metrik.batas = e.batas;
            _metrik.bgColor = e.bgColor;
            _metrik.flag = e.flag;
            _metrik.idResiko = e.idResiko;
            _metrik.kategori = e.kategori;
            _metrik.kodeBahaya = e.kodeBahaya;
            _metrik.max = e.max;
            _metrik.min = e.min;
            _metrik.tindakan = e.tindakan;
            _metrik.txtColor = e.txtColor;
            var res = await MetrikService().save(_metrik);
            if (kDebugMode) {
              print("Metrik $res");
            }
          }
        }
      }
    });
  }

  Future perusahaanGet() async {
    await PerusahaanRepository().fetchAll().then((data) async {
      if (data != null) {
        if (data.company != null) {
          var _data = data.company;
          for (var e in _data!) {
            var _perusahaan = Company();
            _perusahaan.idPerusahaan = e.idPerusahaan;
            _perusahaan.namaPerusahaan = e.namaPerusahaan;
            _perusahaan.flag = e.flag;
            _perusahaan.timeIn = e.timeIn;
            var res = await PerusahaanService().save(_perusahaan);
            if (kDebugMode) {
              print("Perusahaan $res");
            }
          }
        }
      }
    });
  }

  Future lokasiGet() async {
    await LokasiRepository().fetchAll().then((data) async {
      if (data != null) {
        if (data.lokasi != null) {
          var _data = data.lokasi;
          for (var e in _data!) {
            var data = Lokasi();
            data.idLok = e.idLok;
            data.lokasi = e.lokasi;
            data.desLokasi = e.desLokasi;
            data.userInput = e.userInput;
            data.tglInput = e.tglInput;
            var res = await LokasiService().save(data);
            if (kDebugMode) {
              print("Lokasi $res");
            }
          }
        }
      }
    });
  }

  Future detKeparahanGet() async {
    await DetKeparahanRepository().fetchAll().then((data) async {
      if (data != null) {
        if (data.detKeparahan != null) {
          var _data = data.detKeparahan;
          for (var e in _data!) {
            var data = DetKeparahan();
            data.idDet = e.idDet;
            data.idKeparahan = e.idKeparahan;
            data.keterangan = e.keterangan;
            data.ketInput = e.ketInput;
            data.timeInput = e.timeInput;
            var res = await DetaikKeparahanService().save(data);
            if (kDebugMode) {
              print("detKeparahan $res");
            }
          }
        }
      }
    });
  }

  Future pengendalianGet() async {
    await PengendalianRepository().fetchAll().then((data) async {
      if (data != null) {
        if (data.hirarki != null) {
          var _data = data.hirarki;
          for (var e in _data!) {
            var data = Hirarki();
            data.idHirarki = e.idHirarki;
            data.idKet = e.idKet;
            data.namaPengendalian = e.namaPengendalian;
            data.userInput = e.userInput;
            data.tglInput = e.tglInput;
            data.flag = e.flag;
            var res = await PengendalianService().save(data);
            if (kDebugMode) {
              print("Pengendalian $res");
            }
          }
        }
      }
    });
  }

  Future detPengendalianGet() async {
    await DetPengendalianRepository().fetchAll().then((data) async {
      if (data != null) {
        if (data.detHirarki != null) {
          var _data = data.detHirarki;
          for (var e in _data!) {
            var data = DetHirarki();
            data.idHirarki = e.idHirarki;
            data.idKet = e.idKet;
            data.keterangan = e.keterangan;
            data.ketInput = e.ketInput;
            data.timeInput = e.timeInput;
            var res = await DetailPengendalianService().save(data);
            if (kDebugMode) {
              print("Detail Pengendalian $res");
            }
          }
        }
      }
    });
  }

  Future usersGet() async {
    await UsersRepository().fetchAll().then((data) async {
      if (data != null) {
        if (data.usersList != null) {
          var _data = data.usersList;
          for (var e in _data!) {
            var data = UsersList();
            data.idUser = e.idUser;
            data.username = e.username;
            data.namaLengkap = e.namaLengkap;
            data.email = e.email;
            data.department = e.department;
            data.section = e.section;
            data.level = e.level;
            data.status = e.status;
            data.ttd = e.ttd;
            data.rule = e.rule;
            data.tglentry = e.tglentry;
            data.nik = e.nik;
            data.photoProfile = e.photoProfile;
            data.userUpdate = e.userUpdate;
            data.tokenPassword = e.tokenPassword;
            data.dept = e.dept;
            data.sect = e.sect;
            data.namaPerusahaan = e.namaPerusahaan;
            var res = await UsersService().save(data);
            if (kDebugMode) {
              print("Users $res");
            }
          }
        }
      }
    });
  }
}
