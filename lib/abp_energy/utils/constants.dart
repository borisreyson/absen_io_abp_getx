// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String ISLOGIN = "isLoginAbp";
  static const String USERNAME = "userName";
  static const String NIK = "nik";
  static const String NAME = "name";
  static const String RULE = "rule";
  static const String fotoProfile = "fotoProfile";
  static const String BASEURL = "https://lp.abpjobsite.com/";
  static const String kemungkinanTb = "KEMUNGKINAN";
  static const String keparahanTb = "KEPARAHAN";
  static const String metrikTb = "METRIK";
  static const String perusahaanTb = "PERUSAHAAN";
  static const String lokasiTb = "LOKASI";
  static const String detKeparahanTb = "DETAIL_KEPARAHAN";
  static const String pengendalianTb = "PENGENDALIAN";
  static const String detPengendalianTb = "DETAIL_PENGENDALIAN";
  static const String usersTb = "USERS";
  static const Color green = Color(0xFF488C03);

  // ignore: non_constant_identifier_names
  sign_out(context) async {
    var pref = await SharedPreferences.getInstance();
    var logOut = await pref.remove(Constants.ISLOGIN);
    var profile = await pref.remove(Constants.fotoProfile);
    if (logOut && profile) {
      return true;
    } else {
      return false;
    }
  }

  goTo(Function() toPage, BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => toPage()));
  }

  goToReplace(Function() toPage, BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => toPage()));
  }

  showMyDialog(BuildContext context, String judul) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(judul),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah Anda Yakin?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ya , Keluar'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  showAlert(
    BuildContext context, {
    String? judul,
    String? msg,
    bool enBtn = true,
    bool loading = false,
    bool dismiss = false,
    bool del = false,
    Color? color,
    String? fBtn,
    String? sBtn,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: dismiss, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: (color != null) ? color : null,
          title: (judul != null) ? Text(judul) : null,
          content: (loading)
              ? const CupertinoActivityIndicator(
                  radius: 40,
                )
              : (msg != null)
                  ? SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(msg),
                        ],
                      ),
                    )
                  : null,
          actions: (enBtn)
              ? <Widget>[
                  (del)
                      ? TextButton(
                          child: Text("$fBtn"),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                        )
                      : TextButton(
                          child: const Text('OK!'),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                  (del)
                      ? TextButton(
                          child: Text("$sBtn"),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        )
                      : Container()
                ]
              : null,
        );
      },
    );
  }

  showFormAlert(
    BuildContext context, {
    String? judul,
    bool enBtn = true,
    bool dismiss = false,
    Color? color,
    String? fBtn,
    String? sBtn,
    String? label = "Data",
    bool validate = true,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: dismiss, // user must tap button!
      builder: (BuildContext context) {
        return CustomDialog(judul, dismiss, fBtn, sBtn, label, validate);
      },
    );
  }
}

// ignore: must_be_immutable
class CustomDialog extends StatefulWidget {
  String? judul;
  bool enBtn = true;
  bool dismiss = false;
  Color? color;
  String? fBtn;
  String? sBtn;
  String? label = "Data";
  bool validate = true;
  CustomDialog(
      this.judul, this.dismiss, this.fBtn, this.sBtn, this.label, this.validate,
      {Key? key})
      : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final _formKey = GlobalKey<FormState>();
  final Color _warna = const Color(0xFF591505);
  final _formFocus = FocusNode();
  final _formController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${widget.judul}"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: ListBody(
              children: [
                TextFormField(
                  controller: _formController,
                  maxLines: 5,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _warna)),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _warna)),
                    labelStyle: TextStyle(color: _warna),
                    alignLabelWithHint: true,
                    labelText: "${widget.label}",
                    hintText: "${widget.label}",
                  ),
                  focusNode: _formFocus,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '${widget.label} Wajib Di Isi';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, [true, _formController.text]);
            } else {
              _formFocus.requestFocus();
            }
          },
          child: Text("${widget.fBtn}"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, [false]);
          },
          child: Text("${widget.sBtn}"),
        ),
      ],
    );
  }
}
