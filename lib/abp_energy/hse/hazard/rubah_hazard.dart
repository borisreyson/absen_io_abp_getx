// ignore_for_file: unused_field

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/state.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/form/rubah_bahaya.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/form/rubah_kategori.dart';
import 'package:face_id_plus/abp_energy/hse/models/data_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/master/model/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/master/model/pengendalian.dart';
import 'package:face_id_plus/abp_energy/master/screen/kemungkinan.dart';
import 'package:face_id_plus/abp_energy/master/screen/keparahan.dart';
import 'package:face_id_plus/abp_energy/master/screen/pengendalian.dart';
import 'package:face_id_plus/abp_energy/service/service.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:face_id_plus/abp_energy/utils/image_view.dart';
import 'package:platform_device_id/platform_device_id.dart';

class RubahHazard extends StatefulWidget {
  final Data? detail;
  const RubahHazard({this.detail, Key? key}) : super(key: key);

  @override
  State<RubahHazard> createState() => _RubahHazardState();
}

class _RubahHazardState extends State<RubahHazard> {
  final _repository = HazardRepository();
  final KemungkinanService _kmService = KemungkinanService();
  final KeparahanService _kpService = KeparahanService();
  final MetrikService _metrikService = MetrikService();
  final String baseImage = "https://abpjobsite.com/bukti_hazard/";
  String perusahaan = "Perusahaan";
  late GambarBloc _gambarBloc;
  late ImgPerbaikanBloc _imgPerbaikanBloc;
  late PjImgBloc _pjImgBloc;
  late ResikoSebelumBloc _resikoSebelumBloc;
  late ResikoSesudahBloc _resikoSesudahBloc;
  String? idDevice;
  late Data data;
  int? nilaiKpSebelum, nilaiKmSesudah, nilaiKpSesudah;
  var imagePicker = ImagePicker();
  XFile? _foto, _perbaikan, _imgPj;

  @override
  void initState() {
    initIdDevice();
    _foto = null;
    _perbaikan = null;
    _imgPj = null;
    data = widget.detail!;
    _getResikoSebelum(data: data);
    if (data.idKemungkinanSesudah != null) {
      _getResikoSesudah(data: data);
    }
    _gambarBloc = GambarBloc();
    _imgPerbaikanBloc = ImgPerbaikanBloc();
    _pjImgBloc = PjImgBloc();
    _resikoSebelumBloc = ResikoSebelumBloc();
    _resikoSesudahBloc = ResikoSesudahBloc();
    _gambarBloc.tampilGambar(url: baseImage + data.bukti!);
    if (data.updateBukti != null) {
      _imgPerbaikanBloc.tampilGambar(baseImage + "update/" + data.updateBukti!);
    }
    _pjImgBloc.tampilGambar(baseImage + "penanggung_jawab/" + data.fotoPJ!);

    super.initState();
  }

  _getResikoSebelum({required Data data}) async {
    var kmSebelum = await _kmService.getBy(idKemungkinan: data.idKemungkinan);
    var kpSebelum = await _kpService.getBy(idKeparahan: data.idKeparahan);
    var resikoSebelum = await _metrikService.getBy(
        nilai: (kmSebelum.nilai! * kpSebelum.nilai!));
    _resikoSebelumBloc.getResiko(kmSebelum, kpSebelum, resikoSebelum);
  }

