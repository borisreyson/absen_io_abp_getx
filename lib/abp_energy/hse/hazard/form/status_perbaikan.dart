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
import 'package:face_id_plus/abp_energy/hse/models/data_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/metrik_resiko_model.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/master/screen/kemungkinan.dart';
import 'package:face_id_plus/abp_energy/master/screen/keparahan.dart';
import 'package:face_id_plus/abp_energy/service/service.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:platform_device_id/platform_device_id.dart';

class RubahStatus extends StatefulWidget {
  final Data? detail;
  const RubahStatus({this.detail, Key? key}) : super(key: key);

  @override
  State<RubahStatus> createState() => _RubahStatusState();
}

class _RubahStatusState extends State<RubahStatus> {
  final _formKey = GlobalKey<FormState>();
  late HazardPostRepository _repository;
  var imagePicker = ImagePicker();
  late GambarBloc _gambarBloc;
  late MetrikSesudahBloc _metrikBlocSesudah;

  XFile? _foto;
  final Color _warna = const Color(0xFF591505);

  final _keteranganPJ = TextEditingController();
  final _kemungkinanSesudah = TextEditingController();
  final _keparahanSesudah = TextEditingController();
  final _tglSelesai = TextEditingController();
  final _jamSelesai = TextEditingController();

  int? nilaiKmSesudah, nilaiKpSesudah;
  String? idDevice;

  int? idKmSesudah, idKpSesudah;

  DateTime dt = DateTime.now();
  DateFormat fmt = DateFormat('dd MMMM yyyy');

  DateTime? tglSelesai;
  DateTime? jamSelesai;
  @override
  void initState() {
    initIdDevice();

    tglSelesai = dt;
    jamSelesai =
        DateTime(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);
    _repository = HazardPostRepository();
    _gambarBloc = GambarBloc();
    _metrikBlocSesudah = MetrikSesudahBloc(MetrikService());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GambarBloc>(create: (context) => _gambarBloc),
        BlocProvider<MetrikSesudahBloc>(
            create: (context) => _metrikBlocSesudah),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Hazard"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              ListView(
                children: [
                  fotoBukti(),
                  ketPerbaikan(),
                  statusPerbaikan(),
                  resikoSesudah(),
                  spacing(80),
                ],
              ),
              btnAksi(),
            ],
          ),
        ),
      ),
    );
  }

  Widget fotoBukti() {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                    child: const Center(
                      child: Text(
                        "Waktu Penyelesaian",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onTap: () async {
                      var tgl = await _selectDate(context, tglSelesai!);
                      if (tgl != null) {
                        setState(() {
                          _tglSelesai.text = fmt.format(tgl);
                        });
                      }
                    },
                    autofocus: false,
                    readOnly: true,
                    controller: _tglSelesai,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _warna)),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _warna)),
                      labelStyle: TextStyle(color: _warna),
                      labelText: "Tanggal Selesai",
                      hintText: "Tanggal Selesai",
                    ),
                    onSaved: (value) {},
                    onFieldSubmitted: (term) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tanggal Selesai Wajib Di Isi';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onTap: () async {
                      dt = DateTime.now();
                      jamSelesai = dt;
                      var jam = await _seletTime(context, jamSelesai!);
                      if (jam != null) {
                        setState(() {
                          _jamSelesai.text =
                              "${jam.hour.toString().padLeft(2, '0')}:${jam.minute.toString().padLeft(2, '0')}";
                        });
                      }
                    },
                    autofocus: false,
                    readOnly: true,
                    controller: _jamSelesai,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _warna)),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _warna)),
                      labelStyle: TextStyle(color: _warna),
                      labelText: "Jam Selesai",
                      hintText: "Jam Selesai",
                    ),
                    onSaved: (value) {},
                    onFieldSubmitted: (term) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Jam Selesai Wajib Di Isi';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget btnAksi() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 205, 205, 205),
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

  buktiPicker() async {
    XFile? bukti = await pickerBtmSheet();
    if (bukti != null) {
      _gambarBloc.tampilGambar(url: bukti.path);
      setState(() {
        _foto = bukti;
      });
    }
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
                                Constants().showAlert(
                                  context,
                                  dismiss: false,
                                  loading: true,
                                  enBtn: false,
                                );
                                var img = await getImageCamera();
                                if (img != null) {
                                  Navigator.pop(context, img);
                                  Navigator.pop(context, img);
                                } else {
                                  Navigator.pop(context);
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
                                Constants().showAlert(
                                  context,
                                  dismiss: false,
                                  loading: true,
                                  enBtn: false,
                                );
                                var img = await getImageGallery();
                                if (img != null) {
                                  Navigator.pop(context, img);
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

  loadMetrikSesudah(nilaiKM, nilaiKP) async {
    var total = nilaiKM * nilaiKP;
    _metrikBlocSesudah.getResiko(total);
  }

  Widget spacing(double i) {
    return SizedBox(
      height: i,
    );
  }

  _submit() async {
    if (_foto != null) {
      if (_formKey.currentState!.validate()) {
        upload();
      }
    } else {
      await Constants().showAlert(
        context,
        judul: "Error Foto Perbaikan Tidak ada",
        msg: "Foto Perbaikan Tidak Boleh Kosong!",
      );
      buktiPicker();
    }
  }

  upload() async {
    Constants().showAlert(
      context,
      dismiss: false,
      loading: true,
      enBtn: false,
    );
    HazardUpdate data = HazardUpdate();
    data.fileToUpload = File(_foto!.path);
    data.uid = widget.detail!.uid;
    data.tglSelesai = _tglSelesai.text;
    data.jamSelesai = _jamSelesai.text;
    data.idKemungkinanSesudah = "$idKmSesudah";
    data.idKeparahanSesudah = "$idKpSesudah";
    data.keterangan = _keteranganPJ.text;
    try {
      await _repository.postUpdateHazard(data, idDevice).then((res) {
        if (res != null) {
          if (res.success) {
            Navigator.pop(context, res.success);
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

  Future<DateTime?> _selectDate(BuildContext context, DateTime initDate) async {
    return await DatePicker.showDatePicker(context,
        showTitleActions: true, maxTime: dt, currentTime: initDate);
  }

  Future<DateTime?> _seletTime(BuildContext context, DateTime jamHazard) async {
    return await DatePicker.showTimePicker(context,
        showTitleActions: true, currentTime: jamHazard);
  }
}
