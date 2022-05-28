import 'package:cached_network_image/cached_network_image.dart';
import 'package:face_id_plus/abp_energy/utils/image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/state.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/form/status_perbaikan.dart';
import 'package:face_id_plus/abp_energy/hse/models/data_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/service/service.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class HazardDetail extends StatefulWidget {
  final Data? detail;
  const HazardDetail({this.detail, Key? key}) : super(key: key);

  @override
  State<HazardDetail> createState() => _HazardDetailState();
}

class _HazardDetailState extends State<HazardDetail> {
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

  late Data data;
  int? nilaiKpSebelum, nilaiKmSesudah, nilaiKpSesudah;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 221, 219, 219),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          title: const Text("Detail Hazard"),
        ),
        body: _listWidget(),
        floatingActionButton: (data.statusPerbaikan != "SELESAI")
            ? FloatingActionButton(
                onPressed: () async {
                  bool alert = await Constants().showAlert(context,
                      judul: "Update Hazard Report",
                      del: true,
                      msg: "Apakah anda yakin?",
                      fBtn: "Ya, Update Hazard",
                      sBtn: "Tidak");
                  if (alert) {
                    Constants().showAlert(context,
                        dismiss: false, loading: true, enBtn: false);

                    bool stat = await Constants().goTo(
                        () => RubahStatus(
                              detail: data,
                            ),
                        context);
                    if (stat) {
                      Navigator.pop(context, stat);
                      _reload();
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Icon(Icons.upload_file_outlined),
              )
            : null);
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
            return const Card(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
                elevation: 10,
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Gagal Memuat Gambar"),
                    )));
          } else if (state is LoadedGambar) {
            return Card(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 20),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Constants()
                          .goTo(() => ImageView(image: state.urlImg), context);
                    },
                    child: CachedNetworkImage(
                      imageUrl: state.urlImg,
                      fit: BoxFit.cover,
                      placeholder: (contex, url) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ));
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
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 6, 117, 10),
          padding: const EdgeInsets.all(10),
          child: const Text(
            "1. Data Temuan",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    child: Text(
                        titikDua + fmt.format(DateTime.parse(data.tglHazard!))),
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
    );
  }

  Widget _deskBahaya(Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 6, 117, 10),
          padding: const EdgeInsets.all(10),
          child: const Text(
            "2. Deskripsi Bahaya",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: Text(
                "Resiko Kemungkinan",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
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
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: Text(
              "Resiko Keparahan",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
          padding: const EdgeInsets.all(10),
          child: const Text(
            "3. Kategori Bahaya",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${data.katBahaya}"),
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Metode Pengendalian",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${data.namaPengendalian}"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _tindakanPerbaikan(Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 6, 117, 10),
          padding: const EdgeInsets.all(10),
          child: const Text(
            "4. Tindakan Yang Dilakukan Untuk Perbaikan",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text("Gagal Memuat Gambar"),
                      ));
                } else if (state is LoadedGambar) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Constants().goTo(
                            () => ImageView(image: state.urlImg), context);
                      },
                      child: CachedNetworkImage(
                        imageUrl: state.urlImg,
                        fit: BoxFit.cover,
                        placeholder: (contex, url) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  );
                }
                return const Padding(
                    padding: EdgeInsets.all(8.0), child: Icon(Icons.people));
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
                child: Text((data.keteranganUpdate != null)
                    ? data.keteranganUpdate!
                    : "-"),
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
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: Text(
              "Resiko Kemungkinan Sesudah",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: Text(
              "Resiko Keparahan Sesudah",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
        _gambarBloc.tampilGambar(url: baseImage + res!.bukti!);
        _imgPerbaikanBloc
            .tampilGambar(baseImage + "update/" + res.updateBukti!);
        setState(() {
          data = res;
        });
        Navigator.pop(context, true);
      });
    }
  }
}
