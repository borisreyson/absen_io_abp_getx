
// ignore_for_file: non_constant_identifier_names

class ApiKaryawan {
  List <DataKaryawan>? karyawan;

  ApiKaryawan({required this.karyawan});

  factory ApiKaryawan.fromJson(Map<String, dynamic> object){
    return ApiKaryawan(
        karyawan: (object['UsersList'] as List).map((b) => DataKaryawan.fromJson(b)).toList()
    );   
  }  
}

class DataKaryawan {
  int? id_user;
  String? username;
  String? nama_lengkap;
  String? email;
  String? department;
  String? section;
  String? level;
  int? status;
  String? rule;
  String? tglEntry;
  String? nik;
  String? photo_profile;
  String? dept;
  String? sect;
  String? nama_perusahaan;

  DataKaryawan({
    this.id_user,
    this.username,
    this.nama_lengkap,
    this.email,
    this.department,
    this.section,
    this.level,
    this.status,
    this.rule,
    this.tglEntry,
    this.nik,
    this.photo_profile,
    this.dept,
    this.sect,
    this.nama_perusahaan,

  });

  factory DataKaryawan.fromJson(Map<String, dynamic> object) {
    return DataKaryawan(
      id_user: object["id_user"],
      username: object["username"],
      nama_lengkap: object["nama_lengkap"],
      email: object["email"],
      department: object["department"],
      section: object["section"],
      level: object["level"],
      status: object["status"],
      rule: object["rule"],
      tglEntry: object["tglEntry"],
      nik: object["nik"],
      photo_profile: object["photo_profile"],
      dept: object["dept"],
      sect: object["sect"],
      nama_perusahaan: object["nama_perusahaan"],
    );
  }
}