  _getResikoSesudah({required Data data}) async {
    var kmSesudah =
        await _kmService.getBy(idKemungkinan: data.idKemungkinanSesudah);
    var kpSesudah =
        await _kpService.getBy(idKeparahan: data.idKeparahanSesudah);
    var resikoSesudah = await _metrikService.getBy(
        nilai: (kmSesudah.nilai! * kpSesudah.nilai!));
    _resikoSesudahBloc.getResiko(kmSesudah, kpSesudah, resikoSesudah);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 219, 219),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _reload();
            },
            icon: const Icon(Icons.replay_circle_filled_rounded),
          )
        ],
        title: const Text("Rubah Hazard"),
      ),
      body: _listWidget(),
    );
  }

  Widget _listWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GambarBloc>(create: (context) => _gambarBloc),
        BlocProvider<ImgPerbaikanBloc>(create: (context) => _imgPerbaikanBloc),
        BlocProvider<PjImgBloc>(create: (context) => _pjImgBloc),
        BlocProvider<ResikoSebelumBloc>(
            create: (context) => _resikoSebelumBloc),
        BlocProvider<ResikoSesudahBloc>(
            create: (context) => _resikoSesudahBloc),
      ],
      child: ListView(
        children: [
          _loadImage(),
          _dataTemuan(data),
          _deskBahaya(data),
          _rkemSebelum(data),
          _rkepSebelum(data),
          _totalResiko(data),
          _katBahaya(data),
          metodePengendalian(data),
          _tindakanPerbaikan(data),
          _statusPerbaikan(data),
          (data.updateBukti != null) ? _gambarPerbaikan() : Container(),
          (data.idKemungkinanSesudah != null)
              ? _rkemSetelah(data)
              : Container(),
          (data.idKeparahanSesudah != null) ? _rKepSesudah(data) : Container(),
          (data.idKemungkinanSesudah != null)
              ? _totalResikoSesudah(data)
              : Container(),
          _penanggungJawab(data),
        ],
      ),
    );
  }

  Widget _loadImage() {
    return SizedBox(
      height: 300,
      child: BlocBuilder<GambarBloc, GambarState>(
        builder: (context, state) {
          if (state is ErrorGambar) {
            return Stack(
              children: [
                const Card(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 20),
                    elevation: 10,
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("Gagal Memuat Gambar"),
                        ))),
                Align(
                  alignment: Alignment.topRight,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    margin: const EdgeInsets.only(right: 20, top: 20),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          buktiPicker();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Color.fromARGB(255, 128, 125, 125),
                          ),
                        )),
                  ),
                )
              ],
            );
          } else if (state is LoadingGambar) {
            return Stack(
              children: [
                const Card(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 20),
                    elevation: 10,
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CupertinoActivityIndicator(
                            radius: 30,
                          ),
                        ))),
                Align(
                  alignment: Alignment.topRight,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    margin: const EdgeInsets.only(right: 20, top: 20),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          buktiPicker();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Color.fromARGB(255, 128, 125, 125),
                          ),
                        )),
                  ),
                )
              ],
            );
          } else if (state is LoadedGambar) {
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 20),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: InkWell(
                          onTap: () {
                            Constants().goTo(
                                () => ImageView(image: state.urlImg), context);
                          },
                          child: CachedNetworkImage(
                            imageUrl: state.urlImg,
                            fit: BoxFit.fitWidth,
                            placeholder: (contex, url) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    margin: const EdgeInsets.only(right: 20, top: 20),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          buktiPicker();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Color.fromARGB(255, 128, 125, 125),
                          ),
                        )),
                  ),
                )
              ],
            );
          }
          return const Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
              elevation: 10,
              child: Padding(
                  padding: EdgeInsets.all(8.0), child: Icon(Icons.people)));
        },
      ),
    );
  }

  Widget _dataTemuan(Data data) {
    var fmt = DateFormat("dd MMMM yyyy");
    var titikDua = ": ";
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 6, 117, 10),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "1. Data Temuan",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  // Card(
                  //   elevation: 10,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(100),
                  //   ),
                  //   child: InkWell(
                  //       borderRadius: BorderRadius.circular(100),
                  //       onTap: () {},
                  //       child: const Padding(
                  //         padding: EdgeInsets.all(6.0),
                  //         child: Icon(
                  //           Icons.mode_edit_outline_outlined,
                  //           color: Color.fromARGB(255, 128, 125, 125),
                  //         ),
                  //       )),
                  // )
                ],
              ),
            ),
            Card(
              elevation: 10,
              margin: const EdgeInsets.only(
                  top: 20, bottom: 20, right: 10, left: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2)
                  },
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(perusahaan),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(titikDua + data.perusahaan!),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Tanggal"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(titikDua +
                            fmt.format(DateTime.parse(data.tglHazard!))),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Jam"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(titikDua + data.jamHazard!),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Lokasi"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(titikDua + data.lokasiHazard!),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Detail Lokasi"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(titikDua + data.lokasiDetail!),
                      ),
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _deskBahaya(Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: const Color.fromARGB(255, 6, 117, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "2. Deskripsi Bahaya",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () async {
                      bool status = await Constants().goTo(
                          () => RubahBahaya(
                                data: data,
                                tipe: "bahaya",
                              ),
                          context);
                      if (status) {
                        _reload();
                      } else {
                        // Navigator.pop(context, false);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.mode_edit_outline_outlined,
                        color: Color.fromARGB(255, 128, 125, 125),
                      ),
                    )),
              )
            ],
          ),
        ),
        Card(
            elevation: 10,
            margin:
                const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${data.deskripsi}")))
      ],
    );
  }

  Widget _rkemSebelum(Data data) {
    return BlocListener<ResikoSebelumBloc, ResikoState>(
      listener: (context, state) {
        if (state is ResikoLoaded) {
          nilaiKpSebelum = state.keparahan.nilai;
        }
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.orangeAccent,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Center(
                  child: Text(
                    "Resiko Kemungkinan",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () async {
                        ubahKemungkinan("kemungkinan_sebelum");
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.mode_edit_outline_outlined,
                          color: Color.fromARGB(255, 128, 125, 125),
                        ),
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: BlocBuilder<ResikoSebelumBloc, ResikoState>(
                  builder: (context, state) {
                    if (state is ResikoLoading) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CupertinoActivityIndicator(),
                          ),
                          Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Nilai"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CupertinoActivityIndicator(),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (state is ResikoLoaded) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${state.kemungkinan.kemungkinan}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text("Nilai"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("${state.kemungkinan.nilai}"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(),
                        ),
                        Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Nilai"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CupertinoActivityIndicator(),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rkepSebelum(Data data) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: Text(
                  "Resiko Keparahan",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () async {
                      ubahKeparahan("keparahan_sebelum");
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.mode_edit_outline_outlined,
                        color: Color.fromARGB(255, 128, 125, 125),
                      ),
                    )),
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: BlocBuilder<ResikoSebelumBloc, ResikoState>(
                builder: (context, state) {
                  if (state is ResikoLoading) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CupertinoActivityIndicator(),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CupertinoActivityIndicator(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is ResikoLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${state.keparahan.keparahan}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Nilai"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${state.keparahan.nilai}"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CupertinoActivityIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CupertinoActivityIndicator(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CupertinoActivityIndicator(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _totalResiko(Data data) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<ResikoSebelumBloc, ResikoState>(
        builder: (context, state) {
          if (state is ResikoLoaded) {
            var txtColor =
                int.parse("0xff" + state.resiko.txtColor!.split("#")[1]);
            var bgColor =
                int.parse("0xff" + state.resiko.bgColor!.split("#")[1]);
            return Card(
                elevation: 10,
                color: Color(bgColor),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${state.resiko.kodeBahaya}",
                            style: TextStyle(
                                color: Color(txtColor),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${state.resiko.kategori}",
                            style: TextStyle(
                                color: Color(txtColor),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${state.resiko.min} - ${state.resiko.max}",
                            style: TextStyle(
                                color: Color(txtColor),
                                fontWeight: FontWeight.bold),
                          ),
                        ])));
          } else if (state is ResikoError) {
            return Card(
                elevation: 10,
                color: Colors.blue,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text(state.error)])));
          }
          return Card(
              elevation: 10,
              color: Colors.blue,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [CupertinoActivityIndicator()])));
        },
      ),
    );
  }

  Widget _katBahaya(Data data) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "3. Kategori Bahaya",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      ubahKategoriBahaya();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.mode_edit_outline_outlined,
                        color: Color.fromARGB(255, 128, 125, 125),
                      ),
                    )),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          elevation: 10,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${data.katBahaya}"),
            ),
          ),
        ),
      ],
    );
  }

  Widget metodePengendalian(Data data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Metode Pengendalian",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          ubahPengendalian();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Color.fromARGB(255, 128, 125, 125),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("${data.namaPengendalian}"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tindakanPerbaikan(Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 6, 117, 10),
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "4. Tindakan Yang Dilakukan Untuk Perbaikan",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () async {
                      bool status = await Constants().goTo(
                          () => RubahBahaya(
                                data: data,
                                tipe: "tindakan",
                              ),
                          context);
                      if (status) {
                        if (widget.detail != null) {
                          _reload();
                        }
                      } else {
                        // Navigator.pop(context, false);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.mode_edit_outline_outlined,
                        color: Color.fromARGB(255, 128, 125, 125),
                      ),
                    )),
              )
            ],
          ),
        ),
        Card(
            elevation: 10,
            margin:
                const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data.tindakan!)))
      ],
    );
  }

  Widget _statusPerbaikan(Data data) {
    var fmt = DateFormat("dd MMMM yyyy");
    var titikDua = ": ";
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Status Perbaikan",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Card(
          elevation: 10,
          margin:
              const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2.5)
              },
              children: [
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Status Perbaikan"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(titikDua + data.statusPerbaikan!),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Tanggal Tenggat / Due Date"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text((data.tglTenggat != null)
                        ? titikDua +
                            fmt.format(DateTime.parse(data.tglTenggat!))
                        : "-"),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Tanggal Selesai"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text((data.tglSelesai != null)
                        ? titikDua +
                            fmt.format(DateTime.parse(data.tglSelesai!))
                        : "-"),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Jam Selesai"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text((data.jamSelesai != null)
                        ? titikDua + data.jamSelesai!
                        : "-"),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Dibuat"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(titikDua + data.namaLengkap!),
                  ),
                ]),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _gambarPerbaikan() {
    return Card(
      color: Colors.blue,
      elevation: 10,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: BlocBuilder<ImgPerbaikanBloc, GambarState>(
              builder: (context, state) {
                if (state is ErrorGambar) {
                  return Stack(
                    children: const [
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("Gagal Memuat Gambar"),
                          )),
                    ],
                  );
                } else if (state is LoadedGambar) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Constants().goTo(
                                  () => ImageView(image: state.urlImg),
                                  context);
                            },
                            child: CachedNetworkImage(
                              imageUrl: state.urlImg,
                              fit: BoxFit.fitWidth,
                              placeholder: (contex, url) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          margin: const EdgeInsets.only(right: 20, top: 20),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                perbaikanPicker();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.mode_edit_outline_outlined,
                                  color: Color.fromARGB(255, 128, 125, 125),
                                ),
                              )),
                        ),
                      )
                    ],
                  );
                }
                return Stack(
                  children: const [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.people)),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((data.keteranganUpdate != null)
                        ? data.keteranganUpdate!
                        : "-"),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () async {
                            bool status = await Constants().goTo(
                                () => RubahBahaya(
                                      data: data,
                                      tipe: "perbaikan",
                                    ),
                                context);
                            if (status) {
                              if (widget.detail != null) {
                                _reload();
                              }
                            } else {
                              // Navigator.pop(context, false);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.mode_edit_outline_outlined,
                              color: Color.fromARGB(255, 128, 125, 125),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _rkemSetelah(Data data) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.orangeAccent,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: Text(
                  "Resiko Kemungkinan Sesudah",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () async {
                      ubahKemungkinan("kemungkinan_sesudah");
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.mode_edit_outline_outlined,
                        color: Color.fromARGB(255, 128, 125, 125),
                      ),
                    )),
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: BlocBuilder<ResikoSesudahBloc, ResikoState>(
                builder: (context, state) {
                  if (state is ResikoLoading) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(),
                        ),
                        Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Nilai"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CupertinoActivityIndicator(),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (state is ResikoLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${state.kemungkinan.kemungkinan}"),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Nilai"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("${state.kemungkinan.nilai}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CupertinoActivityIndicator(),
                      ),
                      Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Nilai"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CupertinoActivityIndicator(),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rKepSesudah(Data data) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: Text(
                  "Resiko Keparahan Sesudah",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () async {
                      ubahKeparahan("keparahan_sesudah");
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.mode_edit_outline_outlined,
                        color: Color.fromARGB(255, 128, 125, 125),
                      ),
                    )),
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: BlocBuilder<ResikoSesudahBloc, ResikoState>(
                builder: (context, state) {
                  if (state is ResikoLoading) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(),
                        ),
                        Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Nilai"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CupertinoActivityIndicator(),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (state is ResikoLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${state.keparahan.keparahan}"),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Nilai"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("${state.keparahan.nilai}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CupertinoActivityIndicator(),
                      ),
                      Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Nilai"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CupertinoActivityIndicator(),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _totalResikoSesudah(Data data) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<ResikoSesudahBloc, ResikoState>(
        builder: (context, state) {
          if (state is ResikoLoaded) {
            var txtColor =
                int.parse("0xff" + state.resiko.txtColor!.split("#")[1]);
            var bgColor =
                int.parse("0xff" + state.resiko.bgColor!.split("#")[1]);
            return Card(
              elevation: 10,
              color: Color(bgColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${state.resiko.kodeBahaya}",
                      style: TextStyle(
                          color: Color(txtColor), fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${state.resiko.kategori}",
                      style: TextStyle(
                          color: Color(txtColor), fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${state.resiko.min} - ${state.resiko.max}",
                      style: TextStyle(
                          color: Color(txtColor), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ResikoError) {
            return Card(
                elevation: 10,
                color: Colors.blue,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text(state.error)])));
          }
          return Card(
              elevation: 10,
              color: Colors.blue,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [CupertinoActivityIndicator()])));
        },
      ),
    );
  }

  Widget _penanggungJawab(Data data) {
    var titikDua = ": ";
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Card(
                color: const Color.fromARGB(147, 144, 202, 249),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: BlocBuilder<PjImgBloc, GambarState>(
                      builder: (context, state) {
                        if (state is ErrorGambar) {
                          return const Center(
                            child: Text("Gagal Memuat Gambar"),
                          );
                        } else if (state is LoadedGambar) {
                          return Image.network(
                            state.urlImg,
                            fit: BoxFit.cover,
                          );
                        }
                        return const Icon(Icons.people);
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
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2.5)
            },
            children: [
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Nama"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(titikDua + data.namaPJ!),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("NIK / NRP"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(titikDua + data.nikPJ!),
                ),
              ]),
            ],
          ),
        ],
      ),
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

  buktiPicker() async {
    Constants().showAlert(
      context,
      dismiss: false,
      loading: true,
      enBtn: false,
    );
    XFile? bukti = await pickerBtmSheet();

    if (bukti != null) {
      var data = HazardGambarBukti();
      data.buktiSebelum = File(bukti.path);
      if (widget.detail != null) {
        data.uid = widget.detail!.uid;
      } else {
        Navigator.pop(context, false);
      }
      await _repository.postGambarBukti(data, idDevice).then((response) async {
        if (response != null) {
          if (response.success) {
            if (kDebugMode) {
              print("uid : ${data.uid}");
            }
            await _repository.getHazardDetail(data.uid).then((res) {
              if (res != null) {
                var bukti = res.bukti;
                _gambarBloc.tampilGambar(url: baseImage + bukti!);
                if (kDebugMode) {
                  print("data");
                }
                Navigator.pop(context, true);
              } else {
                if (kDebugMode) {
                  print("error");
                }
                Navigator.pop(context, false);
              }
            });
          } else {
            if (kDebugMode) {
              print("error 1");
            }
            Navigator.pop(context, false);
          }
        } else {
          if (kDebugMode) {
            print("error 2");
          }
          Navigator.pop(context, false);
        }
      }).catchError((onError) {
        if (kDebugMode) {
          print("error 3 $onError");
        }
        Navigator.pop(context, false);
      });
    } else {
      if (kDebugMode) {
        print("error 4");
      }
      Navigator.pop(context, false);
    }
  }

  perbaikanPicker() async {
    Constants().showAlert(
      context,
      dismiss: false,
      loading: true,
      enBtn: false,
    );
    XFile? imgPerbaikan = await pickerBtmSheet();

    if (imgPerbaikan != null) {
      var data = HazardGambarPerbaikan();
      data.buktiSelesai = File(imgPerbaikan.path);
      if (widget.detail != null) {
        data.uid = widget.detail!.uid;
      } else {
        Navigator.pop(context, false);
      }
      await _repository
          .postGambarPerbaikan(data, idDevice)
          .then((response) async {
        if (response != null) {
          if (response.success) {
            if (kDebugMode) {
              print("uid : ${data.uid}");
            }
            await _repository.getHazardDetail(data.uid).then((res) {
              if (res != null) {
                var img = res.updateBukti;
                _imgPerbaikanBloc.tampilGambar(baseImage + "update/" + img!);
                if (kDebugMode) {
                  print("data");
                }
                Navigator.pop(context, true);
              } else {
                if (kDebugMode) {
                  print("error");
                }
                Navigator.pop(context, false);
              }
            });
          } else {
            if (kDebugMode) {
              print("error 1");
            }
            Navigator.pop(context, false);
          }
        } else {
          if (kDebugMode) {
            print("error 2");
          }
          Navigator.pop(context, false);
        }
      }).catchError((onError) {
        if (kDebugMode) {
          print("error 3 $onError");
        }
        Navigator.pop(context, false);
      });
    } else {
      if (kDebugMode) {
        print("error 4");
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

  _reload() async {
    Constants().showAlert(
      context,
      dismiss: false,
      loading: true,
      enBtn: false,
    );
    if (widget.detail != null) {
      var uid = widget.detail!.uid;
      await _repository.getHazardDetail(uid).then((res) {
        if (res != null) {
          _gambarBloc.tampilGambar(url: baseImage + res.bukti!);
          if (res.updateBukti != null) {
            _imgPerbaikanBloc
                .tampilGambar(baseImage + "update/" + res.updateBukti!);
          }
          setState(() {
            data = res;
            _getResikoSebelum(data: data);
            _getResikoSesudah(data: data);
            Navigator.pop(context, true);
          });
        } else {
          Navigator.pop(context, false);
        }
      });
    }
  }

  void ubahKemungkinan(String tipeKemungkinan) async {
    Kemungkinan? kemungkinan =
        await Constants().goTo(() => const KemungkinanScreen(), context);
    if (kemungkinan != null) {
      await _repository
          .postUpdateResiko(
              data.uid, tipeKemungkinan, "${kemungkinan.idKemungkinan}")
          .then((result) {
        if (result != null) {
          if (result.success) {
            _reload();
          } else {
            Constants().showAlert(
              context,
              judul: "Error",
              msg: "Gagal Mengupdate Resiko Kemungkinan!",
            );
          }
        } else {
          Constants().showAlert(
            context,
            judul: "Error",
            msg: "Gagal Mengupdate Resiko Kemungkinan!",
          );
        }
      });
    }
  }

  void ubahKeparahan(String tipeKeparahan) async {
    Keparahan? keparahan =
        await Constants().goTo(() => const KeparahanScreen(), context);
    if (keparahan != null) {
      await _repository
          .postUpdateResiko(data.uid, tipeKeparahan, "${keparahan.idKeparahan}")
          .then((result) {
        if (result != null) {
          if (result.success) {
            _reload();
          } else {
            Constants().showAlert(
              context,
              judul: "Error",
              msg: "Gagal Mengupdate Resiko Kemungkinan!",
            );
          }
        } else {
          Constants().showAlert(
            context,
            judul: "Error",
            msg: "Gagal Mengupdate Resiko Kemungkinan!",
          );
        }
      });
    }
  }

  ubahKategoriBahaya() async {
    String? katBahaya =
        await Constants().goTo(() => const RubahKategori(), context);
    if (katBahaya != null) {
      await _repository.postUpdateKatBahaya(data.uid, katBahaya).then((result) {
        if (result != null) {
          if (result.success) {
            _reload();
          } else {
            Constants().showAlert(
              context,
              judul: "Error",
              msg: "Gagal Mengupdate Kategori Bahaya!",
            );
          }
        } else {
          Constants().showAlert(
            context,
            judul: "Error",
            msg: "Gagal Mengupdate Kategori Bahaya!",
          );
        }
      });
    }
  }

  ubahPengendalian() async {
    Hirarki? pengendalian =
        await Constants().goTo(() => const PengendalianScreen(), context);
    if (pengendalian != null) {
      await _repository
          .postUpdatePengendalian(data.uid, "${pengendalian.idHirarki}")
          .then((result) {
        if (result != null) {
          if (result.success) {
            _reload();
          } else {
            Constants().showAlert(
              context,
              judul: "Error",
              msg: "Gagal Mengupdate Resiko Pengendalian!",
            );
          }
        } else {
          Constants().showAlert(
            context,
            judul: "Error",
            msg: "Gagal Mengupdate Resiko Pengendalian!",
          );
        }
      });
    }
  }
}
