import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/models/hazard_post.dart';
import '../../../../data/models/metrik_resiko_model.dart';
import '../../../../data/repository/repository_api.dart';
import '../../../../data/utils/constants.dart';

class FormHazardController extends GetxController {
  late HazardPostRepository repository;
  final formKey = GlobalKey<FormState>();
  final Color warna = const Color(0xFF591505);
  var imagePicker = ImagePicker();
  XFile? foto, perbaikan, imgPj;

  final urlFoto = RxnString(null);
  final urlperbaikan = RxnString(null);
  final urlImgPj = RxnString(null);

  final perusahaan = TextEditingController();
  final tglController = TextEditingController();
  final jamController = TextEditingController();
  final lokasi = TextEditingController();
  final detailLokasi = TextEditingController();
  final deskBahaya = TextEditingController();
  final kemungkinan = TextEditingController();
  final keparahan = TextEditingController();
  final tenggat = TextEditingController();
  final tindakan = TextEditingController();
  final keteranganPJ = TextEditingController();
  final kemungkinanSesudah = TextEditingController();
  final keparahanSesudah = TextEditingController();
  final namaPj = TextEditingController();
  final nikPJ = TextEditingController();
  final tglSelesai = TextEditingController();
  final jamSelesai = TextEditingController();

  String? idDevice;
  DateTime dt = DateTime.now();
  DateFormat fmt = DateFormat('dd MMMM yyyy');
  final tglHazard = DateTime.now().obs;
  DateTime? jamHazard;
  final pengendalian = TextEditingController();
  int kta = 0;
  final perbaikanInt = 2.obs;
  final pjOption = 2.obs;
  int? idKmSebelum,
      idKpSebelum,
      idKmSesudah,
      idKpSesudah,
      idLokasi,
      idPengendalian,
      nilaiKmSebelum,
      nilaiKpSebelum,
      nilaiKmSesudah,
      nilaiKpSesudah;
  String? username;
  final AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final resiko = MetrikResiko().obs;
  List<String> pcikPerbaikan = [
    "SELESAI",
    "BELUM SELESAI",
    "DALAM PENGERJAAN",
    "BERLANJUT"
  ];
  List<String> bahaya = ["KONDISI TIDAK AMAN", "TINDAKAN TIDAK AMAN"];

