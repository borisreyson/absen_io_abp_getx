import 'package:flutter/material.dart';

class LampiranDetail extends StatefulWidget {
  final String status;
  const LampiranDetail(this.status, {Key? key}) : super(key: key);

  @override
  State<LampiranDetail> createState() => _LampiranDetailState();
}

class _LampiranDetailState extends State<LampiranDetail> {
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
        elevation: 0,
        title: const Text("Lampiran Persyaratan"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(10),
            child: Text(
              _status.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: (_status != "status"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  child: const Text(
                    "Lampiran KTP dan SIMPOL",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      elevation: 10,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                            size: MediaQuery.of(context).size.width / 4,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                            size: MediaQuery.of(context).size.width / 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: (_status == "status" ||
                          _status == "sementara" ||
                          _status == "baru")
                      ? true
                      : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Lampiran Induksi",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Card(
                          elevation: 10,
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: MediaQuery.of(context).size.width / 5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Lampiran Sertifikat Vaksin Covid 19",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Card(
                          elevation: 10,
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.attachment_sharp,
                              size: MediaQuery.of(context).size.width / 5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: (_status != "sementara"),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.blue,
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Lampiran Hasil Rekomendasi MCU",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Card(
                                elevation: 10,
                                child: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.attachment_sharp,
                                    size: MediaQuery.of(context).size.width / 5,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.blue,
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Lampiran Validasi Dokumen Persyaratan",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Card(
                                elevation: 10,
                                child: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.attachment_sharp,
                                    size: MediaQuery.of(context).size.width / 5,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: (_status == "baru" || _status == "status"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Lampiran Hasil Uji Kopetensi Unit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.attachment_sharp,
                        size: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Visibility(
            visible: (_status == "status" || _status == "perpanjangan")
                ? true
                : false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lampiran MINEPERMIT dan SIMPERMIT Sebelumnya",
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.attachment_sharp,
                        size: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: (_status == "status"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Lampiran Surat Keterangan HCGA",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Card(
                          elevation: 10,
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.attachment_sharp,
                              size: MediaQuery.of(context).size.width / 5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: (_status == "kehilangan"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lampiran Berita Acara Kehilangan",
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.attachment_sharp,
                        size: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
