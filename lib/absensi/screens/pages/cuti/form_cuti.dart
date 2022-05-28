import 'package:flutter/material.dart';

class FormCuti extends StatefulWidget {
  const FormCuti({Key? key}) : super(key: key);

  @override
  State<FormCuti> createState() => _FormCutiState();
}

class _FormCutiState extends State<FormCuti> {
  String? _cuti;

  List<String> itemCuti = [
    '--Pilih Cuti--',
    'Cuti Umum',
    'Cuti Tahunan',
    'Cuti Melahirkan',
  ];

  final TextEditingController _daritgl = TextEditingController();
  final TextEditingController _sampaitgl = TextEditingController();
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
          "Form Cuti",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(children: [
        Container(color: Colors.white, child: form()),
      ]),
    );
  }

  Widget form() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Nama",
                    hintText: "Masukkan Nama"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "NIK",
                    hintText: "Masukkan NIK"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 160,
                child: DropdownButtonFormField<String>(
                    value: _cuti,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: "Jenis Cuti",
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                    items: itemCuti.map<DropdownMenuItem<String>>((String a) {
                      return DropdownMenuItem<String>(
                        value: a,
                        child: Text(a),
                      );
                    }).toList(),
                    hint: const Text("--Pilih Cuti--"),
                    onChanged: (String? b) {
                      setState(() {
                        _cuti = b;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                            controller: _daritgl,
                            onTap: () async {
                              DateTime? date;
                              FocusScope.of(context).requestFocus(FocusNode());
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));

                              var _daritanggal =
                                  "${date!.day}-${date.month}-${date.year}";
                              _daritgl.text = _daritanggal;
                            },
                            readOnly: true,
                            // ignore: deprecated_member_use
                            cursorColor: Theme.of(context).cursorColor,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 10,
                                  )),
                              labelText: "Dari Tanggal",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.green,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Tanggal Tidak Boleh Kosong";
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                            controller: _sampaitgl,
                            onTap: () async {
                              DateTime? dateTo;
                              FocusScope.of(context).requestFocus(FocusNode());
                              dateTo = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));

                              var _sampaitanggal =
                                  "${dateTo!.day}-${dateTo.month}-${dateTo.year}";
                              _sampaitgl.text = _sampaitanggal;
                            },
                            readOnly: true,
                            // ignore: deprecated_member_use
                            cursorColor: Theme.of(context).cursorColor,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 10,
                                  )),
                              labelText: "Sampai Tanggal",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.green,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Tanggal Tidak Boleh Kosong";
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  // ignore: deprecated_member_use
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 10,
                        ),
                      ),
                      labelText: "Alasan Cuti",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: Colors.white,
                      hintText: "Masukkan Alasan Cuti"),
                  //controller: _kontenBuletin,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Konten Tidak Boleh Kosong";
                    }
                    return null;
                  }),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 19, right: 19, top: 5),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      //var form = _formKey.currentState;
                      // if (form!.validate()) {
                      //   if (widget.listBuletin == null) {
                      //     addBuletin();
                      //     setState(() {});
                      //   } else {
                      //     ubahBuletin(id_info!);
                      //     setState(() {});
                      //   }
                      // }
                    },
                    child: const Text(
                      "AJUKAN CUTI",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
}
