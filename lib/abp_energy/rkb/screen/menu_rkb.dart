import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_barging.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_crushing.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_hauling.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_ob.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_stock_product.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_stockroom.dart';
import 'package:face_id_plus/abp_energy/rkb/screen/rkb_total.dart';
import 'package:flutter/material.dart';

class MenuRKB extends StatefulWidget {
  const MenuRKB({Key? key}) : super(key: key);

  @override
  State<MenuRKB> createState() => _MenuRKBState();
}

class _MenuRKBState extends State<MenuRKB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 72, 142),
        title: const Text("Menu RKB"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: menuGrid(),
      ),
    );
  }

  Widget menuGrid() {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
      child: GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const TotalRKB(),
                  ),
                );
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/total_rkb.png",
                      width: 200,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const MonitoringHauling(),
                  ),
                );
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/appr_rkb.png",
                      width: 200,
                      height: 90,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Approve",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const MonitoringCrushing(),
                  ),
                );
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/waiting_rkb.png",
                      width: 140,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Waiting",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const MonitoringBarging(),
                  ),
                );
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/cancel_rkb.png",
                      width: 200,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Cancel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const MonitoringStockRoom()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/close_rkb.png",
                      width: 140,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Close",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
