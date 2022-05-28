import 'dart:convert';
import 'package:face_id_plus/abp_energy/hse/models/all_hazard_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/counter_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/data_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_post.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_user.dart';
import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/metrik_resiko_model.dart';
import 'package:face_id_plus/abp_energy/master/model/detail_keparahan_model.dart';
import 'package:face_id_plus/abp_energy/master/model/detail_pengendalian_model.dart';
import 'package:face_id_plus/abp_energy/master/model/lokasi_model.dart';
import 'package:face_id_plus/abp_energy/master/model/pengendalian.dart';
import 'package:face_id_plus/abp_energy/master/model/perusahaan_model.dart';
import 'package:face_id_plus/abp_energy/master/model/user_profile.dart';
import 'package:face_id_plus/abp_energy/master/model/users_model.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:face_id_plus/absensi/model/buletin_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:face_id_plus/abp_energy/master/model/berita.dart' as berita;

class KemungkinanProvider {
  Future<KemungkinanResiko?> getKemungkinan() async {
    var api = await http
        .get(Uri.parse("https://abpjobsite.com/hse/admin/resiko/kemungkinan"));

    var jsonObject = json.decode(api.body);
    var decoJson = KemungkinanResiko.fromJson(jsonObject);
    return decoJson;
  }
}

class KeparahanProvider {
  Future<KeparahanResiko?> getKeparahan() async {
    var api = await http
        .get(Uri.parse("https://abpjobsite.com/hse/admin/resiko/keparahan"));
    var jsonObject = json.decode(api.body);
    var decoJson = KeparahanResiko.fromJson(jsonObject);
    return decoJson;
  }
}

class MertikResikoProvider {
  Future<MetrikModel?> getMetrik() async {
    var api = await http
        .get(Uri.parse("https://abpjobsite.com/android/api/matrik/resiko"));
    var jsonObject = json.decode(api.body);
    var decoJson = MetrikModel.fromJson(jsonObject);
    return decoJson;
  }
}

class PerusahaanProvider {
  Future<PerusahaanModel?> getPerusahaan() async {
    var api = await http
        .get(Uri.parse("https://abpjobsite.com/android/api/get/perusahaan"));
    var jsonObject = json.decode(api.body);
    var decoJson = PerusahaanModel.fromJson(jsonObject);
    return decoJson;
  }
}

class LokasiProvider {
  Future<LokasiModel?> getLokasi() async {
    var api = await http
        .get(Uri.parse("https://abpjobsite.com/android/api/lokasi/get"));
    var jsonObject = json.decode(api.body);
    var decoJson = LokasiModel.fromJson(jsonObject);
    return decoJson;
  }
}

class DetKeparahanProvider {
  Future<DetailKeparahanModel?> getDetKeparahan() async {
    var api = await http.get(
        Uri.parse("https://abpjobsite.com/hse/admin/resiko/keparahan/detail"));
    var jsonObject = json.decode(api.body);
    var decoJson = DetailKeparahanModel.fromJson(jsonObject);
    return decoJson;
  }
}

class PengendalianProvider {
  Future<PengendalianModel?> getPengendalian() async {
    var api = await http.get(
        Uri.parse("https://abpjobsite.com/hse/admin/hiraiki/pengendalian"));
    var jsonObject = json.decode(api.body);
    var decoJson = PengendalianModel.fromJson(jsonObject);
    return decoJson;
  }

  getDetKeparahan() {}
}

class DetPengendalianProvider {
  Future<DetPengendalianModel?> getDetPengendalian() async {
    var api = await http.get(Uri.parse(
        "https://abpjobsite.com/hse/admin/hiraiki/pengendalian/detail"));
    var jsonObject = json.decode(api.body);
    var decoJson = DetPengendalianModel.fromJson(jsonObject);
    return decoJson;
  }
}

