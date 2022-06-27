import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/data_hazard.dart';
import '../controllers/rubah_hazard_controller.dart';

class RubahHazardView extends GetView<RubahHazardController> {
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
              controller.reload(context);
            },
            icon: const Icon(Icons.replay_circle_filled_rounded),
          )
        ],
        title: const Text("Rubah Hazard"),
      ),
      body: _listWidget(context),
    );
  }

  Widget _listWidget(context) {
    var data = controller.data.value;
    return ListView(
      children: [
        _loadImage(),
        _dataTemuan(data, context),
        _deskBahaya(data, context),
        _rkemSebelum(data, context),
        _rkepSebelum(data, context),
        _totalResiko(data, context),
        _katBahaya(data, context),
        metodePengendalian(data, context),
        _tindakanPerbaikan(data, context),
        _statusPerbaikan(data, context),
        (data.updateBukti != null)
            ? _gambarPerbaikan(data, context)
            : Container(),
        (data.idKemungkinanSesudah != null)
            ? _rkemSetelah(data, context)
            : Container(),
        (data.idKeparahanSesudah != null)
            ? _rKepSesudah(data, context)
            : Container(),
        (data.idKemungkinanSesudah != null)
            ? _totalResikoSesudah(data, context)
            : Container(),
        _penanggungJawab(data, context),
      ],
    );
  }

  Widget _loadImage() {
    return SizedBox(
        height: 300,
        child: Stack(
          children: [
            const Card(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
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
                      // buktiPicker();
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
        ));
  }

  Widget _dataTemuan(Data data, context) {
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
                        child: Text(controller.perusahaan),
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

  Widget _deskBahaya(Data data, context) {
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
                      // bool status = await Constants().goTo(
                      //     () => RubahBahaya(
                      //           data: data,
                      //           tipe: "bahaya",
                      //         ),
                      //     context);
                      // if (status) {
                      //   _reload();
                      // } else {
                      //   // Navigator.pop(context, false);
                      // }
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

  Widget _rkemSebelum(Data data, context) {
    var kmSebelum = controller.kmSebelum.value;
    return Column(children: [
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    // controller.ubahKemungkinan("kemungkinan_sebelum");
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
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${kmSebelum.kemungkinan}"),
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
                                    child: Text("${kmSebelum.nilai}"),
                                  ),
                                ],
                              ),
                            )
                          ])))))
    ]);
  }

  Widget _rkepSebelum(Data data, context) {
    var kpSebelum = controller.kpSebelum.value;
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
                      // ubahKeparahan("keparahan_sebelum");
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${kpSebelum.keparahan}"),
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
                              child: Text("${kpSebelum.nilai}"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget _totalResiko(Data data, context) {
    var resikoSebelum = controller.resikoSebelum.value;
    var txtColor = int.parse("0xffffffff");
    var bgColor = int.parse("0xffffffff");
    if (resikoSebelum.txtColor != null && resikoSebelum.bgColor != null) {
      txtColor = int.parse("0xff" + resikoSebelum.txtColor!.split("#")[1]);
      bgColor = int.parse("0xff" + resikoSebelum.bgColor!.split("#")[1]);
    }

    return Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10,
          color: Color(bgColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${resikoSebelum.kodeBahaya}",
                  style: TextStyle(
                      color: Color(txtColor), fontWeight: FontWeight.bold),
                ),
                Text(
                  "${resikoSebelum.kategori}",
                  style: TextStyle(
                      color: Color(txtColor), fontWeight: FontWeight.bold),
                ),
                Text(
                  "${resikoSebelum.min} - ${resikoSebelum.max}",
                  style: TextStyle(
                      color: Color(txtColor), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _katBahaya(Data data, context) {
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
                      // ubahKategoriBahaya();
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

  Widget metodePengendalian(Data data, context) {
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
                          // ubahPengendalian();
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

  Widget _tindakanPerbaikan(Data data, context) {
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
                      // bool status = await Constants().goTo(
                      //     () => RubahBahaya(
                      //           data: data,
                      //           tipe: "tindakan",
                      //         ),
                      //     context);
                      // if (status) {
                      //   if (widget.detail != null) {
                      //     _reload();
                      //   }
                      // } else {
                      //   // Navigator.pop(context, false);
                      // }
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

  Widget _statusPerbaikan(Data data, context) {
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

  Widget _gambarPerbaikan(Data data, context) {
    var urlImg = controller.baseImage + "update/${data.updateBukti}";
    return Card(
        color: Colors.blue,
        elevation: 10,
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // Constants().goTo(
                          //     () => ImageView(image: state.urlImg),
                          //     context);
                        },
                        child: CachedNetworkImage(
                          imageUrl: urlImg,
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
                            // perbaikanPicker();
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
              ))
        ]));
  }

  Widget _rkemSetelah(Data data, context) {
    var kmSesudah = controller.kmSesudah.value;
    return Column(children: [
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    // ubahKemungkinan("kemungkinan_sesudah");
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${kmSesudah.kemungkinan}"),
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text("Nilai"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("${kmSesudah.nilai}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))))
    ]);
  }

  Widget _rKepSesudah(Data data, context) {
    var kpSesudah = controller.kpSesudah.value;
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
                      // ubahKeparahan("keparahan_sesudah");
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${kpSesudah.keparahan}"),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("Nilai"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("${kpSesudah.nilai}"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _totalResikoSesudah(Data data, context) {
    var resikoSesudah = controller.resikoSesudah.value;
    var txtColor = int.parse("0xffffffff");
    var bgColor = int.parse("0xffffffff");

    txtColor = int.parse("0xff" + resikoSesudah.txtColor!.split("#")[1]);
    bgColor = int.parse("0xff" + resikoSesudah.bgColor!.split("#")[1]);
    return Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10,
          color: Color(bgColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${resikoSesudah.kodeBahaya}",
                  style: TextStyle(
                      color: Color(txtColor), fontWeight: FontWeight.bold),
                ),
                Text(
                  "${resikoSesudah.kategori}",
                  style: TextStyle(
                      color: Color(txtColor), fontWeight: FontWeight.bold),
                ),
                Text(
                  "${resikoSesudah.min} - ${resikoSesudah.max}",
                  style: TextStyle(
                      color: Color(txtColor), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _penanggungJawab(Data data, context) {
    var urlImg = controller.baseImage + "penanggung_jawab/${data.fotoPJ}";
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
                      child: CachedNetworkImage(
                        imageUrl: urlImg,
                        fit: BoxFit.cover,
                        placeholder: (contex, url) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )),
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

  pickerBtmSheet(context) {
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
                                // var img = await getImageCamera();
                                // if (img != null) {
                                //   Navigator.pop(context, img);
                                // }
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
                                // var img = await getImageGallery();
                                // if (img != null) {
                                //   Navigator.pop(context, img);
                                // }
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
}
