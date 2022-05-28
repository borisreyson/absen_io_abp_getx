import 'package:face_id_plus/abp_energy/rkb/screen/detail_rkb.dart';
import 'package:flutter/material.dart';

class TotalRKB extends StatefulWidget {
  const TotalRKB({Key? key}) : super(key: key);

  @override
  State<TotalRKB> createState() => _TotalRKBState();
}

class _TotalRKBState extends State<TotalRKB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 72, 142),
        title: const Text("Total RKB"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: totalRKB(),
      ),
    );
  }

  Widget totalRKB() {
    return ListView(
      children: [
        SizedBox(
          width: double.infinity,
          height: 340,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const DetailRKB(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 20,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 32, 72, 142),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "00153/ABP/RKB/LOGISTIC/2022",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text("28 Mei 2022", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 91, 90, 90),
                          ),
                        ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "HENDRA",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 91, 90, 90),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("HCGA & EXTERNAL - LOGISTIC",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 91, 90, 90),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("Kabag"),
                        Text("KTT"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        SizedBox(
                          height: 30,
                          child: Card(
                            elevation: 20,
                            color: Colors.green,
                            child: Center(child: Text("17:26:01. 28 Mei 2022", style: TextStyle(color: Colors.white, fontSize: 12),)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Card(
                            elevation: 20,
                            color: Colors.green,
                            child: Center(child: Text("17:26:01. 28 Mei 2022", style: TextStyle(color: Colors.white, fontSize: 12),)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
