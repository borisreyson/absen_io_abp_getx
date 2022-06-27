import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/data_hazard.dart';
import '../../../../data/models/kemungkinan_model.dart';
import '../../../../data/models/keparahan_model.dart';
import '../../../../data/models/metrik_resiko_model.dart';
import '../../../../data/repository/repository_api.dart';
import '../../../../data/services/service.dart';
import '../../../../data/utils/constants.dart';

class RubahHazardController extends GetxController {
  final repository = HazardRepository();
  final KemungkinanService _kmService = KemungkinanService();
  final KeparahanService _kpService = KeparahanService();
  final MetrikService _metrikService = MetrikService();
  final String baseImage = "https://abpjobsite.com/bukti_hazard/";
  String perusahaan = "Perusahaan";
  String? idDevice;
  final data = Data().obs;
  int? nilaiKpSebelum, nilaiKmSesudah, nilaiKpSesudah;
  var imagePicker = ImagePicker();
  XFile? foto, perbaikan, imgPj;

  final resikoSebelum = MetrikResiko().obs;
  final resikoSesudah = MetrikResiko().obs;
  final kmSebelum = Kemungkinan().obs;
  final kpSebelum = Keparahan().obs;
  final kmSesudah = Kemungkinan().obs;
  final kpSesudah = Keparahan().obs;
  final bukti = ''.obs;
  final updateBukti = ''.obs;


  @override
  void onInit() {
    foto = null;
    perbaikan = null;
    imgPj = null;
    data.value = Get.arguments['detail'];

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  _getResikoSebelum({required Data data}) async {
    var kmSebelum = await _kmService.getBy(idKemungkinan: data.idKemungkinan);
    var kpSebelum = await _kpService.getBy(idKeparahan: data.idKeparahan);
     resikoSebelum.value= await _metrikService.getBy(
        nilai: (kmSebelum.nilai! * kpSebelum.nilai!));
  }

  _getResikoSesudah({required Data data}) async {
    var kmSesudah =
        await _kmService.getBy(idKemungkinan: data.idKemungkinanSesudah);
    var kpSesudah =
        await _kpService.getBy(idKeparahan: data.idKeparahanSesudah);
     resikoSesudah.value = await _metrikService.getBy(
        nilai: (kmSesudah.nilai! * kpSesudah.nilai!));
  }

  reload(context) async {
    Constants().showAlert(
      dismiss: false,
      loading: true,
      enBtn: false,
    );
    if (data.value != null) {
      var uid = data.value.uid;
      await repository.getHazardDetail(uid).then((res) {
        if (res != null) {
          data.value = res;
          _getResikoSebelum(data: data.value);
          _getResikoSesudah(data: data.value);
          Get.back(result: true);
        } else {
          Get.back(result: false);
        }
      });
    }
  }
}
