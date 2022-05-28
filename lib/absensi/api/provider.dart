import 'dart:convert';
import 'dart:io';
import 'package:face_id_plus/abp_energy/master/model/berita.dart';
import 'package:face_id_plus/absensi/model/all_absen.dart';
import 'package:face_id_plus/absensi/model/buletin_model.dart';
import 'package:face_id_plus/absensi/model/face_login_model.dart';
import 'package:face_id_plus/absensi/model/last_absen.dart';
import 'package:face_id_plus/absensi/model/list_absen.dart';
import 'package:face_id_plus/absensi/model/login_model.dart';
import 'package:face_id_plus/absensi/model/map_area.dart';
import 'package:face_id_plus/absensi/model/roster_kerja_model.dart';
import 'package:face_id_plus/absensi/model/tigahariabsen.dart';
import 'package:face_id_plus/absensi/model/upload.dart';
import 'package:http/http.dart' as http;

class AbsenProvider {
  Future<AllAbsen> adminAbsenApi(String status, String tgl) async {
    String apiUrl =
        "https://abpjobsite.com/absen/list/all?status=$status&tanggal=$tgl";
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    var absenList = AllAbsen.fromJson(jsonObject);
    return absenList;
  }

  Future<BeritaModel> getBuletin() async {
    var url = Uri.parse("https://lp.abpjobsite.com/api/message/info");
    var apiWeb = await http.get(url);
    var objekJson = json.decode(apiWeb.body);
    return BeritaModel.fromJson(objekJson);
  }

  Future<TambahBuletin?> buletinTambah(ListBuletin listBuletin) async {
    var data = listBuletin.toJson();
    var url = Uri.parse("https://lp.abpjobsite.com/api/save/buletin");
    var apiResult = await http.post(url, body: data);
    var jsonObject = json.decode(apiResult.body);
    return TambahBuletin.fromJson(jsonObject);
  }

  Future<TambahBuletin?> updateBuletin(
      int idInfo, ListBuletin listBuletin) async {
    var data = listBuletin.toJson();
    var url =
        Uri.parse("https://lp.abpjobsite.com/api/save/buletin?id_info=$idInfo");
    var apiResult = await http.put(url, body: data);
    var jsonObject = json.decode(apiResult.body);
    return TambahBuletin.fromJson(jsonObject);
  }

  Future<TambahBuletin?> deleteBuletin(int idInfo) async {
    var url =
        Uri.parse("https://lp.abpjobsite.com/api/save/buletin?idInfo=$idInfo");
    var apiResult = await http.delete(url);
    var jsonObject = json.decode(apiResult.body);
    return TambahBuletin.fromJson(jsonObject);
  }

  Future<FaceModel?> loginApiFace(String username, String password) async {
    String apiUrl = "https://lp.abpjobsite.com/api/login/face";
    var apiResult = await http.post(Uri.parse(apiUrl),
        body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body);
    return FaceModel.fromJson(jsonObject);
  }

  Future<LastAbsen> apiAbsenTigaHari(String _nik) async {
    String apiUrl = "https://lp.abpjobsite.com/api/lastAbsen?nik=" + _nik;
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    var lastAbsen = LastAbsen.fromJson(jsonObject);
    return lastAbsen;
  }

  Future<LastAbsen> apiAbsenTigaHariOffline(String _nik) async {
    String apiUrl = "http://10.10.3.13/flutter/get/last/absen?nik=" + _nik;
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    var lastAbsen = LastAbsen.fromJson(jsonObject);
    return lastAbsen;
  }

  Future<AbsenList> apiAbsenTigaHariList(String _nik, String _status) async {
    String apiUrl =
        "https://abpjobsite.com/api/android/get/list/absen?nik=$_nik&status=$_status";
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    var absenList = AbsenList.fromJson(jsonObject);
    return absenList;
  }