class UsersProvider {
  Future<UsersModel?> getUsers() async {
    var api = await http
        .get(Uri.parse("https://abpjobsite.com/android/api/list/users/all"));
    var jsonObject = json.decode(api.body);
    var decoJson = UsersModel.fromJson(jsonObject);
    return decoJson;
  }

  Future<UserProfileModel?> getUsersProfile(username) async {
    var api = await http.get(Uri.parse(
        "https://abpjobsite.com/android/api/get/user?username=$username"));
    var jsonObject = json.decode(api.body);
    var decoJson = UserProfileModel.fromJson(jsonObject);
    return decoJson;
  }
}

class HazardProvider {
  String baseUrl = "https://lp.abpjobsite.com/api/v1/hazard/";

  Future<ResultHazardPost?> postHazard(HazardPostModel data, idDevice) async {
    Map<String, dynamic>? _res;

    DateTime _dt = DateTime.now();

    String _filename = "${_dt.hour}".padLeft(2, "0") +
        "${_dt.minute}".padLeft(2, "0") +
        "${_dt.second}".padLeft(2, "0") +
        "_${idDevice}_sebelum.jpg";
    String _pjFoto = "${_dt.hour}".padLeft(2, "0") +
        "${_dt.minute}".padLeft(2, "0") +
        "${_dt.second}".padLeft(2, "0") +
        "_${idDevice}_penanggung_jawab.jpg";

    Uri uri = Uri.parse(baseUrl);

    var request = http.MultipartRequest("POST", uri);
    request.files.add(http.MultipartFile.fromBytes(
        'fileToUpload', await data.fileToUpload!.readAsBytes(),
        filename: _filename));
    request.files.add(http.MultipartFile.fromBytes(
        'fileToUploadPJ', await data.fileToUploadPJ!.readAsBytes(),
        filename: _pjFoto));

    request.fields['perusahaan'] = "${data.perusahaan}";
    request.fields['tgl_hazard'] = "${data.tglHazard}";
    request.fields['jam_hazard'] = "${data.jamHazard}";
    request.fields['lokasi'] = "${data.lokasi}";
    request.fields['lokasi_detail'] = "${data.lokasiDetail}";
    request.fields['deskripsi'] = "${data.deskripsi}";
    request.fields['kemungkinan'] = "${data.kemungkinan}";
    request.fields['keparahan'] = "${data.keparahan}";
    request.fields['katBahaya'] = "${data.katBahaya}";
    request.fields['pengendalian'] = "${data.pengendalian}";
    request.fields['tindakan'] = "${data.tindakan}";
    request.fields['namaPJ'] = "${data.namaPJ}";
    request.fields['nikPJ'] = "${data.nikPJ}";
    request.fields['status'] = "${data.status}";
    request.fields['tglTenggat'] = "${data.tglTenggat}";
    request.fields['user_input'] = "${data.userInput}";

    var response = await request.send();

    await for (String s in response.stream.transform(utf8.decoder)) {
      _res = jsonDecode(s);
    }
    return ResultHazardPost.fromJson(
      _res!,
    );
  }

