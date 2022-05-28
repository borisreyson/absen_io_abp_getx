import 'package:face_id_plus/permit/output/detail_permohonan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class ListPermohonan extends StatefulWidget {
  const ListPermohonan({Key? key}) : super(key: key);

  @override
  State<ListPermohonan> createState() => _ListPermohonanState();
}

class _ListPermohonanState extends State<ListPermohonan> {
  final List<int> _lit = [];
  var total = 5;
  @override
  void initState() {
    for (var i = 1; i <= total; i++) {
      _lit.add(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("Permohonan"),
      ),
      body: ListView.builder(
        itemCount: _lit.length,
        itemBuilder: (BuildContext context, int index) {
          return _cardPermohonan();
        },
      ),
    );
  }

  Widget _cardPermohonan() {
    var textColor =
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(10),
      elevation: 10,
      child: InkWell(
        onTap: () {
          Constants().goTo(() => const DetailPermohonan(), context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Permohonan",
                    style: textColor,
                  ),
                  Text("(Mine Permit & Simper)", style: textColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Perusahaan"),
                      Text("PT Alamjaya Bara Pratama"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Nama"),
                      Text("Boris"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Jabatan"),
                      Text("IT"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Umur"),
                      Text("27 Tahun"),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.black,
                  ),
                  const Text(
                    "Verifikasi",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("DEPT SHE"),
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("PM / PJ"),
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("HSE DEPT PT ABP"),
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("KTT PT ABP"),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.orange,
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: CupertinoActivityIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
