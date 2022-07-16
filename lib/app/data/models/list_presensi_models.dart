class ListPresensiModels {
  List<ListPresensi>? listPresensi;

  ListPresensiModels({this.listPresensi});

  ListPresensiModels.fromJson(Map<String, dynamic> json) {
    if (json['listPresensi'] != null) {
      listPresensi = <ListPresensi>[];
      json['listPresensi'].forEach((v) {
        listPresensi!.add(ListPresensi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listPresensi != null) {
      data['listPresensi'] = listPresensi?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListPresensi {
  int? id;
  int? idRoster;
  String? nik;
  String? tanggal;
  String? jam;
  String? gambar;
  String? status;
  String? faceId;
  int? flag;
  int? oFF;
  int? iZINBERBAYAR;
  int? aLPA;
  int? cR;
  int? cT;
  int? sAKIT;
  String? lupaAbsen;
  String? lat;
  String? lng;
  String? timeIn;
  String? checkin;
  String? checkout;
  String? faceIn;
  String? faceOut;
  String? latOut;
  String? lngOut;
  String? dateIn;
  String? dateOut;
  String? tanggalJam;

  ListPresensi(
      {this.id,
      this.idRoster,
      this.nik,
      this.tanggal,
      this.jam,
      this.gambar,
      this.status,
      this.faceId,
      this.flag,
      this.oFF,
      this.iZINBERBAYAR,
      this.aLPA,
      this.cR,
      this.cT,
      this.sAKIT,
      this.lupaAbsen,
      this.lat,
      this.lng,
      this.timeIn,
      this.checkin,
      this.checkout,
      this.faceIn,
      this.faceOut,
      this.latOut,
      this.lngOut,
      this.dateIn,
      this.dateOut,
      this.tanggalJam});

  ListPresensi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRoster = json['id_roster'];
    nik = json['nik'];
    tanggal = json['tanggal'];
    jam = json['jam'];
    gambar = json['gambar'];
    status = json['status'];
    faceId = json['face_id'];
    flag = json['flag'];
    oFF = json['OFF'];
    iZINBERBAYAR = json['IZIN_BERBAYAR'];
    aLPA = json['ALPA'];
    cR = json['CR'];
    cT = json['CT'];
    sAKIT = json['SAKIT'];
    lupaAbsen = json['lupa_absen'];
    lat = json['lat'];
    lng = json['lng'];
    timeIn = json['timeIn'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    faceIn = json['faceIn'];
    faceOut = json['faceOut'];
    latOut = json['latOut'];
    lngOut = json['lngOut'];
    dateIn = json['date_in'];
    dateOut = json['date_out'];
    tanggalJam = json['tanggal_jam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_roster'] = idRoster;
    data['nik'] = nik;
    data['tanggal'] = tanggal;
    data['jam'] = jam;
    data['gambar'] = gambar;
    data['status'] = status;
    data['face_id'] = faceId;
    data['flag'] = flag;
    data['OFF'] = oFF;
    data['IZIN_BERBAYAR'] = iZINBERBAYAR;
    data['ALPA'] = aLPA;
    data['CR'] = cR;
    data['CT'] = cT;
    data['SAKIT'] = sAKIT;
    data['lupa_absen'] = lupaAbsen;
    data['lat'] = lat;
    data['lng'] = lng;
    data['timeIn'] = timeIn;
    data['checkin'] = checkin;
    data['checkout'] = checkout;
    data['faceIn'] = faceIn;
    data['faceOut'] = faceOut;
    data['latOut'] = latOut;
    data['lngOut'] = lngOut;
    data['date_in'] = dateIn;
    data['date_out'] = dateOut;
    data['tanggal_jam'] = tanggalJam;
    return data;
  }
}
