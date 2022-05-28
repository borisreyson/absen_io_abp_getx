import 'package:face_id_plus/permit/form/lampiran.dart';
import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class FormPerubahan extends StatefulWidget {
  final String status;
  const FormPerubahan(this.status, {Key? key}) : super(key: key);

  @override
  State<FormPerubahan> createState() => _FormPerubahanState();
}

class _FormPerubahanState extends State<FormPerubahan> {
  late String _status;
  @override
  void initState() {
    _status = widget.status;
    super.initState();
  }

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
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const Text("I. Permit Status"),
            ListTile(
              title: Text(
                _status,
              ),
              leading: const Icon(
                Icons.check_box_outlined,
                color: Colors.green,
              ),
            ),
            _dataPribadi(),
            const SizedBox(
              height: 20,
            ),
            _tipePermit(),
            _peralatan(),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Constants().goTo(
                      () => const Lampiran(
                        "baru",
                      ),
                      context,
                    );
                  },
                  child: const Text(
                    "Baru",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Constants().goTo(
                      () => const Lampiran(
                        "perpanjangan",
                      ),
                      context,
                    );
                  },
                  child: const Text(
                    "Perpanjangan",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Constants().goTo(
                      () => const Lampiran(
                        "status",
                      ),
                      context,
                    );
                  },
                  child: const Text(
                    "Status",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Constants().goTo(
                      () => const Lampiran(
                        "kehilangan",
                      ),
                      context,
                    );
                  },
                  child: const Text(
                    "Kehilangan",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Constants().goTo(
                      () => const Lampiran(
                        "sementara",
                      ),
                      context,
                    );
                  },
                  child: const Text(
                    "Sementara",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column _dataPribadi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("II. Data Pribadi"),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Nama",
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Nik",
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Umur",
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Jabatan",
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Perusahaan",
          ),
        ),
      ],
    );
  }

  Column _tipePermit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("III. Permit Tipe"),
        ListTile(
          title: Text(
            "Mine Permit",
          ),
          leading: Icon(
            Icons.check_box_outlined,
            color: Colors.green,
          ),
        ),
        ListTile(
          title: Text(
            "Simper",
          ),
          leading: Icon(
            Icons.check_box_outlined,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _peralatan() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("IV. Peralatan Yang Direkomendasikan"),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Tambah"),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          elevation: 10,
          child: Column(children: [
            const ListTile(
              title: Text("Jenis Kendaraan / Alat Berat"),
              subtitle: Text("Leight Vehicle"),
            ),
            const ListTile(
              title: Text("Tipe Alat"),
              subtitle: Text("Double Cabin"),
            ),
            ListTile(
                title: const Text("Kewenangan Mengoperasikan Unit"),
                subtitle: Column(
                  children: const [
                    ListTile(
                      title: Text("Full"),
                      leading: Icon(Icons.check_box_outlined),
                    ),
                    ListTile(
                      title: Text("Restricted"),
                      leading: Icon(Icons.check_box_outline_blank_sharp),
                    ),
                    ListTile(
                      title: Text("Probation"),
                      leading: Icon(Icons.check_box_outline_blank_sharp),
                    ),
                  ],
                )),
          ]),
        ),
      ],
    );
  }
}
