import 'dart:io';
import 'dart:ui';
import 'package:face_id_plus/absensi/model/face_login_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? isLogin = 0;
  late String nama;
  late String nik;
  late int _showAbsen;
  XFile? _foto;

  var imagePicker = ImagePicker();
  Future getImageGallery() async {
    var imageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    setState(() {
      _foto = imageFile;
    });
  }

  Future getImageCamera() async {
    var imageFile = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _foto = imageFile;
    });
  }

  @override
  void initState() {
    _getPref();
    nik = "";
    _showAbsen = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          leading: InkWell(
            splashColor: const Color(0xff000000),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff000000),
            ),
            onTap: () {
              Navigator.maybePop(context);
            },
          ),
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: _topContent());
  }

  Widget _topContent() {
    return FutureBuilder(
        future: _getPref(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              Datalogin fUsers = Datalogin();
              fUsers = snapshot.data;
              nik = fUsers.nik!;
              _showAbsen = fUsers.showAbsen!;
              return Stack(
                children: [
                  Container(
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Card(
                        margin: EdgeInsets.only(top: 100),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 90.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text("${fUsers.nama}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.format_list_numbered),
                                    title: Text("${fUsers.nik}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(Icons.business_center_rounded),
                                    title: Text("${fUsers.devisi}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      margin: EdgeInsets.only(top: 40),
                      elevation: 18,
                      shape: CircleBorder(),
                      child: Container(
                        width: 179,
                        height: 179,
                        child: Center(
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Pilih Foto"),
                                        actions: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 210),
                                                child: TextButton(
                                                    onPressed: () {
                                                      getImageCamera();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Kamera",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 16))),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 222),
                                                child: TextButton(
                                                    onPressed: () {
                                                      getImageGallery();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Galeri",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 16))),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: (_foto == null)
                                  ? Icon(Icons.add_a_photo, size: 50)
                                  : Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: Image.file(
                                            File(_foto!.path),
                                            fit: BoxFit.fill,
                                            width: 200,
                                            height: 200,
                                          )),
                                    )),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        });
  }

  Future<Datalogin> _getPref() async {
    Datalogin _users = Datalogin();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    nama = _pref.getString("nama").toString();
    String nik = _pref.getString("nik").toString();
    String devisi = _pref.getString("devisi").toString();
    String dept = _pref.getString("departemen").toString();
    int? _showAbsen = _pref.getInt("show_absen");
    _users.nama = nama;
    _users.nik = nik;
    _users.devisi = devisi;
    print("showAbsen $_showAbsen");

    _users.showAbsen = (_showAbsen == null) ? 0 : _showAbsen;

    return _users;
  }
}
