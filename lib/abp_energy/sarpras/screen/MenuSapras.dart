import 'package:face_id_plus/abp_energy/sarpras/screen/form_sapras.dart';
import 'package:face_id_plus/abp_energy/sarpras/screen/sarana_prasana.dart';
import 'package:flutter/material.dart';

class MenuSapras extends StatefulWidget {
  const MenuSapras({Key? key}) : super(key: key);

  @override
  State<MenuSapras> createState() => _MenuSaprasState();
}

class _MenuSaprasState extends State<MenuSapras> {
  Color color = const Color.fromARGB(255, 32, 72, 142);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text("Menu Sapras"),
      ),
      body: menuGrid(),
    );
  }

  Widget menuGrid() {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: GridView.count(
        crossAxisSpacing: 30,
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
                        builder: (BuildContext context) =>
                            const SaranaPrasana()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/sarana.png",
                      width: 110,
                      height: 80,
                    ),
                    const Text(
                      "Sarana dan",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const Text(
                      "Prasarana",
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
                        builder: (BuildContext context) => const FormSapras()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/sarana_add.png",
                      width: 110,
                      height: 80,
                    ),
                    const Text(
                      "Buat Surat Izin",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const Text(
                      "Sarana",
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