  Future<ResultHazardPost?> postHazardSelesai(
      HazardPostSelesaiModel data, idDevice) async {
    Map<String, dynamic>? _res;

    DateTime _dt = DateTime.now();

    String _filename = "${_dt.hour}".padLeft(2, "0") +
        "${_dt.minute}".padLeft(2, "0") +
        "${_dt.second}".padLeft(2, "0") +
        "_${idDevice}_sebelum.jpg";

    String _pjFoto = "${_dt.hour}".padLeft(2, "0") +
        "${_dt.minute}".padLeft(2, "0") +
        "${_dt.second}".padLeft(2, "0") +
        "_${idDevice}_penanggung_jawab.jpg";

    String _fNameSelesai = "${_dt.hour}".padLeft(2, "0") +
        "${_dt.minute}".padLeft(2, "0") +
        "${_dt.second}".padLeft(2, "0") +
        "_${idDevice}_selesai.jpg";

    Uri uri = Uri.parse("${baseUrl}selesai");

    var request = http.MultipartRequest("POST", uri);

    request.files.add(http.MultipartFile.fromBytes(
        'fileToUpload', await data.fileToUpload!.readAsBytes(),
        filename: _filename));

    request.files.add(http.MultipartFile.fromBytes(
        'fileToUploadPJ', await data.fileToUploadPJ!.readAsBytes(),
        filename: _pjFoto));

    request.files.add(http.MultipartFile.fromBytes(
        'fileToUploadSelesai', await data.fileToUploadSelesai!.readAsBytes(),
        filename: _fNameSelesai));

    request.fields['perusahaan'] = "${data.perusahaan}";
    request.fields['tgl_hazard'] = "${data.tglHazard}";
    request.fields['jam_hazard'] = "${data.jamHazard}";
    request.fields['lokasi'] = "${data.lokasi}";
    request.fields['lokasi_detail'] = "${data.lokasiDetail}";
    request.fields['deskripsi'] = "${data.deskripsi}";
    request.fields['kemungkinan'] = "${data.kemungkinan}";
    request.fields['keparahan'] = "${data.keparahan}";
    request.fields['kemungkinanSesudah'] = "${data.kemungkinanSesudah}";
    request.fields['keparahanSesudah'] = "${data.keparahanSesudah}";
    request.fields['katBahaya'] = "${data.katBahaya}";
    request.fields['pengendalian'] = "${data.pengendalian}";
    request.fields['tindakan'] = "${data.tindakan}";
    request.fields['namaPJ'] = "${data.namaPJ}";
    request.fields['nikPJ'] = "${data.nikPJ}";
    request.fields['status'] = "${data.status}";
    request.fields['tglSelesai'] = "${data.tglSelesai}";
    request.fields['jamSelesai'] = "${data.jamSelesai}";
    request.fields['keteranganPJ'] = "${data.keteranganPJ}";
    request.fields['user_input'] = "${data.userInput}";

    var response = await request.send();

    await for (String s in response.stream.transform(utf8.decoder)) {
      _res = jsonDecode(s);
    }
    return ResultHazardPost.fromJson(_res!);
  }

  Future<ResultHazardPost?> postUpdateHazard(
      HazardUpdate data, idDevice) async {
    Map<String, dynamic>? _res;

    DateTime _dt = DateTime.now();

    String _filename = "${_dt.hour}".padLeft(2, "0") +
        "${_dt.minute}".padLeft(2, "0") +
        "${_dt.second}".padLeft(2, "0") +
        "_${idDevice}_selesai.jpg";

    Uri uri = Uri.parse("${baseUrl}update");

    var request = http.MultipartRequest("POST", uri);

    request.files.add(http.MultipartFile.fromBytes(
        'fileToUpload', await data.fileToUpload!.readAsBytes(),
        filename: _filename));

    request.fields['uid'] = "${data.uid}";
    request.fields['tgl_selesai'] = "${data.tglSelesai}";
    request.fields['jam_selesai'] = "${data.jamSelesai}";
    request.fields['idKemungkinanSesudah'] = "${data.idKemungkinanSesudah}";
    request.fields['idKeparahanSesudah'] = "${data.idKeparahanSesudah}";
    request.fields['keterangan'] = "${data.keterangan}";

    var response = await request.send();

    await for (String s in response.stream.transform(utf8.decoder)) {
      _res = jsonDecode(s);
    }
    return ResultHazardPost.fromJson(_res!);
  }

  Future<ResultHazardPost?> deleteHazard(uid) async {
    var api = await http.get(Uri.parse(
        "https://abpjobsite.com/android/api/hse/hazard/delete?uid=$uid"));
    var jsonObject = json.decode(api.body);
    var decoJson = ResultHazardPost.fromJson(jsonObject);
    return decoJson;
  }

