// ignore_for_file: prefer_const_constructors

import 'package:face_id_plus/abp_energy/sarpras/screen/form_sapras.dart';
import 'package:flutter/material.dart';

class SaranaPrasana extends StatefulWidget {
  const SaranaPrasana({Key? key}) : super(key: key);

  @override
  State<SaranaPrasana> createState() => _SaranaPrasanaState();
}

class _SaranaPrasanaState extends State<SaranaPrasana> {
  Color color = const Color.fromARGB(255, 32, 72, 142);
  TextStyle style = const TextStyle(
      fontWeight: FontWeight.bold, color: Color.fromARGB(255, 91, 90, 90));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text("Keluar Masuk Sarana"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const FormSapras(),
                  ),
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: listSapras(),
      ),
    );
  }

  Widget listSapras() {
    return ListView(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 20,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 32, 72, 142),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Pemohon: HENDRA",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("No.", style: style),
                        ),
                        SizedBox(width: 50),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("5"),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Sarana", style: style),
                        ),
                        SizedBox(width: 30),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("LV 010"),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Driver", style: style),
                      ),
                      SizedBox(width: 37),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("HENDRA"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Penumpang", style: style),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "- (22020323) HENDRA\n- (22020323) HENDRA\n- (22020323) HENDRA"),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Keperluan", style: style),
                      ),
                      const SizedBox(width: 11),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                            Text("MES JELAWAT PENGAMPARAN BATU\nPARKIRAN LV"),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 230,
                    height: 30,
                    child: Card(
                      elevation: 20,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          "Disetujui | 08:51:16 28 Mei 2022",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 180,
                    height: 30,
                    child: Card(
                      elevation: 20,
                      color: Color.fromARGB(255, 61, 59, 59),
                      child: Center(
                        child: Text(
                          "Disetujui oleh Zulkarnaen",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
