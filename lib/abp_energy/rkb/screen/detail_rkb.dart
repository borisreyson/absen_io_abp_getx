import 'package:flutter/material.dart';

class DetailRKB extends StatefulWidget {
  const DetailRKB({Key? key}) : super(key: key);

  @override
  State<DetailRKB> createState() => _DetailRKBState();
}

class _DetailRKBState extends State<DetailRKB> {
  Color color = const Color.fromARGB(255, 32, 72, 142);
  TextStyle style = const TextStyle(
      fontWeight: FontWeight.bold, color: Color.fromARGB(255, 91, 90, 90));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text("00153/ABP/RKB/LOGISTIC/2022"),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: detail(),
      ),
    );
  }

  Widget detail() {
    return ListView(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 8),
                    child: Row(
                      children: [
                        Text("Part Name", style: style),
                        const SizedBox(width: 40),
                        const Text(
                          "Kasur / Tempat Tidur",
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 90, 90),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Divider(
                      thickness: 1, 
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Row(
                      children: [
                        Text("Part Number", style: style),
                        const SizedBox(width: 27),
                        const Text(
                          "Single No.2 + Bantal & Guling",
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 90, 90),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Divider(
                      thickness: 1, 
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Row(
                      children: [
                        Text("Quantity", style: style),
                        const SizedBox(width: 55),
                        const Text(
                          "4.0 SET",
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 90, 90),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Divider(
                      thickness: 1, 
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Row(
                      children: [
                        Text("Remarks", style: style),
                        const SizedBox(width: 52),
                        const Text(
                          "U/ Karyawan baru (1 PGDP dan\n3 GL Produksi) Permintaan Sapras\nBpk. Mutazillah Mulkan Azmy",
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 90, 90),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Divider(
                      thickness: 1, 
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Row(
                      children: [
                        Text("Due Date", style: style),
                        const SizedBox(width: 50),
                        const Text(
                          "31 Mei 2022",
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 90, 90),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
