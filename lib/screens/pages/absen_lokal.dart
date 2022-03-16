import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as iosLocation;
import 'package:google_ml_kit/google_ml_kit.dart';


class AbsenLokal extends StatefulWidget {
  const AbsenLokal({ Key? key }) : super(key: key);

  @override
  State<AbsenLokal> createState() => _AbsenLokalState();
}

class _AbsenLokalState extends State<AbsenLokal> {

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  Location _location = Location();


  String getTgl() {
      var tgl = DateTime.now();
      return DateFormat("dd MMMM yyyy").format(tgl);
  }
  
  String getSystemTime() {
      var now = DateTime.now();
      return DateFormat("HH:mm:s").format(now);
  }
  @override
  Widget build(BuildContext context) {
    return _mainContent();
  }

Widget _mainContent() {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // (nik == "18060207")
          //     ? IconButton(
          //         onPressed: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (BuildContext context) =>
          //                       ));
          //         },
          //         icon: const Icon(Icons.map_sharp),
          //         color: Colors.white,
          //       )
          //     : Container(),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => const Profile()));
            },
            icon: const Icon(Icons.menu),
            color: Colors.white,
          ),
        ],
        backgroundColor: const Color(0xFF21BFBD),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: <Widget>[
          _headerContent(),
          const SizedBox(height: 8),
          

        ],
      ),
    );
  }

  Widget _headerContent() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.only(bottom: 55),
          color: const Color(0xFF21BFBD),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Ini Nama",
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 15.0),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Ini Nik",
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 15.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _contents(),
      ]),
    );
  }

  Widget _contents() {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
      color: const Color(0xFFF2E638),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            roster(),
            _jamWidget(),
            _btnAbsen(),
          ],
        ),
      ),
    );
  }

  Widget roster() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Jadwal",
                style: TextStyle(color: Colors.black87),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "InI kode Roster",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          Text("${getTgl()}"),
        ],
      ),
    );
  }

  Widget _jamWidget() {


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                         return  Text("${getSystemTime()}", 
                                 style: 
                                 TextStyle(
                                   fontWeight: FontWeight.bold, 
                                   fontSize: 25,
                                   color: Color(0xFF8C6A03),));
                }
              ),       
              // Text(
              //   "jam",
              //   style: const TextStyle(
              //       color: Color(0xFF8C6A03),
              //       fontWeight: FontWeight.bold,
              //       fontSize: 25.0),
              // ),
              
            ],
          ),
        ),
        Center(
          child: Text(
            //(_jam_kerja != null) ? "$_jam_kerja" : 
            "Jam Kerja",
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _btnAbsen(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: (){

                 }, child: Text("Masuk")),

        ),
        SizedBox(
          width: 3,
        ),

         Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: (){

                 }, child: Text("Pulang")),

        ),
        // ElevatedButton(
        //   onPressed: (){

        //   }, child: Text("Masuk")),

        // ElevatedButton(
        //   onPressed: (){

        //   }, child: Text("Keluar")),  
      ],
    );
  }


}