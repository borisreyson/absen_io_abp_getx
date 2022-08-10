import 'package:face_id_plus/app/data/models/model_tugboat.dart';
import 'package:face_id_plus/app/data/utils/bg.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/monitoring_tugboat_controller.dart';

class MonitoringTugboatView extends GetView<MonitoringTugboatController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Monitoring Tugboat'),
          backgroundColor: const Color.fromARGB(255, 32, 72, 142),
          leading: InkWell(
            borderRadius: BorderRadius.circular(40),
            splashColor: const Color.fromARGB(255, 32, 72, 142),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onTap: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                // bottomDialog(context);
              },
              icon: const Icon(Icons.date_range),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            BackgroundM(),
            Column(
              children: [
                // bagianTgl(context),
                Expanded(
                    child: (controller.isLoading.value)
                        ? Center(
                            child: Image.asset(
                              'assets/load.gif',
                              width: 70,
                            ),
                          )
                        : listTugboat()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listTugboat() {
    return SmartRefresher(
      enablePullUp: controller.pullUp.value,
      enablePullDown: true,
      onRefresh: controller.onRefresh,
      onLoading: controller.onUpdate,
      controller: controller.refreshController.value,
      header: const WaterDropMaterialHeader(
        backgroundColor: Color.fromARGB(255, 32, 72, 142),
      ),
      child: ListView(
        children:
            controller.dataTugboat.map((element) => content(element)).toList(),
      ),
    );
  }

  Widget content(DataTugboat dt) {
    var tanggal = DateTime.parse("${dt.tgl}");
    var tonase = controller.f.value.format(double.parse("${dt.tonase}"));
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 32, 72, 142),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      controller.fmt.value.format(tanggal),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("${dt.status}"),
                ),
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text("Tugboat")),
                  DataColumn(label: Text("Barge")),
                  DataColumn(label: Text("Tiba")),
                  DataColumn(label: Text("Tonase"))
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text("${dt.tugboat}")),
                      DataCell(Text("${dt.barge}")),
                      DataCell(Text("${dt.timeBoard}")),
                      DataCell(Text(tonase)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
