import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../data/utils/custom_footer.dart';
import '../../hazardList/views/widget_hazard_view.dart';
import '../controllers/hazard_p_j_controller.dart';

class HazardPJView extends GetView<HazardPJController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(controller.judul.value),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                _showBottomDialog(context);
              },
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          ],
          elevation: 0,
          backgroundColor:
              controller.colorList.elementAt(controller.selectedIndex.value),
        ),
        body: _getData(),
        bottomNavigationBar: _navBar(),
        floatingActionButton: _floatingAction(),
        backgroundColor:
            controller.colorList.elementAt(controller.selectedIndex.value),
      ),
    );
  }

  Widget _getData() {
    return SmartRefresher(
      footer: const MyCustomFooter(),
      controller: controller.pullRefresh,
      enablePullDown: true,
      enablePullUp: controller.pullUp.value,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: ListView(
        children: controller.data
            .map((data) => WidgetHazardView(
                data, controller.rule.value, controller.onRefresh,
                username: controller.username.value))
            .toList(),
      ),
    );
  }

  _showBottomDialog(context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return Stack(
            children: [
              Card(
                margin: const EdgeInsets.only(top: 40),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      _tglPick("Dari", controller.dari.value),
                      const SizedBox(
                        height: 20,
                      ),
                      _tglPick("Sampai", controller.sampai.value),
                      const SizedBox(
                        height: 20,
                      ),
                      _submitWidgetDTrange()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                      )),
                ),
              )
            ],
          );
        });
  }

  Widget _tglPick(String __title, _initial) {
    var ___inital = _initial;
    TextStyle _style =
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    return StatefulBuilder(
      builder: (context, stateSet) {
        return Card(
          color: controller.hseColor,
          elevation: 10,
          child: InkWell(
              onTap: () async {
                var selected = await _selectDate(context, ___inital!);
                if (selected != null) {
                  if (__title == "Dari") {
                    stateSet(() {
                      controller.dari.value = selected;
                      ___inital = selected;
                    });
                  } else if (__title == "Sampai") {
                    stateSet(() {
                      controller.sampai.value = selected;
                      ___inital = selected;
                    });
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      __title,
                      style: _style,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(controller.fmt.format(___inital!), style: _style),
                  ],
                ),
              )),
        );
      },
    );
  }

  Future<DateTime?> _selectDate(BuildContext context, DateTime initDate) async {
    return await DatePicker.showDatePicker(context,
        showTitleActions: true, maxTime: controller.dt, currentTime: initDate);
  }

  Widget _submitWidgetDTrange() {
    TextStyle _style =
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    return Card(
      color: controller.hseColor,
      elevation: 10,
      child: InkWell(
          onTap: () {
            controller.page = 1;
            controller.data.clear();
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Submit",
                  style: _style,
                ),
              ],
            ),
          )),
    );
  }

  Widget _floatingAction() {
    return SizedBox(
      width: 50,
      height: 50,
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 10,
          backgroundColor: Colors.white,
          onPressed: (() async {
            controller.onItemTapped(0);
          }),
          child: Icon(
            Icons.add,
            color:
                controller.colorList.elementAt(controller.selectedIndex.value),
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _navBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      elevation: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: const Icon(Icons.autorenew),
            label: 'Waiting',
            backgroundColor:
                controller.colorList.elementAt(controller.selectedIndex.value)),
        BottomNavigationBarItem(
            icon: const Icon(Icons.approval_outlined),
            label: 'Approved',
            backgroundColor:
                controller.colorList.elementAt(controller.selectedIndex.value)),
        BottomNavigationBarItem(
          icon: const Icon(Icons.cancel),
          label: 'Cancel',
          backgroundColor:
              controller.colorList.elementAt(controller.selectedIndex.value),
        )
      ],
      currentIndex: controller.selectedIndex.value,
      onTap: controller.onItemTapped,
    );
  }
}
