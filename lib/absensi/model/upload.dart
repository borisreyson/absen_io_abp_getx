

class Upload {
  String? image;
  String? res;
  bool? tidakDikenal;

  Upload({this.image, this.res, this.tidakDikenal});
  factory Upload.fromJson(Map<String, dynamic> object) {
    return Upload(
        image: object['image'],
        res: object['res'],
        tidakDikenal: object['tidak_dikenal']);
  }
  
}