  Future<HazardVerify?> verifyHazard(HazardVerify data) async {
    var api = await http.get(Uri.parse(
        "https://abpjobsite.com/android/api/hse/hazard/verify?uid=${data.uid}&option=${data.option}&username=${data.username}&keterangan=${data.keterangan}"));
    var jsonObject = json.decode(api.body);
    var decoJson = HazardVerify.fromJson(jsonObject);
    return decoJson;
  }

  Future<CounterHazard?> counterHazard(username, nik) async {
    if (kDebugMode) {
      print("nik $nik");
    }
    Uri uri = Uri.parse("${baseUrl}check?username=$username&nik=$nik");
    if (kDebugMode) {
      print("uri $uri");
    }
    var api = await http.get(uri);
    var jsonObject = json.decode(api.body);
    var decoJson = CounterHazard.fromJson(jsonObject);
    return decoJson;
  }

  Future<AllHazard?> getAllHazard(
      int disetujui, int page, String dari, String sampai) async {
    var api = await http.get(
      Uri.parse(
          "${Constants.BASEURL}api/v1/hazard/safety?user_valid=$disetujui&page=$page&dari=$dari&sampai=$sampai"),
    );

    var jsonObject = json.decode(api.body);
    var decoJson = AllHazard.fromJson(jsonObject);
    return decoJson;
  }

  Future<HazardUser?> getHazardUser(
    username,
    disetujui,
    page,
    dari,
    sampai,
  ) async {
    // Uri uri = Uri.parse(
    //     "https://abpjobsite.com/android/api/hse/list/hazard/report/online?username=$username&page=$page&dari=$dari&sampai=$sampai&user_valid=$disetujui");
    Uri uri = Uri.parse(
        "${baseUrl}user?username=$username&page=$page&dari=$dari&sampai=$sampai&user_valid=$disetujui");
    var api = await http.get(uri);

    var jsonObject = json.decode(api.body);
    var decoJson = HazardUser.fromJson(jsonObject);
    return decoJson;
  }

  Future<HazardUser?> getHazardKeSaya(
    nik,
    disetujui,
    page,
    dari,
    sampai,
  ) async {
    var api = await http.get(Uri.parse(
        "${baseUrl}kesaya?nik=$nik&page=$page&dari=$dari&sampai=$sampai&user_valid=$disetujui"));

    var jsonObject = json.decode(api.body);
    var decoJson = HazardUser.fromJson(jsonObject);
    return decoJson;
  }

  Future<ResultHazardPost?> postGambarBukti(
      HazardGambarBukti data, idDevice) async {
    Map<String, dynamic>? _res;

    DateTime _dt = DateTime.now();

    String _filename = "${_dt.hour}".padLeft(2, "0") +
        "${_dt.minute}".padLeft(2, "0") +
        "${_dt.second}".padLeft(2, "0") +
        "_${idDevice}_sebelum.jpg";

    Uri uri = Uri.parse("${baseUrl}rubah/gambar/temuan");

    var request = http.MultipartRequest("POST", uri);

    request.files.add(http.MultipartFile.fromBytes(
        'bukti_sebelum', await data.buktiSebelum!.readAsBytes(),
        filename: _filename));

    request.fields['uid'] = "${data.uid}";

    var response = await request.send();

    await for (String s in response.stream.transform(utf8.decoder)) {
      _res = jsonDecode(s);
    }
    return ResultHazardPost.fromJson(_res!);
  }

  Future<ResultHazardPost?> postGambarPerbaikan(
      HazardGambarPerbaikan data, idDevice) async {
    Map<String, dynamic>? _res;

    DateTime _dt = DateTime.now();

    String _filename = "${_dt.hour}".padLeft(2, "0") +
        "${_dt.minute}".padLeft(2, "0") +
        "${_dt.second}".padLeft(2, "0") +
        "_${idDevice}_selesai.jpg";

    Uri uri = Uri.parse("${baseUrl}rubah/gambar/perbaikan");

    var request = http.MultipartRequest("POST", uri);

    request.files.add(http.MultipartFile.fromBytes(
        'bukti_selesai', await data.buktiSelesai!.readAsBytes(),
        filename: _filename));

    request.fields['uid'] = "${data.uid}";

    var response = await request.send();

    await for (String s in response.stream.transform(utf8.decoder)) {
      _res = jsonDecode(s);
    }
    return ResultHazardPost.fromJson(_res!);
  }

