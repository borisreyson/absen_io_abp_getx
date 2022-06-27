import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/counter_hazard.dart';
import '../../../../data/models/user_profile.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/corrective_action_controller.dart';

class HazardPJ extends GetView {
  const HazardPJ({
    Key? key,
    required this.controller,
    required this.data,
    required this.profile,
  }) : super(key: key);

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
                "Hazard Report Ke Saya",
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
                                  (data.kesayaWaiting != null)
                                      ? "${data.kesayaWaiting}"
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
                                  (data.kesayaDisetujui != null)
                                      ? "${data.kesayaDisetujui}"
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
                          await Get.toNamed(Routes.HAZARD_P_J, parameters: {
                            "option": "saya",
                            "disetujui": "2",
                            "judul": "Hazard Report Ke Saya"
                          });
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
                                  (data.kesayaDibatalkan != null)
                                      ? "${data.kesayaDibatalkan}"
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
