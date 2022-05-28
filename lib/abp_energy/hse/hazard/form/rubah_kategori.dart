import 'package:flutter/material.dart';

class RubahKategori extends StatefulWidget {
  const RubahKategori({Key? key}) : super(key: key);

  @override
  State<RubahKategori> createState() => _RubahKategoriState();
}

class _RubahKategoriState extends State<RubahKategori> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Bahaya"),
      ),
      body: ListView(
        children: [
          Card(
            elevation: 10,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context, "KONDISI TIDAK AMAN");
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text("KONDISI TIDAK AMAN"),
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context, "TINDAKAN TIDAK AMAN");
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text("TINDAKAN TIDAK AMAN"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
