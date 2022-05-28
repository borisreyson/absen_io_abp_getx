// ignore_for_file: non_constant_identifier_names
class ApiBuletin {
  List<ListBuletin>? info;

  ApiBuletin({required this.info});

  factory ApiBuletin.fromJson(Map<String, dynamic> object) {
    return ApiBuletin(
        info: (object["message_info"] as List)
            .map((b) => ListBuletin.fromJson(b))
            .toList());
  }
}
class ListBuletin {
  int? id_info;
  String? judul;
  String? pesan;
  String? tgl;
  int? status;

  ListBuletin({this.id_info, this.judul, this.pesan, this.tgl, this.status});

  factory ListBuletin.fromJson(Map<String, dynamic> objek) {
    return ListBuletin(
      id_info: objek["id_info"],
      judul: objek["judul"],
      pesan: objek["pesan"],
      tgl: objek["tgl"],
      status: objek["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "judul": judul,
        "tgl": tgl,
        "pesan": pesan,
      };
}

class TambahBuletin {
  bool? success;

  TambahBuletin({this.success});

  factory TambahBuletin.fromJson(Map<String, dynamic> object) {
    return TambahBuletin(success: object['success']);
  }
}
