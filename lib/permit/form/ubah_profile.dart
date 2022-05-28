import 'package:flutter/material.dart';

class UbahProfile extends StatefulWidget {
  const UbahProfile({Key? key}) : super(key: key);

  @override
  State<UbahProfile> createState() => _UbahProfileState();
}

class _UbahProfileState extends State<UbahProfile> {
  final Color _warna = const Color.fromARGB(255, 2, 113, 98);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _warna,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("Ubah Profil"),
      ),
      body: Form(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                  border: const OutlineInputBorder(),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                  labelStyle: TextStyle(color: _warna),
                  label: const Text("Nama"),
                ),
              ),
              _space(10),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                  border: const OutlineInputBorder(),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                  labelStyle: TextStyle(color: _warna),
                  label: const Text("Umur"),
                ),
              ),
              _space(10),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                  border: const OutlineInputBorder(),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                  labelStyle: TextStyle(color: _warna),
                  label: const Text("Jabatan"),
                ),
              ),
              _space(10),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                  border: const OutlineInputBorder(),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: _warna)),
                  labelStyle: TextStyle(color: _warna),
                  label: const Text("Perusahaan"),
                ),
              ),
              _space(10),
              Card(
                elevation: 10,
                color: _warna,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _space(double height) {
    return SizedBox(
      height: height,
    );
  }
}
