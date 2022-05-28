import 'package:flutter/material.dart';

class TipeUnit extends StatefulWidget {
  const TipeUnit({Key? key}) : super(key: key);

  @override
  State<TipeUnit> createState() => _TipeUnitState();
}

class _TipeUnitState extends State<TipeUnit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Unit Yang Di Operasikan"),
      ),
      backgroundColor: Colors.white,
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 15),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Jenis Kendaraan / Alat Berat",
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Tipe Alat",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Kewenangan Mengoperasikan Unit")),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                            value: false,
                            onChanged: (value) {},
                            title: const Text("Full"),
                            controlAffinity: ListTileControlAffinity.leading),
                        CheckboxListTile(
                            value: false,
                            onChanged: (value) {},
                            title: const Text("Restricted"),
                            controlAffinity: ListTileControlAffinity.leading),
                        CheckboxListTile(
                            value: false,
                            onChanged: (value) {},
                            title: const Text("Probation"),
                            controlAffinity: ListTileControlAffinity.leading),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Simpan",
              ),
            )
          ],
        ),
      ),
    );
  }
}