  Future<LoginValidate?> loginToApi(String username, String password) async {
    String apiUrl = "https://lp.abpjobsite.com/api/login";
    var apiResult = await http.post(Uri.parse(apiUrl),
        body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body);
    return LoginValidate.fromJson(jsonObject);
  }

  Future<List<MapAreModel>> mapAreaApi(String _company) async {
    String apiUrl = "https://abpjobsite.com/absen/map/area?company=" + _company;
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    return (jsonObject['mapArea'] as List)
        .map((e) => MapAreModel.fromJason(e))
        .toList();
  }

  Future<bool> saveMapPoint(String lat, String lng) async {
    String apiUrl = "https://lp.abpjobsite.com/api/area/save/point";
    var apiResult =
        await http.post(Uri.parse(apiUrl), body: {"lat": lat, "lng": lng});
    var jsonObject = json.decode(apiResult.body);
    return (jsonObject['success']) ? jsonObject['success'] : false;
  }

  Future<bool> delMapPoint(String idLok) async {
    String apiUrl = "https://lp.abpjobsite.com/api/area/del/point";
    var apiResult = await http.post(Uri.parse(apiUrl), body: {"idLok": idLok});
    var jsonObject = json.decode(apiResult.body);
    return (jsonObject['success']) ? jsonObject['success'] : false;
  }

  Future<bool> editMapPoint(String idLok, String lat, String lng) async {
    String apiUrl = "https://lp.abpjobsite.com/api/area/edit/point";
    var apiResult = await http.post(Uri.parse(apiUrl),
        body: {"idLok": idLok, "lat": lat, "lng": lng});
    var jsonObject = json.decode(apiResult.body);
    return (jsonObject['success']) ? jsonObject['success'] : false;
  }

  Future<ApiRoster> getRoster(String? nik, String bulan, String tahun) async {
    var url = Uri.parse(
        "https://lp.abpjobsite.com/api/roster/kerja/karyawan?nik=$nik&tahun=$tahun&bulan=$bulan");
    var apiWeb = await http.get(url);
    var objekJson = json.decode(apiWeb.body);
    return ApiRoster.fromJson(objekJson);
  }

  Future<Upload> uploadApi(String nik, String status, File file, String lat,
      String lng, String idRoster) async {
    Map<String, dynamic>? data;
    String tgl = "";
    String jam = "";
    String apiUrl = "https://abpjobsite.com/flutter_absen.php";
    var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
    request.fields['id'] = "0";
    request.fields['nik'] = nik;
    request.fields['tgl'] = tgl;
    request.fields['jam'] = jam;
    request.fields['status'] = status;
    request.fields['lat'] = lat;
    request.fields['lng'] = lng;
    request.fields['id_roster'] = idRoster;
    String filename = nik + "_" + status + DateTime.now().toString() + ".jpg";
    request.files.add(http.MultipartFile.fromBytes(
        "fileToUpload", file.readAsBytesSync(),
        filename: filename));
    var response = await request.send();
    await for (String s in response.stream.transform(utf8.decoder)) {
      data = jsonDecode(s);
    }
    return Upload.fromJson(data!);
  }

  Future<List<AbsenTigaHariModel>> apiAbsenTigaHariGet(String? _nik) async {
    String apiUrl =
        "https://abpjobsite.com/absen/get/AbsenTigaHari?nik=" + _nik!;
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    var absensi = (jsonObject['AbsenTigaHari'] as List)
        .map((e) => AbsenTigaHariModel.fromJson(e))
        .toList();
    return absensi;
  }

  Future<List<AbsenTigaHariModel>> apiAbsenTigaHariOfflineGet(
      String _nik) async {
    String apiUrl = "http://10.10.3.13/absen/get/AbsenTigaHari?nik=" + _nik;
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    var absensi = (jsonObject['AbsenTigaHari'] as List)
        .map((e) => AbsenTigaHariModel.fromJson(e))
        .toList();
    return absensi;
  }
}
