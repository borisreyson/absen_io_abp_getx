import 'dart:async';
import 'dart:convert';
import 'package:face_id_plus/screens/pages/master/add_karyawan.dart';
import 'package:face_id_plus/screens/pages/master/show_karyawan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import '../../../model/karyawan_model.dart';

class ListKaryawan extends StatefulWidget {
  const ListKaryawan({Key? key}) : super(key: key);

  @override
  State<ListKaryawan> createState() => _ListKaryawanState();
}

class _ListKaryawanState extends State<ListKaryawan> {
  bool _folded = true;
  var loading = false;
  late FocusNode focusNode;
  List<DataKaryawan> employee = [];
  List<DataKaryawan> cariEmployee = [];
  TextEditingController cariController = new TextEditingController();

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
    getKaryawan().then((value) {
      setState(() {
        employee = value;
        cariEmployee = employee;
      });
    });
  }

  @override
  void dispose() {
    employee.clear();
    cariEmployee.clear();
    super.dispose();
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
          actions: [_cari()],
          title: const Text(
            "List Karyawan",
            style: TextStyle(color: Colors.black),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => FormKaryawan())));
          },
          tooltip: 'Tambah Karyawan',
          child: Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : _content())
          ],
        ));
  }

  Widget _content() {
    return ListView.builder(
      itemCount: cariEmployee.length,
      itemBuilder: (context, i) {
        DataKaryawan c = cariEmployee[i];
        String? foto;
        if (c.photo_profile != null) {
          foto = c.photo_profile;
        } else {
          foto = null;
        }
        return (c.nama_perusahaan == "PT Alamjaya Bara Pratama")
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => FormKaryawan())));
                        },
                        child: SizedBox(
                          height: 120,
                          width: 100,
                          child: Card(
                            elevation: 10,
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                Text("UBAH",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return dialog();
                              });
                        },
                        child: SizedBox(
                          height: 120,
                          width: 100,
                          child: Card(
                            elevation: 10,
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                Text("Hapus",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: (c.status == 0) ? Colors.green : Colors.red,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ShowKaryawan(
                                        dataKaryawan: cariEmployee[i],
                                      ))));
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: (foto != null)
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(foto,
                                                fit: BoxFit.fill),
                                          )
                                        : Center(
                                            child: Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.grey,
                                          ))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c.nama_lengkap!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  Text(c.nik!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  Text(c.dept!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  Text(c.section!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ))
            : Container();
      },
    );
  }

  Widget _cari() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _folded ? 56 : 350,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        //boxShadow: kElevationToShadow[1],
      ),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 16),
            child: !_folded
                ? TextField(
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: 'Cari Karyawan',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    controller: cariController,
                    onChanged: (string) {
                      setState(() {
                        cariEmployee = employee
                            .where((e) =>
                                (e.nama_lengkap!.toLowerCase())
                                    .contains(string.toLowerCase()) ||
                                e.nik!
                                    .toLowerCase()
                                    .contains(string.toLowerCase()))
                            .toList();
                      });
                    },
                  )
                : null,
          )),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_folded ? 32 : 0),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(_folded ? 32 : 0),
                  bottomRight: Radius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    _folded ? Icons.search : Icons.close,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;
                    focusNode.requestFocus();
                    cariController.clear();
                    cariEmployee = employee;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget dialog() {
    return AlertDialog(
      title: Text("Konfirmasi"),
      content: Text("Yakin ingin Menghapus data ini?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Hapus")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Batal"))
      ],
    );
  }

  onSearch(String text) {
    cariEmployee.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    employee.forEach((e) {
      if (e.nama_lengkap!.toLowerCase().contains(text.toLowerCase()))
        cariEmployee.add(e);
    });
    setState(() {});
  }

  Future<List<DataKaryawan>> getKaryawan() async {
    setState(() {
      loading = true;
    });
    const url = "https://abpjobsite.com/android/api/list/users/all";
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    var jsonArray = jsonData['UsersList'];

    for (var object in jsonArray) {
      DataKaryawan karyawan = DataKaryawan(
        id_user: object["id_user"],
        username: object["username"],
        nama_lengkap: object["nama_lengkap"],
        email: object["email"],
        department: object["department"],
        section: object["section"],
        level: object["level"],
        status: object["status"],
        rule: object["rule"],
        tglEntry: object["tglEntry"],
        nik: object["nik"],
        photo_profile: object["photo_profile"],
        dept: object["dept"],
        sect: object["sect"],
        nama_perusahaan: object["nama_perusahaan"],
      );
      employee.add(karyawan);
      loading = false;
    }
    return employee;
  }
}