  Future<Data?> getHazardDetail(
    uid,
  ) async {
    var api = await http.get(Uri.parse("${baseUrl}detail?uid=$uid"));

    var jsonObject = json.decode(api.body);
    var decoJson = Data.fromJson(jsonObject);
    return decoJson;
  }

  Future<ResultHazardPost?> postUpdateDeskripsi(uid, tipe, deskripsi) async {
    String apiUrl = "${baseUrl}rubah/deskripsi";
    var apiResult = await http.post(Uri.parse(apiUrl),
        body: {"uid": uid, "tipe": tipe, "deskripsi": deskripsi});
    var jsonObject = json.decode(apiResult.body);
    return ResultHazardPost.fromJson(jsonObject);
  }

  Future<ResultHazardPost?> postUpdateResiko(uid, tipe, idResiko) async {
    String apiUrl = "${baseUrl}rubah/resiko";
    var apiResult = await http.post(Uri.parse(apiUrl),
        body: {"uid": uid, "tipe": tipe, "idResiko": idResiko});
    var jsonObject = json.decode(apiResult.body);
    return ResultHazardPost.fromJson(jsonObject);
  }

  Future<ResultHazardPost?> postUpdatePengendalian(uid, idPengendalian) async {
    String apiUrl = "${baseUrl}rubah/pengendalian";
    var apiResult = await http.post(Uri.parse(apiUrl),
        body: {"uid": uid, "idPengendalian": idPengendalian});
    var jsonObject = json.decode(apiResult.body);
    return ResultHazardPost.fromJson(jsonObject);
  }

  Future<ResultHazardPost?> postUpdateKatBahaya(uid, katBahaya) async {
    String apiUrl = "${baseUrl}rubah/katBahaya";
    var apiResult = await http
        .post(Uri.parse(apiUrl), body: {"uid": uid, "katBahaya": katBahaya});
    var jsonObject = json.decode(apiResult.body);
    return ResultHazardPost.fromJson(jsonObject);
  }
}

class BeritaProvider {
  Future<berita.BeritaModel> getBuletin(page) async {
    var url = Uri.parse("${Constants.BASEURL}api/v1/message/info?page=$page");
    var apiWeb = await http.get(url);
    var objekJson = json.decode(apiWeb.body);
    return berita.BeritaModel.fromJson(objekJson);
  }

  Future<TambahBuletin?> buletinTambah(ListBuletin listBuletin) async {
    var data = listBuletin.toJson();
    var url = Uri.parse("${Constants.BASEURL}api/save/buletin");
    var apiResult = await http.post(url, body: data);
    var jsonObject = json.decode(apiResult.body);
    return TambahBuletin.fromJson(jsonObject);
  }

  Future<TambahBuletin?> updateBuletin(
      int idInfo, ListBuletin listBuletin) async {
    var data = listBuletin.toJson();
    var url = Uri.parse("${Constants.BASEURL}api/save/buletin?id_info=$idInfo");
    var apiResult = await http.put(url, body: data);
    var jsonObject = json.decode(apiResult.body);
    return TambahBuletin.fromJson(jsonObject);
  }

  Future<TambahBuletin?> deleteBuletin(int idInfo) async {
    var url = Uri.parse("${Constants.BASEURL}api/save/buletin?idInfo=$idInfo");
    var apiResult = await http.delete(url);
    var jsonObject = json.decode(apiResult.body);
    return TambahBuletin.fromJson(jsonObject);
  }
}
