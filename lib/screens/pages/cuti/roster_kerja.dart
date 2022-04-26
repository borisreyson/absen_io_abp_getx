import 'package:face_id_plus/model/roster_kerja_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RosterKerja extends StatefulWidget {
  const RosterKerja({Key? key}) : super(key: key);

  @override
  State<RosterKerja> createState() => _RosterKerjaState();
}

class _RosterKerjaState extends State<RosterKerja> {
  ApiRoster? _roster;
  List<Roster>? infoRoster;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
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
        title: const Text(
          "Roster Kerja",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: loadRoster(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 253, 253, 253),
                        Color.fromARGB(255, 255, 226, 65),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2 / 1.1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        crossAxisCount: 2,
                      ),
                      children: (infoRoster != null)
                          ? infoRoster!.map((b) => content(b)).toList()
                          : [
                              Padding(
                                padding: const EdgeInsets.only(top: 250),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              )
                            ]),
                ));
          }),
    );
  }

  Widget content(Roster list) {
    DateFormat fmt = DateFormat.yMMMMEEEEd("id");
    var _tgl = DateTime.now();
    String color = list.background!.replaceAll("#", "0xff");
    String colorTulisan = list.tulisan!.replaceAll("#", "0xff");
    var tgl = DateTime.parse("${list.tanggal}");
    var tanggal = fmt.format(tgl);
    var thisDay = fmt.format(_tgl);
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: (tanggal == thisDay)
          ? Color.fromARGB(255, 49, 255, 56)
          : Color(int.parse(color)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tanggal,
            style: TextStyle(
                color: Color(int.parse(colorTulisan)),
                fontWeight: FontWeight.bold),
          ),
          Text("${list.masuk} - ${list.pulang}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(int.parse(colorTulisan)))),
          Text("${list.kodeJam}",
              style: TextStyle(
                  color: Color(int.parse(colorTulisan)),
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  loadRoster() async {
    var dt = DateTime.now();
    var pref = await SharedPreferences.getInstance();
    var nik = pref.getString("nik");
    var bulan = dt.month.toString().padLeft(2, '0');
    var load = ApiRoster.getRoster(nik!, bulan, "${dt.year}");
    await load.then((value) {
      _roster = value;
      if (_roster != null) {
        var info = _roster?.roster;
        if (info != null) {
          infoRoster = info as List<Roster>?;
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Data Tidak Ada")));
        }
      }
    }).catchError((onError) {
      print(onError.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Jaringan ${onError.toString()}")));
    });
  }
}
