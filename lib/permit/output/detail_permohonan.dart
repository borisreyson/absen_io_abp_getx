import 'package:face_id_plus/permit/form/tipe_unit.dart';
import 'package:face_id_plus/permit/output/lampiran_detail.dart';
import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class DetailPermohonan extends StatefulWidget {
  const DetailPermohonan({Key? key}) : super(key: key);

  @override
  State<DetailPermohonan> createState() => _DetailPermohonanState();
}

class _DetailPermohonanState extends State<DetailPermohonan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Permohonan"),
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
          children: [
            _permitStatus(),
            _dataPribadi(),
            _tipePermit(),
            _peralatan(),
            _tombolLampiran(context)
          ],
        ),
      ),
    );
  }

  Widget _permitStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          padding: const EdgeInsets.all(10),
          child: const Text("I. Permit Status",
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ListTile(
                  title: Text(
                    "Baru",
                  ),
                  leading: Icon(
                    Icons.check_box_outlined,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dataPribadi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: Colors.green,
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "II. Data Pribadi",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: "Boris Reyson Sitorus",
                  decoration: const InputDecoration(
                    labelText: "Nama",
                  ),
                ),
                TextFormField(
                  initialValue: "18060207s",
                  decoration: const InputDecoration(
                    labelText: "Nik",
                  ),
                ),
                TextFormField(
                  initialValue: "27 Tahun",
                  decoration: const InputDecoration(
                    labelText: "Umur",
                  ),
                ),
                TextFormField(
                  initialValue: "IT",
                  decoration: const InputDecoration(
                    labelText: "Jabatan",
                  ),
                ),
                TextFormField(
                  initialValue: "PT Alamjaya Bara Pratama",
                  decoration: const InputDecoration(
                    labelText: "Perusahaan",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _tipePermit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "III. Permit Tipe",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
            ),
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
        Container(
          color: Colors.green,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "IV. Peralatan Yang Direkomendasikan",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Constants().goTo(() => const TipeUnit(), context);
                },
                child: const Text("Tambah"),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.all(10),
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
                      leading: Icon(
                        Icons.check_box_outlined,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )),
          ]),
        ),
      ],
    );
  }

  Widget _tombolLampiran(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Constants().goTo(
                () => const LampiranDetail(
                  "baru",
                ),
                context,
              );
            },
            child: const Text(
              "Lampiran",
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     Constants().goTo(
          //       () => Lampiran(
          //         "baru",
          //       ),
          //       context,
          //     );
          //   },
          //   child: const Text(
          //     "Baru",
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     Constants().goTo(
          //       () => Lampiran(
          //         "perpanjangan",
          //       ),
          //       context,
          //     );
          //   },
          //   child: const Text(
          //     "Perpanjangan",
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     Constants().goTo(
          //       () => Lampiran(
          //         "status",
          //       ),
          //       context,
          //     );
          //   },
          //   child: const Text(
          //     "Status",
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     Constants().goTo(
          //       () => Lampiran(
          //         "kehilangan",
          //       ),
          //       context,
          //     );
          //   },
          //   child: const Text(
          //     "Kehilangan",
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     Constants().goTo(
          //       () => Lampiran(
          //         "sementara",
          //       ),
          //       context,
          //     );
          //   },
          //   child: const Text(
          //     "Sementara",
          //   ),
          // ),
        ],
      ),
    );
  }
}
