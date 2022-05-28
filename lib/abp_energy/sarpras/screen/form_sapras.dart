import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormSapras extends StatefulWidget {
  const FormSapras({Key? key}) : super(key: key);

  @override
  State<FormSapras> createState() => _FormSaprasState();
}

class _FormSaprasState extends State<FormSapras> {
  String? _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Izin Sarana"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: formSarana(),
    );
  }

  Widget formSarana() {
    return ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Sarana",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 230,
                    height: 80,
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    padding: const EdgeInsets.all(10),
                    child: DropdownButton<String>(
                        value: _status,
                        style: const TextStyle(color: Colors.black),
                        items: <String>['LV (006)', 'B', 'C', 'D']
                            .map<DropdownMenuItem<String>>((String a) {
                          return DropdownMenuItem<String>(
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        hint: const Text("--Pilih Status--"),
                        onChanged: (String? b) {
                          setState(() {
                            _status = b;
                          });
                        }),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 10,
                          )),
                      labelText: "Driver",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: Colors.green,
                      hintText: 'Masukkan Driver'),
                  // controller: akun,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Driver Tidak Boleh Kosong";
                    }
                    return null;
                  }),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 10,
                          )),
                      labelText: "Penumpang",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: Colors.green,
                      hintText: 'Masukkan Penumpang'),
                  // controller: akun,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Penumpang Tidak Boleh Kosong";
                    }
                    return null;
                  }),
            ),
            formKeluar(),
            formKembali(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: TextFormField(
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 10,
                          ),
                        ),
                        labelText: "Keperluan",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Colors.white,
                        hintText: "Masukkan Keperluan"),
                    // controller: _tindakan,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Keperluan Tidak Boleh Kosong";
                      }
                      return null;
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('SIMPAN'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {},
                      child: const Text('BATAL'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget formKeluar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 10,
                        )),
                    labelText: "Tanggal Keluar",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.green,
                    hintText: 'Masukkan Tanggal'),
                // controller: dariTgl,
                onTap: () async {
                  DateTime? date;
                  FocusScope.of(context).requestFocus(FocusNode());
                  date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));

                  var _tanggal = "${date!.day}-${date.month}-${date.year}";
                  // dariTgl.text = _tanggal;
                },
                readOnly: true,
              ),
            ),
          ),
          const Text("-"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 10,
                        )),
                    labelText: "Jam Keluar",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.green,
                    hintText: 'Masukkan Jam'),
                // controller: btsJam,
                onTap: () async {
                  TimeOfDay? pickedTime;
                  pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    print(pickedTime.format(context));
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());
                    String formattedTime =
                        DateFormat('HH:mm a').format(parsedTime);
                    setState(() {
                      // btsJam.text = formattedTime;
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
                readOnly: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget formKembali() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 10,
                        )),
                    labelText: "Tanggal Kembali",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.green,
                    hintText: 'Masukkan Tanggal'),
                // controller: dariTgl,
                onTap: () async {
                  DateTime? date;
                  FocusScope.of(context).requestFocus(FocusNode());
                  date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));

                  var _tanggal = "${date!.day}-${date.month}-${date.year}";
                  // dariTgl.text = _tanggal;
                },
                readOnly: true,
              ),
            ),
          ),
          const Text("-"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 10,
                        )),
                    labelText: "Jam Kembali",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.green,
                    hintText: 'Masukkan Jam'),
                // controller: btsJam,
                onTap: () async {
                  TimeOfDay? pickedTime;
                  pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (pickedTime != null) {
                    print(pickedTime.format(context));
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());
                    String formattedTime =
                        DateFormat('HH:mm a').format(parsedTime);
                    setState(() {
                      // btsJam.text = formattedTime;
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
                readOnly: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
