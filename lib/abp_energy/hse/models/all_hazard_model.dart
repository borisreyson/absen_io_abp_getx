import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:face_id_plus/abp_energy/hse/models/data_hazard.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class AllHazard {
  int? currentPage;
  List<Data>? data;
  int? from;
  int? lastPage;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  AllHazard(
      {this.currentPage,
      this.data,
      this.from,
      this.lastPage,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  AllHazard.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    from = json['from'];
    lastPage = json['last_page'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['from'] = from;
    data['last_page'] = lastPage;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class AllHazardApi {
  Future<AllHazard?> getAllHazard(
      int disetujui, int page, String dari, String sampai) async {
    var api = await http.get(Uri.parse(
        "${Constants.BASEURL}api/v1/hazard/safety?user_valid=$disetujui&page=$page&dari=$dari&sampai=$sampai"));

    var jsonObject = json.decode(api.body);
    var decoJson = AllHazard.fromJson(jsonObject);
    return decoJson;
  }
}
