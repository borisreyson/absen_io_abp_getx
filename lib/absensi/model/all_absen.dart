import 'package:face_id_plus/absensi/model/last_absen.dart';

class AllAbsen {
  int? currenPage;
  List<Presensi>? presensi;
  int? from;
  int? lastPage;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  AllAbsen(
      {this.currenPage,
      this.presensi,
      this.from,
      this.lastPage,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});
  factory AllAbsen.fromJson(Map<String, dynamic> object) {
    return AllAbsen(
      currenPage: object['current_page'],
      presensi:
          (object['data'] as List).map((e) => Presensi.fromJson(e)).toList(),
      from: object['from'],
      lastPage: object['last_page'],
      nextPageUrl: object['next_page_url'],
      path: object['path'],
      perPage: object['per_page'],
      prevPageUrl: object['prev_page_url'],
      to: object['to'],
      total: object['total'],
    );
  }
}
