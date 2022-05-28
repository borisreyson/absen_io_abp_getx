import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/state.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_post.dart';
import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/metrik_resiko_model.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/master/model/lokasi_model.dart';
import 'package:face_id_plus/abp_energy/master/model/pengendalian.dart';
import 'package:face_id_plus/abp_energy/master/model/perusahaan_model.dart';
import 'package:face_id_plus/abp_energy/master/model/users_model.dart';
import 'package:face_id_plus/abp_energy/master/screen/kemungkinan.dart';
import 'package:face_id_plus/abp_energy/master/screen/keparahan.dart';
import 'package:face_id_plus/abp_energy/master/screen/lokasi.dart';
import 'package:face_id_plus/abp_energy/master/screen/pengendalian.dart';
import 'package:face_id_plus/abp_energy/master/screen/perusahaan.dart';
import 'package:face_id_plus/abp_energy/master/screen/users.dart';
import 'package:face_id_plus/abp_energy/service/service.dart';
import 'package:face_id_plus/abp_energy/utils/background.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platform_device_id/platform_device_id.dart';

class FormHazard extends StatefulWidget {
  const FormHazard({Key? key}) : super(key: key);

  @override
  State<FormHazard> createState() => _FormHazardState();
}

class _FormHazardState extends State<FormHazard> {
  late HazardPostRepository _repository;
  final _formKey = GlobalKey<FormState>();
  final Color _warna = const Color(0xFF591505);
  var imagePicker = ImagePicker();
  XFile? _foto, _perbaikan, _imgPj;
  late GambarBloc _gambarBloc;
  late ImgPerbaikanBloc _imgPerbaikanBloc;
  late PjImgBloc _pjImgBloc;
  late MetrikBloc _metrikBloc;
  late MetrikSesudahBloc _metrikBlocSesudah;

  final _perusahaan = TextEditingController();
  final tglController = TextEditingController();
  final jamController = TextEditingController();
  final _lokasi = TextEditingController();
  final _detailLokasi = TextEditingController();
  final _deskBahaya = TextEditingController();
  final _kemungkinan = TextEditingController();
  final _keparahan = TextEditingController();
  final _tenggat = TextEditingController();
  final _tindakan = TextEditingController();
  final _keteranganPJ = TextEditingController();
  final _kemungkinanSesudah = TextEditingController();
  final _keparahanSesudah = TextEditingController();
  final _namaPj = TextEditingController();
  final _nikPJ = TextEditingController();

  String? idDevice;
  DateTime dt = DateTime.now();
  DateFormat fmt = DateFormat('dd MMMM yyyy');
  DateTime? tglHazard;
  DateTime? jamHazard;
  final _pengendalian = TextEditingController();
  int kta = 0;
  int perbaikan = 2;
  int pjOption = 2;
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
  String? _username;
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  List<String> pcikPerbaikan = [
    "SELESAI",
    "BELUM SELESAI",
    "DALAM PENGERJAAN",
    "BERLANJUT"
  ];
  List<String> bahaya = ["KONDISI TIDAK AMAN", "TINDAKAN TIDAK AMAN"];
  @override
  void initState() {
    initIdDevice();
    _repository = HazardPostRepository();
    tglHazard = dt;
    jamHazard =
        DateTime(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);
    _gambarBloc = GambarBloc();
    _imgPerbaikanBloc = ImgPerbaikanBloc();
    _pjImgBloc = PjImgBloc();
    _metrikBloc = MetrikBloc(MetrikService());
    _metrikBlocSesudah = MetrikSesudahBloc(MetrikService());
    _foto = null;
    _perbaikan = null;
    _imgPj = null;
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GambarBloc>(create: (context) => _gambarBloc),
          BlocProvider<ImgPerbaikanBloc>(
              create: (context) => _imgPerbaikanBloc),
          BlocProvider<PjImgBloc>(create: (context) => _pjImgBloc),
          BlocProvider<MetrikBloc>(create: (context) => _metrikBloc),
          BlocProvider<MetrikSesudahBloc>(
              create: (context) => _metrikBlocSesudah),
        ],
        child: Stack(
          children: [
            Background(
              topPrimary: const Color(0xff115923),
              topSecondary: const Color(0xff2B8C44),
              bottomPrimary: const Color.fromARGB(255, 191, 112, 27),
              bottomSecondary: const Color(0xffBF3E21),
              bgColor: Colors.grey.shade400,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: ListView(
                children: [
                  dataTemuan(),
                  deskBahaya(),
                  resikoSebelum(),
                  katBahaya(),
                  tindakanPerbaikan(),
                  statusPerbaikan(),
                  perbaikanWidget(),
                  optionPJ(),
                  (pjOption == 1) ? pjAuto() : pjManual(),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
            backButton(),
            btnAksi(),
          ],
        ),
      ),
    );
  }