  @override
  void onInit() {
    tglHazard.value = dt;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  initIdDevice() async {
    String? _idDevice;
    try {
      _idDevice = await PlatformDeviceId.getDeviceId;
      idDevice = _idDevice;
    } on PlatformException {
      if (kDebugMode) {
        print("ERROR");
      }
    }
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    username = pref.getString(Constants.username);
  }

  pickerBtmSheet() {
    return Get.bottomSheet(
        SizedBox(
          height: 220,
          child: Stack(
            children: [
              Card(
                margin: const EdgeInsets.only(top: 40),
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                    child: ListView(
                      children: [
                        Card(
                          elevation: 10,
                          child: InkWell(
                            onTap: () async {
                              var img = await getImageCamera();
                              if (img != null) {
                                Get.back(result: img);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.camera_alt_rounded,
                                  ),
                                  Text("Camera"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          child: InkWell(
                            onTap: () async {
                              var img = await getImageGallery();
                              if (img != null) {
                                Get.back(result: img);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(Icons.image_search_rounded),
                                  Text("Galeri"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        useRootNavigator: true);
  }

  Future<XFile?> getImageGallery() async {
    var imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    return imageFile;
  }

  Future<XFile?> getImageCamera() async {
    var imageFile = await imagePicker.pickImage(source: ImageSource.camera);
    return imageFile;
  }

  Future<DateTime?> selectDate(BuildContext context, DateTime initDate) async {
    return await DatePicker.showDatePicker(context,
        showTitleActions: true, maxTime: dt, currentTime: initDate);
  }

  Future<DateTime?> seletTime(BuildContext context, DateTime jamHazard) async {
    return await DatePicker.showTimePicker(context,
        showTitleActions: true, currentTime: jamHazard);
  }

  loadMetrik(nilaiKM, nilaiKP) async {
    var total = nilaiKM * nilaiKP;
  }

  loadMetrikSesudah(nilaiKM, nilaiKP) async {
    var total = nilaiKM * nilaiKP;
  }

  buktiPicker() async {
    XFile? bukti = await pickerBtmSheet();
    if (bukti != null) {
      foto = bukti;
      urlFoto.value = bukti.path;
    }
  }

  perbaikanPicker() async {
    XFile? imgPerbaikan = await pickerBtmSheet();
    if (imgPerbaikan != null) {
      perbaikan = imgPerbaikan;
      urlperbaikan.value = imgPerbaikan.path;
    }
  }

  pjPicker() async {
    XFile? pjImg = await pickerBtmSheet();
    if (pjImg != null) {
      imgPj = pjImg;
      urlImgPj.value = pjImg.path;
    }
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      if (foto != null) {
        if (perbaikanInt.value == 1) {
          if (perbaikanInt.value != null) {
            if (imgPj != null) {
              if (kta > 0) {
                saveSelesai();
              } else {
                await Constants().showAlert(
                    judul: "Error Kategori Bahaya",
                    msg: "Kategori Bahaya Tidak Boleh Kosong!");
              }
            } else {
              await Constants().showAlert(
                  judul: "Error Foto Penanggung Jawab Tidak ada",
                  msg: "Foto Penanggung Jawab Tidak Boleh Kosong!");
              pjPicker();
            }
          } else {
            await Constants().showAlert(
                judul: "Error Foto Bukti Perbaikan Tidak ada",
                msg: "Foto Bukti Perbaikan Tidak Boleh Kosong!");
            perbaikanPicker();
          }
        } else {
          if (imgPj != null) {
            if (kta > 0) {
              if (idPengendalian != null) {
                save();
              } else {
                await Constants().showAlert(
                    judul: "Error Pengendalian",
                    msg: "Pengendalian Resiko Tidak Boleh Kosong!");
              }
            } else {
              await Constants().showAlert(
                  judul: "Error Kategori Bahaya",
                  msg: "Kategori Bahaya Tidak Boleh Kosong!");
            }
          } else {
            await Constants().showAlert(
                judul: "Error Foto Penanggung Jawab Tidak ada",
                msg: "Foto Penanggung Jawab Tidak Boleh Kosong!");
            pjPicker();
          }
        }
      } else {
        await Constants().showAlert(
          judul: "Error Foto Bukti Tidak ada",
          msg: "Foto Bukti Tidak Boleh Kosong!",
        );
        buktiPicker();
      }
    } else {
      if (kDebugMode) {
        print("Not OK");
      }
    }
  }

  save() async {
    Constants().showAlert(
      dismiss: false,
      loading: true,
      enBtn: false,
    );
    HazardPostModel data = HazardPostModel();
    data.fileToUpload = File(foto!.path);
    data.fileToUploadPJ = File(imgPj!.path);
    data.perusahaan = perusahaan.text;
    data.tglHazard = tglController.text;
    data.jamHazard = jamController.text;
    data.lokasi = "$idLokasi";
    data.lokasiDetail = detailLokasi.text;
    data.deskripsi = deskBahaya.text;
    data.kemungkinan = "$idKmSebelum";
    data.keparahan = "$idKpSebelum";
    data.katBahaya = bahaya.elementAt(kta - 1);
    data.pengendalian = "$idPengendalian";
    data.tindakan = tindakan.text;
    data.namaPJ = namaPj.text;
    data.nikPJ = nikPJ.text;
    data.status = pcikPerbaikan.elementAt(perbaikanInt.value - 1);
    data.tglTenggat = tenggat.text;
    data.userInput = "$username";
    try {
      await repository.postHazard(data, idDevice).then((res) {
        if (res != null) {
          if (res.success) {
            Get.back();
            Get.back(result: res.success);
          } else {
            Get.back(result: false);
          }
        }
      });
    } on HttpException {
      if (kDebugMode) {
        print("$HttpException");
      }
      Get.back(result: false);
    }
  }

  saveSelesai() async {
    Constants().showAlert(
      dismiss: false,
      loading: true,
      enBtn: false,
    );

    HazardPostSelesaiModel data = HazardPostSelesaiModel();
    data.fileToUpload = File(foto!.path);
    data.fileToUploadPJ = File(imgPj!.path);
    data.fileToUploadSelesai = File(perbaikan!.path);
    data.perusahaan = perusahaan.text;
    data.tglHazard = tglController.text;
    data.jamHazard = jamController.text;
    data.lokasi = "$idLokasi";
    data.lokasiDetail = detailLokasi.text;
    data.deskripsi = deskBahaya.text;
    data.kemungkinan = "$idKmSebelum";
    data.keparahan = "$idKpSebelum";
    data.kemungkinanSesudah = "$idKmSesudah";
    data.keparahanSesudah = "$idKpSesudah";
    data.katBahaya = bahaya.elementAt(kta - 1);
    data.pengendalian = "$idPengendalian";
    data.tindakan = tindakan.text;
    data.namaPJ = namaPj.text;
    data.nikPJ = nikPJ.text;
    data.status = pcikPerbaikan.elementAt(perbaikanInt.value - 1);
    data.tglSelesai = tglSelesai.text;
    data.jamSelesai = jamSelesai.text;
    data.keteranganPJ = keteranganPJ.text;
    data.userInput = "$username";

    try {
      await repository.postHazardSelesai(data, idDevice).then((res) {
        if (res != null) {
          if (res.success) {
            Get.back();
            Get.back(result: res.success);
          } else {
            Get.back(result: false);
          }
        }
      });
    } on HttpException {
      if (kDebugMode) {
        print("$HttpException");
      }
      Get.back(result: false);
    }
  }
}
