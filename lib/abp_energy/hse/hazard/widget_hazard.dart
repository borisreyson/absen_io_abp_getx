import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/form/status_perbaikan.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/hazard_detail.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/rubah_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_model.dart';
import 'package:face_id_plus/abp_energy/hse/provider/provider.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class WidgetHazard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  final String? _rule;
  final String username;
  final String? option;
  final int? disetujui;
  final Function onRefresh;
  const WidgetHazard(this.data, this._rule, this.onRefresh,
      {required this.username, this.option, this.disetujui, Key? key})
      : super(key: key);

  @override
  State<WidgetHazard> createState() => _WidgetHazardState();
}

class _WidgetHazardState extends State<WidgetHazard> {
  final Color _success = Colors.green.shade700;
  final Color _danger = Colors.red.shade700;

  final TextStyle _colorText = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    var fmt = DateFormat("dd MMMM yyyy");
    String? __status;
    if (widget.data.userValid == null) {
      __status = "Belum Disetujui";
    } else if (widget.data.userValid != null &&
        (widget.data.optionFlag == 1 || widget.data.optionFlag == null)) {
      __status = "Disetujui";
    } else if (widget.data.optionFlag == 0) {
      __status = "Dibatalkan";
    }

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: InkWell(
          onTap: () {
            Constants().goTo(() => HazardDetail(detail: widget.data), context);
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: (widget.data.statusPerbaikan != "SELESAI")
                    ? _danger
                    : _success,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${widget.data.jamHazard}",
                      style: _colorText,
                    ),
                    Text(fmt.format(DateTime.parse(widget.data.tglHazard!)),
                        style: _colorText)
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text("Perusahaan"),
                        Text("${widget.data.perusahaan}"),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Lokasi"),
                        Text("${widget.data.lokasiHazard}"),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: (widget.data.statusPerbaikan != "SELESAI")
                    ? _danger
                    : _success,
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  "Deskripsi",
                  style: _colorText,
                )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Center(child: Text("${widget.data.deskripsi}")),
              ),
              Container(
                color: (widget.data.statusPerbaikan != "SELESAI")
                    ? _danger
                    : _success,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  "${widget.data.statusPerbaikan}",
                  style: _colorText,
                )),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Dibuat",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${widget.data.namaLengkap}"),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Penanggung Jawab",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${widget.data.namaPJ}"),
                  ],
                ),
              ),
              Container(
                color: (__status == "Disetujui") ? _success : _danger,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  "$__status",
                  style: _colorText,
                )),
              ),
              Visibility(
                visible: (widget.data.keteranganAdmin != null)
                    ? (__status == "Dibatalkan")
                        ? true
                        : false
                    : false,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    "${widget.data.keteranganAdmin}",
                  )),
                ),
              ),
              aksiBtn(__status, context),
            ],
          ),
        ));
  }

  Widget aksiBtn(String? __status, context) {
    return Visibility(
      visible: (widget._rule != null) ? true : false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //Persetujuan
          Visibility(
            visible: (widget._rule!.contains("admin_hse"))
                ? (__status == "Disetujui" || __status == "Dibatalkan")
                    ? false
                    : (widget.option == "all")
                        ? true
                        : false
                : false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      bool alert = await Constants().showAlert(
                        context,
                        judul: "Setujui Hazard",
                        del: true,
                        msg: "Apakah anda yakin?",
                        fBtn: "Ya, Setujui",
                        sBtn: "Batal",
                      );
                      if (alert) {
                        Constants().showAlert(context,
                            dismiss: false, loading: true, enBtn: false);
                        var verify = HazardVerify();
                        verify.uid = widget.data.uid;
                        verify.keterangan = "";
                        verify.username = widget.username;
                        verify.option = 1;
                        await HazardProvider()
                            .verifyHazard(verify)
                            .then((res) async {
                          if (res != null) {
                            if (res.success!) {
                              await widget.onRefresh(s: true);
                              Navigator.pop(context);
                            }
                          }
                        });
                      }
                    },
                    child: const Text("Setujui"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade700)),
                ElevatedButton(
                    onPressed: () async {
                      var alert = await Constants().showFormAlert(
                        context,
                        judul: "Keterangan Pembatalan",
                        label: "Keterangan Pembatalan",
                        fBtn: "Ya, Batalkan",
                        sBtn: "Batal",
                      );
                      if (alert[0]) {
                        Constants().showAlert(context,
                            dismiss: false, loading: true, enBtn: false);
                        var verify = HazardVerify();
                        verify.keterangan = alert[1];
                        verify.uid = widget.data.uid;
                        verify.username = widget.username;
                        verify.option = 0;
                        await HazardProvider()
                            .verifyHazard(verify)
                            .then((res) async {
                          if (res != null) {
                            if (res.success!) {
                              await widget.onRefresh(s: true);
                              Navigator.pop(context);
                            }
                          }
                        });
                      }
                    },
                    child: const Text("Batalkan"),
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent)),
              ],
            ),
          ),
          //Administrator
          Visibility(
            visible: (!widget._rule!.contains("administrator"))
                ? false
                : (widget.option == "all")
                    ? true
                    : false,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                onPressed: () async {
                  bool alert = await Constants().showAlert(context,
                      judul: "Hapus Hazard Report",
                      del: true,
                      msg: "Apakah anda yakin?",
                      fBtn: "Ya, Hapus",
                      sBtn: "Tidak");
                  if (alert) {
                    Constants().showAlert(context,
                        dismiss: false, loading: true, enBtn: false);

                    await HazardProvider()
                        .deleteHazard(widget.data.uid)
                        .then((res) {
                      if (res != null) {
                        if (res.success) {
                          Navigator.pop(context, "suceess");
                          widget.onRefresh(s: true);
                        } else {
                          Navigator.pop(context);
                          Constants().showAlert(context,
                              judul: "Error",
                              enBtn: true,
                              msg: "Gagal Menghapus!");
                        }
                      } else {
                        Navigator.pop(context);
                        Constants().showAlert(context,
                            judul: "Error",
                            enBtn: true,
                            msg: "Gagal Menghapus!");
                      }
                    });
                  }
                },
                child: const Text("Hapus")),
          ),

          Row(
            mainAxisAlignment: (widget.data.statusPerbaikan != "SELESAI")
                ? (widget.disetujui != 2)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceAround
                : MainAxisAlignment.center,
            children: [
              //User
              Visibility(
                visible: (widget.option == "all")
                    ? false
                    : (widget.disetujui == 2)
                        ? true
                        : false,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    onPressed: () async {
                      bool alert = await Constants().showAlert(context,
                          judul: "Rubah Hazard Report",
                          del: true,
                          msg: "Apakah anda yakin?",
                          fBtn: "Ya, Rubah",
                          sBtn: "Tidak");
                      if (alert) {
                        Constants().showAlert(context,
                            dismiss: false, loading: true, enBtn: false);

                        bool stat = await Constants().goTo(
                            () => RubahHazard(
                                  detail: widget.data,
                                ),
                            context);
                        if (stat) {
                          Navigator.pop(context, stat);
                          widget.onRefresh(s: stat);
                        } else {
                          Navigator.pop(context, stat);
                        }
                      }
                    },
                    child: const Text("Rubah")),
              ),
              (widget.option == "all")
                  ? Visibility(
                      visible: false,
                      child: Container(),
                    )
                  : (widget.data.statusPerbaikan != "SELESAI")
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 68, 59, 162)),
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
                                        detail: widget.data,
                                      ),
                                  context);
                              if (stat) {
                                Navigator.pop(context, stat);
                                widget.onRefresh(s: true);
                              } else {
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: const Text("Update Hazard"))
                      : Visibility(
                          visible: false,
                          child: Container(),
                        ),
            ],
          ),

          //Jarak
          Visibility(
              visible: (widget.option != "all"),
              child: const SizedBox(
                height: 20,
              ))
        ],
      ),
    );
  }
}