  Widget perbaikanWidget() {
    return Visibility(
      visible: (perbaikan == 1),
      child: Column(
        children: [
          fotoPerbaikan(),
          ketPerbaikan(),
          resikoSesudah(),
        ],
      ),
    );
  }

  Widget backButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.only(top: 30, left: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            Navigator.pop(context, false);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: const [
                Positioned(
                  left: 2.0,
                  top: 2.5,
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: Color.fromARGB(135, 169, 166, 166)),
                ),
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF943016),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dataTemuan() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
      child: Column(
        children: [
          fotoBukti(),
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Column(
              children: [
                Material(
                  color: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "1. Data Temuan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //Perusahaan
                      TextFormField(
                        onTap: () async {
                          Company? company = await Constants()
                              .goTo(() => const Perusahaan(), context);
                          if (company != null) {
                            setState(
                              () {
                                _perusahaan.text = "${company.namaPerusahaan}";
                              },
                            );
                          }
                        },
                        autofocus: false,
                        readOnly: true,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Perusahaan",
                          hintText: "Perusahaan",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Perusahaan Wajib Di Isi';
                          }
                          return null;
                        },
                        controller: _perusahaan,
                      ),
                      spacing(10),
                      //Tanggal
                      TextFormField(
                        onTap: () async {
                          var tgl = await _selectDate(context, tglHazard!);
                          if (tgl != null) {
                            setState(() {
                              tglController.text = fmt.format(tgl);
                            });
                          }
                        },
                        controller: tglController,
                        autofocus: false,
                        readOnly: true,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Tanggal",
                          hintText: "Tanggal",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tanggal Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                      spacing(10),
                      //Jam
                      TextFormField(
                        onTap: () async {
                          dt = DateTime.now();
                          jamHazard = dt;
                          var jam = await _seletTime(context, jamHazard!);
                          if (jam != null) {
                            setState(() {
                              jamController.text =
                                  "${jam.hour.toString().padLeft(2, '0')} : ${jam.minute.toString().padLeft(2, '0')}";
                            });
                          }
                        },
                        controller: jamController,
                        autofocus: false,
                        readOnly: true,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Jam",
                          hintText: "Jam",
                        ),
                        onSaved: (value) {},
                        onFieldSubmitted: (term) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Jam Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                      spacing(10),
                      //lokasi
                      TextFormField(
                        onTap: () async {
                          Lokasi? lokasi = await Constants()
                              .goTo(() => const LokasiScreen(), context);
                          if (lokasi != null) {
                            setState(
                              () {
                                _lokasi.text = "${lokasi.lokasi}";
                                idLokasi = lokasi.idLok;
                              },
                            );
                          }
                        },
                        controller: _lokasi,
                        autofocus: false,
                        readOnly: true,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Lokasi",
                          hintText: "Lokasi",
                        ),
                        onSaved: (value) {},
                        onFieldSubmitted: (term) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lokasi Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                      spacing(10),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Detail Lokasi",
                          alignLabelWithHint: true,
                          hintText: "Detail Lokasi",
                        ),
                        controller: _detailLokasi,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Detail Lokasi Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                      spacing(10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget deskBahaya() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Column(
              children: [
                Material(
                  color: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "2. Deskripsi Bahaya",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        maxLines: 10,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          alignLabelWithHint: true,
                          labelText: "Deskripsi Bahaya",
                          hintText: "Deskripsi Bahaya",
                        ),
                        controller: _deskBahaya,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Deskripsi Bahaya Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fotoBukti() {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 10,
      child: InkWell(
        onTap: () async {
          buktiPicker();
        },
        child: BlocBuilder<GambarBloc, GambarState>(
          builder: (context, state) {
            if (state is ErrorGambar) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(state.errMsg),
                  ),
                ),
              );
            } else if (state is LoadedGambar) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.file(
                    File(
                      state.urlImg,
                    ),
                    fit: BoxFit.fitWidth,
                  ));
            } else if (state is LoadingGambar) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.add_photo_alternate,
                  size: 180,
                  color: Colors.grey.shade600,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget resikoSebelum() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Column(
              children: [
                Material(
                  color: Colors.orange.shade700,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Kemungkinan Resiko",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        onTap: () async {
                          Kemungkinan? data = await Constants()
                              .goTo(() => const KemungkinanScreen(), context);
                          if (data != null) {
                            setState(
                              () {
                                nilaiKmSebelum = data.nilai!;
                                if (nilaiKpSebelum != null) {
                                  loadMetrik(nilaiKmSebelum, nilaiKpSebelum);
                                }
                                idKmSebelum = data.idKemungkinan;
                                _kemungkinan.text = "${data.kemungkinan}";
                              },
                            );
                          }
                        },
                        controller: _kemungkinan,
                        autofocus: false,
                        readOnly: true,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Kemungkinan Resiko",
                          hintText: "Kemungkinan Resiko",
                        ),
                        onSaved: (value) {},
                        onFieldSubmitted: (term) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kemungkinan Resiko Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.red.shade700,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Keparahan Resiko",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        controller: _keparahan,
                        onTap: () async {
                          Keparahan? data = await Constants()
                              .goTo(() => const KeparahanScreen(), context);
                          if (data != null) {
                            setState(
                              () {
                                nilaiKpSebelum = data.nilai!;
                                if (nilaiKmSebelum != null) {
                                  loadMetrik(nilaiKmSebelum, nilaiKpSebelum);
                                }
                                idKpSebelum = data.idKeparahan;
                                _keparahan.text = "${data.keparahan}";
                              },
                            );
                          }
                        },
                        autofocus: false,
                        readOnly: true,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Keparahan Resiko",
                          hintText: "Keparahan Resiko",
                        ),
                        onSaved: (value) {},
                        onFieldSubmitted: (term) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Keparahan Resiko Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocListener<MetrikBloc, MetrikState>(
            listener: (context, state) {
              var date = DateTime.now();
              if (state is MetrikLoaded) {
                setState(() {
                  if (int.parse(state.resiko.batas!) > 0) {
                    var batas = int.parse(state.resiko.batas!) / 24;
                    var tenggat = DateTime(
                        date.year, date.month, date.day + batas.toInt());
                    _tenggat.text = fmt.format(tenggat);
                  } else {
                    _tenggat.text = fmt.format(date);
                  }
                });
              }
            },
            child: BlocBuilder<MetrikBloc, MetrikState>(
              builder: (context, state) {
                if (state is MetrikLoaded) {
                  return metrikWidget(state.resiko);
                } else if (state is MetrikLoading) {
                  return Container(
                    height: 70,
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 10,
                      child: const Center(child: CupertinoActivityIndicator()),
                    ),
                  );
                }

                return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget metrikWidget(MetrikResiko data) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Color(int.parse(data.bgColor!.replaceAll("#", "0xff"))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${data.kodeBahaya}",
                style: TextStyle(
                  color:
                      Color(int.parse(data.txtColor!.replaceAll("#", "0xff"))),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data.kategori}",
                style: TextStyle(
                  color:
                      Color(int.parse(data.txtColor!.replaceAll("#", "0xff"))),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data.min} - ${data.max}",
                style: TextStyle(
                  color:
                      Color(int.parse(data.txtColor!.replaceAll("#", "0xff"))),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget katBahaya() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Column(
              children: [
                Material(
                  color: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "3. Kategori Bahaya ( Pilih Salah Satu )",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: kta,
                  onChanged: (value) {
                    setState(() {
                      kta = int.parse("$value");
                    });
                  },
                  title: const Text("KONDISI TIDAK AMAN"),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: kta,
                  onChanged: (value) {
                    setState(() {
                      kta = int.parse("$value");
                    });
                  },
                  title: const Text("TINDAKAN TIDAK AMAN"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        autofocus: false,
                        readOnly: true,
                        onTap: () async {
                          Hirarki? data = await Constants()
                              .goTo(() => const PengendalianScreen(), context);
                          if (data != null) {
                            setState(
                              () {
                                idPengendalian = data.idHirarki;
                                _pengendalian.text = "${data.namaPengendalian}";
                              },
                            );
                          }
                        },
                        controller: _pengendalian,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Pengendalian",
                          hintText: "Pengendalian",
                        ),
                        onSaved: (value) {},
                        onFieldSubmitted: (term) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pengendalian Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tindakanPerbaikan() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Column(
              children: [
                Material(
                  color: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "4. Tindakan Yang Dilakukan Untuk Perbaikan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        maxLines: 10,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          alignLabelWithHint: true,
                          labelText: "Tindakan Perbaikan",
                          hintText: "Tindakan Perbaikan",
                        ),
                        onSaved: (value) {},
                        onFieldSubmitted: (term) {
                          setState(() {});
                        },
                        controller: _tindakan,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tindakan Perbaikan Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget statusPerbaikan() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Column(
              children: [
                Material(
                  color: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Status Perbaikan ( Pilih Salah Satu )",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: perbaikan,
                  onChanged: (value) {
                    setState(() {
                      perbaikan = int.parse("$value");
                    });
                  },
                  title: const Text("Selesai"),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: perbaikan,
                  onChanged: (value) {
                    setState(() {
                      perbaikan = int.parse("$value");
                    });
                  },
                  title: const Text("Belum Selesai"),
                ),
                RadioListTile(
                  value: 3,
                  groupValue: perbaikan,
                  onChanged: (value) {
                    setState(() {
                      perbaikan = int.parse("$value");
                    });
                  },
                  title: const Text("Dalam Pengerjaan"),
                ),
                RadioListTile(
                  value: 4,
                  groupValue: perbaikan,
                  onChanged: (value) {
                    setState(() {
                      perbaikan = int.parse("$value");
                    });
                  },
                  title: const Text("Berlanjut"),
                ),
                Visibility(
                  visible: (perbaikan == 1) ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          autofocus: false,
                          readOnly: true,
                          controller: _tenggat,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: _warna)),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: _warna)),
                            labelStyle: TextStyle(color: _warna),
                            labelText: "Tanggal Tenggat",
                            hintText: "Tanggal Tenggat",
                          ),
                          onSaved: (value) {},
                          onFieldSubmitted: (term) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tanggal Tenggat Wajib Di Isi';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fotoPerbaikan() {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      elevation: 10,
      child: InkWell(
        onTap: () async {
          perbaikanPicker();
        },
        child: BlocBuilder<ImgPerbaikanBloc, GambarState>(
          builder: (context, state) {
            if (state is ErrorGambar) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(state.errMsg),
                  ),
                ),
              );
            } else if (state is LoadedGambar) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.file(
                  File(
                    state.urlImg,
                  ),
                  fit: BoxFit.fitWidth,
                ),
              );
            } else if (state is LoadingGambar) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.add_photo_alternate,
                  size: 180,
                  color: Colors.grey.shade600,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget ketPerbaikan() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Column(
              children: [
                Material(
                  color: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Keterangan Perbaikan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        maxLines: 10,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          alignLabelWithHint: true,
                          labelText: "Keterangan Penanggung Jawab",
                          hintText: "Keterangan Penanggung Jawab",
                        ),
                        onSaved: (value) {},
                        onFieldSubmitted: (term) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Keterangan Penanggung Jawab Wajib Di Isi';
                          }
                          return null;
                        },
                        controller: _keteranganPJ,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget resikoSesudah() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Column(
              children: [
                Material(
                  color: Colors.orange.shade700,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Kemungkinan Resiko",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        onTap: () async {
                          Kemungkinan? data = await Constants()
                              .goTo(() => const KemungkinanScreen(), context);
                          if (data != null) {
                            setState(
                              () {
                                nilaiKmSesudah = data.nilai!;
                                if (nilaiKpSesudah != null) {
                                  loadMetrikSesudah(
                                      nilaiKmSesudah, nilaiKpSesudah);
                                }
                                idKmSesudah = data.idKemungkinan;
                                _kemungkinanSesudah.text =
                                    "${data.kemungkinan}";
                              },
                            );
                          }
                        },
                        controller: _kemungkinanSesudah,
                        autofocus: false,
                        readOnly: true,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Kemungkinan Resiko",
                          hintText: "Kemungkinan Resiko",
                        ),
                        onSaved: (value) {},
                        onFieldSubmitted: (term) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kemungkinan Resiko Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.red.shade700,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Keparahan Resiko",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        onTap: () async {
                          Keparahan? data = await Constants()
                              .goTo(() => const KeparahanScreen(), context);
                          if (data != null) {
                            setState(
                              () {
                                nilaiKpSesudah = data.nilai!;
                                if (nilaiKmSesudah != null) {
                                  loadMetrikSesudah(
                                      nilaiKmSesudah, nilaiKpSesudah);
                                }
                                idKpSesudah = data.idKeparahan;
                                _keparahanSesudah.text = "${data.keparahan}";
                              },
                            );
                          }
                        },
                        controller: _keparahanSesudah,
                        autofocus: false,
                        readOnly: true,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _warna)),
                          labelStyle: TextStyle(color: _warna),
                          labelText: "Keparahan Resiko",
                          hintText: "Keparahan Resiko",
                        ),
                        onSaved: (value) {},
                        onFieldSubmitted: (term) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Keparahan Resiko Wajib Di Isi';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<MetrikSesudahBloc, MetrikState>(
            builder: (context, state) {
              if (state is MetrikLoaded) {
                return metrikWidgetSesudah(state.resiko);
              } else if (state is MetrikLoading) {
                return Container(
                  height: 70,
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 10,
                    child: const Center(child: CupertinoActivityIndicator()),
                  ),
                );
              }

              return Container();
            },
          )
        ],
      ),
    );
  }

  Widget metrikWidgetSesudah(MetrikResiko data) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Color(int.parse(data.bgColor!.replaceAll("#", "0xff"))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${data.kodeBahaya}",
                style: TextStyle(
                  color:
                      Color(int.parse(data.txtColor!.replaceAll("#", "0xff"))),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data.kategori}",
                style: TextStyle(
                  color:
                      Color(int.parse(data.txtColor!.replaceAll("#", "0xff"))),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data.min} - ${data.max}",
                style: TextStyle(
                  color:
                      Color(int.parse(data.txtColor!.replaceAll("#", "0xff"))),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionPJ() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Column(
              children: [
                RadioListTile(
                  value: 1,
                  groupValue: pjOption,
                  onChanged: (value) {
                    setState(() {
                      pjOption = int.parse("$value");
                    });
                  },
                  title: const Text("Pilih Penanggung Jawab"),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: pjOption,
                  onChanged: (value) {
                    setState(() {
                      pjOption = int.parse("$value");
                    });
                  },
                  title: const Text("Input Manual Penanggung Jawab"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pjAuto() {
    return Stack(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          margin:
              const EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: BlocBuilder<PjImgBloc, GambarState>(
                        builder: (context, state) {
                          if (state is ErrorGambar) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Text(state.errMsg),
                            );
                          } else if (state is LoadedGambar) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(
                                  state.urlImg,
                                ),
                                fit: BoxFit.cover,
                                width: 100,
                              ),
                            );
                          } else if (state is LoadingGambar) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const CupertinoActivityIndicator(
                                radius: 40,
                              ),
                            );
                          }
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const Icon(
                              Icons.person,
                              size: 100,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Penanggung Jawab",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2.5)
                  },
                  children: [
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Nama"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(": ${_namaPj.text.toString()}"),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("NIK / NRP"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(": ${_nikPJ.text.toString()}"),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            margin: const EdgeInsets.only(top: 30, right: 30),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                UsersList? data =
                    await Constants().goTo(() => const UsersScreen(), context);
                if (data != null) {
                  var _temp = await getTemporaryDirectory();
                  var _path = _temp.path;

                  if (data.photoProfile != null) {
                    var fName =
                        _path + data.nik! + '_' + data.username! + '.jpg';
                    File _file = File(fName);
                    var res = await http.get(Uri.parse(data.photoProfile!));
                    await _file.writeAsBytes(res.bodyBytes);
                    setState(() {
                      _pjImgBloc.tampilGambar(_file.path);
                      _imgPj = XFile(_file.path);
                      _namaPj.text = "${data.namaLengkap}";
                      _nikPJ.text = "${data.nik}";
                    });
                  } else {
                    Constants().showAlert(context,
                        judul: "Error",
                        msg: "Foto Penanggung Jawab Tidak Ada, Input Manual!");
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search_rounded,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget pjManual() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      margin: const EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () async {
                  pjPicker();
                },
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: BlocBuilder<PjImgBloc, GambarState>(
                      builder: (context, state) {
                        if (state is ErrorGambar) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Text(state.errMsg),
                          );
                        } else if (state is LoadedGambar) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              File(
                                state.urlImg,
                              ),
                              fit: BoxFit.cover,
                              width: 100,
                            ),
                          );
                        } else if (state is LoadingGambar) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const CupertinoActivityIndicator(
                              radius: 40,
                            ),
                          );
                        }
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Icon(
                            Icons.person,
                            size: 100,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Penanggung Jawab",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                border: const OutlineInputBorder(),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                labelStyle: TextStyle(color: _warna),
                labelText: "Nama",
                hintText: "Nama",
              ),
              controller: _namaPj,
              onSaved: (value) {},
              onFieldSubmitted: (term) {
                setState(() {});
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama Wajib Di Isi';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                border: const OutlineInputBorder(),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                labelStyle: TextStyle(color: _warna),
                labelText: "NIK / NRP",
                hintText: "NIK / NRP",
              ),
              onSaved: (value) {},
              onFieldSubmitted: (term) {
                setState(() {});
              },
              controller: _nikPJ,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'NIK / NRP Wajib Di Isi';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget btnAksi() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding:
            const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Card(
                color: Colors.blue.shade700,
                elevation: 10,
                child: InkWell(
                  onTap: () {
                    _submit();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Simpan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.red.shade700,
                elevation: 10,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Batal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget spacing(double i) {
    return SizedBox(
      height: i,
    );
  }

  pickerBtmSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 220,
            child: Stack(
              children: [
                Card(
                  margin: const EdgeInsets.only(top: 40),
                  color: Colors.white,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 8, right: 8),
                      child: ListView(
                        children: [
                          Card(
                            elevation: 10,
                            child: InkWell(
                              onTap: () async {
                                var img = await getImageCamera();
                                if (img != null) {
                                  Navigator.pop(context, img);
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
                                  Navigator.pop(context, img);
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
                            Navigator.pop(context);
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
          );
        });
  }

  Future<XFile?> getImageGallery() async {
    var imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    return imageFile;
  }

  Future<XFile?> getImageCamera() async {
    var imageFile = await imagePicker.pickImage(source: ImageSource.camera);
    return imageFile;
  }

  Future<DateTime?> _selectDate(BuildContext context, DateTime initDate) async {
    return await DatePicker.showDatePicker(context,
        showTitleActions: true, maxTime: dt, currentTime: initDate);
  }

  Future<DateTime?> _seletTime(BuildContext context, DateTime jamHazard) async {
    return await DatePicker.showTimePicker(context,
        showTitleActions: true, currentTime: jamHazard);
  }

  loadMetrik(nilaiKM, nilaiKP) async {
    var total = nilaiKM * nilaiKP;
    _metrikBloc.getResiko(total);
  }

  loadMetrikSesudah(nilaiKM, nilaiKP) async {
    var total = nilaiKM * nilaiKP;
    _metrikBlocSesudah.getResiko(total);
  }

  buktiPicker() async {
    XFile? bukti = await pickerBtmSheet();
    if (bukti != null) {
      _gambarBloc.tampilGambar(url: bukti.path);
      setState(() {
        _foto = bukti;
      });
    }
  }

  perbaikanPicker() async {
    XFile? imgPerbaikan = await pickerBtmSheet();
    if (imgPerbaikan != null) {
      _imgPerbaikanBloc.tampilGambar(imgPerbaikan.path);
      setState(() {
        _perbaikan = imgPerbaikan;
      });
    }
  }

  pjPicker() async {
    XFile? pjImg = await pickerBtmSheet();
    if (pjImg != null) {
      _pjImgBloc.tampilGambar(pjImg.path);
      setState(() {
        _imgPj = pjImg;
      });
    }
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_foto != null) {
        if (perbaikan == 1) {
          if (_perbaikan != null) {
            if (_imgPj != null) {
              if (kta > 0) {
                saveSelesai();
              } else {
                await Constants().showAlert(context,
                    judul: "Error Kategori Bahaya",
                    msg: "Kategori Bahaya Tidak Boleh Kosong!");
              }
            } else {
              await Constants().showAlert(context,
                  judul: "Error Foto Penanggung Jawab Tidak ada",
                  msg: "Foto Penanggung Jawab Tidak Boleh Kosong!");
              pjPicker();
            }
          } else {
            await Constants().showAlert(context,
                judul: "Error Foto Bukti Perbaikan Tidak ada",
                msg: "Foto Bukti Perbaikan Tidak Boleh Kosong!");
            perbaikanPicker();
          }
        } else {
          if (_imgPj != null) {
            if (kta > 0) {
              if (idPengendalian != null) {
                save();
              } else {
                await Constants().showAlert(context,
                    judul: "Error Pengendalian",
                    msg: "Pengendalian Resiko Tidak Boleh Kosong!");
              }
            } else {
              await Constants().showAlert(context,
                  judul: "Error Kategori Bahaya",
                  msg: "Kategori Bahaya Tidak Boleh Kosong!");
            }
          } else {
            await Constants().showAlert(context,
                judul: "Error Foto Penanggung Jawab Tidak ada",
                msg: "Foto Penanggung Jawab Tidak Boleh Kosong!");
            pjPicker();
          }
        }
      } else {
        await Constants().showAlert(
          context,
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
      context,
      dismiss: false,
      loading: true,
      enBtn: false,
    );
    HazardPostModel data = HazardPostModel();
    data.fileToUpload = File(_foto!.path);
    data.fileToUploadPJ = File(_imgPj!.path);
    data.perusahaan = _perusahaan.text;
    data.tglHazard = tglController.text;
    data.jamHazard = jamController.text;
    data.lokasi = "$idLokasi";
    data.lokasiDetail = _detailLokasi.text;
    data.deskripsi = _deskBahaya.text;
    data.kemungkinan = "$idKmSebelum";
    data.keparahan = "$idKpSebelum";
    data.katBahaya = bahaya.elementAt(kta - 1);
    data.pengendalian = "$idPengendalian";
    data.tindakan = _tindakan.text;
    data.namaPJ = _namaPj.text;
    data.nikPJ = _nikPJ.text;
    data.status = pcikPerbaikan.elementAt(perbaikan - 1);
    data.tglTenggat = _tenggat.text;
    data.userInput = "$_username";
    try {
      await _repository.postHazard(data, idDevice).then((res) {
        if (res != null) {
          if (res.success) {
            Navigator.pop(context);
            Navigator.pop(context, res.success);
          } else {
            Navigator.pop(context, false);
          }
        }
      });
    } on HttpException {
      if (kDebugMode) {
        print("$HttpException");
      }
      Navigator.pop(context, false);
    }
  }

  saveSelesai() async {
    Constants().showAlert(
      context,
      dismiss: false,
      loading: true,
      enBtn: false,
    );
    HazardPostSelesaiModel data = HazardPostSelesaiModel();
    data.fileToUpload = File(_foto!.path);
    data.fileToUploadPJ = File(_imgPj!.path);
    data.fileToUploadSelesai = File(_perbaikan!.path);
    data.perusahaan = _perusahaan.text;
    data.tglHazard = tglController.text;
    data.jamHazard = jamController.text;
    data.lokasi = "$idLokasi";
    data.lokasiDetail = _detailLokasi.text;
    data.deskripsi = _deskBahaya.text;
    data.kemungkinan = "$idKmSebelum";
    data.keparahan = "$idKpSebelum";
    data.kemungkinanSesudah = "$idKmSesudah";
    data.keparahanSesudah = "$idKpSesudah";
    data.katBahaya = bahaya.elementAt(kta - 1);
    data.pengendalian = "$idPengendalian";
    data.tindakan = _tindakan.text;
    data.namaPJ = _namaPj.text;
    data.nikPJ = _nikPJ.text;
    data.status = pcikPerbaikan.elementAt(perbaikan - 1);
    data.tglSelesai = _tenggat.text;
    data.jamSelesai = _tenggat.text;
    data.keteranganPJ = _keteranganPJ.text;
    data.userInput = "$_username";

    try {
      await _repository.postHazardSelesai(data, idDevice).then((res) {
        if (res != null) {
          if (res.success) {
            Navigator.pop(context);
            Navigator.pop(context, res.success);
          } else {
            Navigator.pop(context, false);
          }
        }
      });
    } on HttpException {
      if (kDebugMode) {
        print("$HttpException");
      }
      Navigator.pop(context, false);
    }
  }

  initIdDevice() async {
    String? _idDevice;
    try {
      _idDevice = await PlatformDeviceId.getDeviceId;
      if (mounted) {
        setState(() {
          idDevice = _idDevice;
        });
      }
    } on PlatformException {
      if (kDebugMode) {
        print("ERROR");
      }
    }
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    _username = pref.getString(Constants.USERNAME);
  }
}
