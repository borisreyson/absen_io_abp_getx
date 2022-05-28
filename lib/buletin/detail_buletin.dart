import 'package:face_id_plus/abp_energy/master/model/berita.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DetailBuletin extends StatefulWidget {
  Data? listBuletin;
  DetailBuletin({Key? key, this.listBuletin}) : super(key: key);

  @override
  State<DetailBuletin> createState() => _DetailBuletinState();
}

class _DetailBuletinState extends State<DetailBuletin> {
  DateFormat fmt = DateFormat("dd MMMM yyyy");

  @override
  Widget build(BuildContext context) {
    var buletinData = widget.listBuletin;
    var tanggal = DateTime.parse("${buletinData!.tgl}");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffD9D9D9),
          elevation: 0,
          leading: InkWell(
            splashColor: const Color(0xff000000),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff000000),
            ),
            onTap: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        backgroundColor: const Color(0xffD9D9D9),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  "${buletinData.judul}",
                  style: const TextStyle(
                      color: Color(0xFF0D0D0D),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                fmt.format(tanggal),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 40,
              ),
              Text("${buletinData.pesan}", style: const TextStyle(fontSize: 16))
            ],
          ),
        ));
  }
}
