import 'package:face_id_plus/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/counter_hazard.dart';
import '../../../../data/models/user_profile.dart';
import '../controllers/corrective_action_controller.dart';
import 'package:get/get.dart';

class HazardSeluruh extends GetView {
  const HazardSeluruh(
      {Key? key,
      required this.controller,
      required this.profile,
      required this.data})
      : super(key: key);

  final CorrectiveActionController controller;
  final DataUser profile;
  final CounterHazard data;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (profile.rule == null)
          ? false
          : (profile.rule!.contains("admin_hse"))
              ? true
              : (profile.rule!.contains("administrator"))
                  ? true
                  : false,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Seluruh Hazard Report",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 10,
                      color: const Color.fromARGB(255, 238, 153, 8),
                      child: InkWell(
                        onTap: () async {
                          await Get.toNamed(Routes.HAZARD_LIST, parameters: {
                            "option": "all",
                            "disetujui": "0",
                            "judul": "Seluruh Hazard Report"
                          });
                          controller.getPref();
                        },
                        child: ListTile(
                          title: const Center(
                              child: Text(
                            "Waiting",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          )),
                          subtitle: Center(
                              child: Text(
                                  (data.allWaiting != null)
                                      ? "${data.allWaiting}"
                                      : '0',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 10,
                      color: const Color.fromARGB(255, 14, 142, 19),
                      child: InkWell(
                        onTap: () async {
                          await Get.toNamed(Routes.HAZARD_LIST, parameters: {
                            "option": "all",
                            "disetujui": "1",
                            "judul": "Seluruh Hazard Report"
                          });
                          controller.getPref();
                        },
                        child: ListTile(
                          title: const Center(
                              child: Text(
                            "Approved",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                          subtitle: Center(
                              child: Text(
                                  (data.allDisetujui != null)
                                      ? "${data.allDisetujui}"
                                      : '0',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 10,
                      color: const Color.fromARGB(255, 186, 27, 15),
                      child: InkWell(
                        onTap: () async {
                          controller.getPref();
                        },
                        child: ListTile(
                          title: const Center(
                              child: Text(
                            "Canceled",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                          subtitle: Center(
                              child: Text(
                                  (data.allDibatalkan != null)
                                      ? "${data.allDibatalkan}"
                                      : '0',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
