import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_barging.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_crushing.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_hauling.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_ob.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_stock_product.dart';
import 'package:face_id_plus/abp_energy/monitoring/screen/monitoring_stockroom.dart';
import 'package:face_id_plus/abp_energy/sarpras/screen/form_sapras.dart';
import 'package:face_id_plus/abp_energy/sarpras/screen/sarana_prasana.dart';
import 'package:flutter/material.dart';

class MenuMonitoring extends StatefulWidget {
  const MenuMonitoring({Key? key}) : super(key: key);

  @override
  State<MenuMonitoring> createState() => _MenuMonitoringState();
}

class _MenuMonitoringState extends State<MenuMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 72, 142),
        title: const Text("Menu Monitoring"),
      ),
      body: menuGrid(),
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
                    builder: (BuildContext context) => const MonitoringOB(),
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
                      "assets/images/ob.png",
                      width: 200,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "OB",
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
                      "assets/images/hauling.png",
                      width: 200,
                      height: 90,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "HAULING",
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
                      "assets/images/crushing.png",
                      width: 140,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "CRUSHING",
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
                      "assets/images/barging.png",
                      width: 200,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "BARGING",
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
                        builder: (BuildContext context) => const MonitoringStockRoom()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/stock.png",
                      width: 140,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "STOCK ROOM",
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
                        builder: (BuildContext context) => const MonitoringStockProduct()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/product_stock.png",
                      width: 200,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    const FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "STOCK",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                    const FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "PRODUCT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
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
