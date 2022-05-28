
class MapAreModel {
  int? idLok;
  String? company;
  double? lat;
  double? lng;
  int? flag;
  String? timeUpdate;
  MapAreModel(
      {this.idLok,
        this.company,
        this.lat,
        this.lng,
        this.flag,
        this.timeUpdate});

  factory MapAreModel.fromJason(Map<String, dynamic> object) {
    return MapAreModel(
      idLok: object['idLok'],
      company: object['company'],
      lat: object['lat'],
      lng: object['lng'],
      flag: object['flag'],
      timeUpdate: object['time_update'],
    );
  }

}
