import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/state.dart';
import 'package:face_id_plus/abp_energy/hse/models/data_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/metrik_resiko_model.dart';
import 'package:face_id_plus/abp_energy/master/screen/kemungkinan.dart';
import 'package:face_id_plus/abp_energy/master/screen/keparahan.dart';
import 'package:face_id_plus/abp_energy/service/service.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class RubahMetrik extends StatefulWidget {
  final String? titleHead;
  final String? tipe;
  final Data? data;
  const RubahMetrik({this.titleHead, this.data, this.tipe, Key? key})
      : super(key: key);

  @override
  State<RubahMetrik> createState() => _RubahMetrikState();
}

class _RubahMetrikState extends State<RubahMetrik> {
  final _formKey = GlobalKey<FormState>();
  final MetrikService _metrikService = MetrikService();
  late MetrikBloc _metrikBloc;

  final _kemungkinan = TextEditingController();
  final _keparahan = TextEditingController();

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

  final Color _warna = const Color.fromARGB(255, 8, 19, 147);
  @override
  void initState() {
    _metrikBloc = MetrikBloc(_metrikService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<MetrikBloc>(create: (context) => _metrikBloc)],
      child: Scaffold(
        appBar: AppBar(
            title: Text("${widget.titleHead}"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            )),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              ListView(
                children: [
                  resikoSebelum(),
                ],
              ),
              btnAksi(),
            ],
          ),
        ),
      ),
    );
  }

  Widget resikoSebelum() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
          BlocBuilder<MetrikBloc, MetrikState>(
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

  loadMetrik(nilaiKM, nilaiKP) async {
    var total = nilaiKM * nilaiKP;
    _metrikBloc.getResiko(total);
  }

  simpanResikoSebelum() async {}
  simpanResikoSesudah() async {}

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Constants().showAlert(
        context,
        dismiss: false,
        loading: true,
        enBtn: false,
      );
      if (widget.tipe == "sebelum") {
        simpanResikoSebelum();
      } else if (widget.tipe == "sesudah") {
        simpanResikoSesudah();
      }
    }
  }
}
