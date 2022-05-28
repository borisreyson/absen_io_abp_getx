import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

import 'form_perubahan.dart';

class FormPermohonanPerubahan extends StatefulWidget {
  const FormPermohonanPerubahan({Key? key}) : super(key: key);

  @override
  State<FormPermohonanPerubahan> createState() =>
      _FormPermohonanPerubahanState();
}

class _FormPermohonanPerubahanState extends State<FormPermohonanPerubahan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perubahan Permit"),
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.all(30),
            elevation: 10,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                Constants()
                    .goTo(() => const FormPerubahan("Perpanjangan"), context);
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.edit_rounded,
                      color: Colors.blue,
                      size: 60,
                    ),
                    Text(
                      "Perpanjangan Permit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ]),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.all(30),
            elevation: 10,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                Constants().goTo(
                    () => const FormPerubahan("Perubahan Status"), context);
              },
              child: const ListTile(
                  title: Icon(
                    Icons.edit_rounded,
                    color: Colors.blue,
                    size: 60,
                  ),
                  subtitle: Text(
                    "Perubahan Status Permit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.all(30),
            elevation: 10,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                Constants()
                    .goTo(() => const FormPerubahan("Kehilangan"), context);
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.edit_rounded,
                      color: Colors.blue,
                      size: 60,
                    ),
                    Text(
                      "Pergantian Permit Hilang",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
