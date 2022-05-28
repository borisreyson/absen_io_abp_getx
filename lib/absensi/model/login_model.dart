
class LoginValidate {
  bool? success = false;
  PostLogin? user;
  LoginValidate({this.success, this.user});

  factory LoginValidate.fromJson(Map<String, dynamic> object) {
    return LoginValidate(
        success: object['success'],
        user: (object['user'] != null)
            ? PostLogin.fromJson(object['user'])
            : null);
  }
}

class PostLogin {
  int? idUser;
  String? username;
  String? namaLengkap;
  String? nik;
  String? rule;
  String? department;
  String? perusahaan;
  String? photoProfile;
  PostLogin({
    this.idUser,
    this.username,
    this.namaLengkap,
    this.nik,
    this.rule,
    this.department,
    this.perusahaan,
    this.photoProfile,
  });

  factory PostLogin.fromJson(Map<String, dynamic> object) {
    return PostLogin(
        idUser: object['id_user'],
        username: object['username'],
        namaLengkap: object['nama_lengkap'],
        nik: object['nik'],
        rule: object['rule'],
        department: object['department'].toString(),
        perusahaan: object['perusahaan'].toString(),
        photoProfile: object['photo_profile']);
  }
}
