import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/allhazard_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/allhazard_state.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/form/new_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/widget_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/all_hazard_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/data_hazard.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:face_id_plus/abp_energy/utils/custom_footer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HazardList extends StatefulWidget {
  final String option;
  final int disetujui;
  const HazardList({Key? key, required this.option, required this.disetujui})
      : super(key: key);

  @override
  State<HazardList> createState() => _HazardListState();
}

class _HazardListState extends State<HazardList> {
  final Color _hseColor = const Color.fromARGB(255, 199, 134, 22);
  int _page = 1;
  late AllHazardBloc _allHazardBloc;
  List<Data>? _data;
  int lastPage = 0;
  int toIndex = 0;
  final RefreshController _pullRefresh =
      RefreshController(initialRefresh: false);
  DateTime? _dari, _sampai;
  DateTime dt = DateTime.now();
  DateFormat fmt = DateFormat('dd MMMM yyyy');
  DateTime firstDate = DateTime.now();
  String? _rule;
  String? username;
  int? _selectedIndex;
  bool isLoading = false;
  bool pullUp = true;
  final List _colorList = const <Color>[
    Color.fromARGB(255, 173, 140, 5),
    Color.fromARGB(255, 19, 122, 22),
    Color.fromARGB(255, 169, 3, 3)
  ];

  @override
  void initState() {
    _data = [];
    _selectedIndex = widget.disetujui;
    _getPref();
    firstDate = DateTime(dt.year, dt.month, 01);
    _dari = firstDate;
    _sampai = dt;
    _data!.clear();
    _allHazardBloc = AllHazardBloc(AllHazardApi());

    _allHazardBloc.loadListHazard(
        disetujui: _selectedIndex!,
        halaman: _page,
        pertama: true,
        kedua: false,
        paging: false,
        dari: fmt.format(_dari!),
        sampai: fmt.format(_sampai!));

    super.initState();
  }

  void _onItemTapped(int index) {
    _dari = firstDate;
    _sampai = dt;
    _page = 1;
    _data!.clear();
    _selectedIndex = index;
    isLoading = false;

    if (index == 0) {
      _pullRefresh.isLoading;
      _onRefresh();
    } else if (index == 1) {
      _allHazardBloc.loadListHazard(
          disetujui: _selectedIndex!,
          halaman: _page,
          pertama: true,
          kedua: false,
          paging: false,
          dari: fmt.format(_dari!),
          sampai: fmt.format(_sampai!));
    } else if (index == 2) {
      _allHazardBloc.loadListHazard(
          disetujui: _selectedIndex!,
          halaman: _page,
          pertama: true,
          kedua: false,
          paging: false,
          dari: fmt.format(_dari!),
          sampai: fmt.format(_sampai!));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _navBar(),
        floatingActionButton: _floatingAction(),
        appBar: AppBar(
          backgroundColor: _colorList.elementAt(_selectedIndex!),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                _showBottomDialog();
              },
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                bool res =
                    await Constants().goTo(() => const FormHazard(), context);
                if (res) {
                  _onItemTapped(0);
                }
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          ],
          title: const Text("Seluruh Hazard Report"),
        ),
        backgroundColor: _colorList.elementAt(_selectedIndex!),
        body: _getData());
  }

  Widget _getData() {
    return BlocProvider<AllHazardBloc>(
      create: (context) => _allHazardBloc,
      child: BlocListener<AllHazardBloc, AllHazardState>(
        listener: (context, state) {
          if (state is AllHazardLoaded) {
            lastPage = state.allHazard.lastPage!;
            if (_page == lastPage) {
              pullUp = false;
            } else {
              pullUp = true;
            }
            if (kDebugMode) {
              print("halaman2 : $_page : $lastPage");
            }
            if (state.allHazard.to != null) {
              toIndex = state.allHazard.to!;
            }
            _data!.addAll(state.allHazard.data!);
            _pullRefresh.loadComplete();
            _pullRefresh.refreshCompleted();
          } else if (state is AllHazardLoading) {
            if (_pullRefresh.isRefresh) {
              _data?.clear();
              _pullRefresh.loadComplete();
              _pullRefresh.refreshCompleted();
            }
          } else if (state is InitialAllHazard) {
          } else if (state is AllHazardPaging) {
            if (_pullRefresh.isRefresh) {
              _pullRefresh.loadComplete();
              _pullRefresh.refreshCompleted();
            }
          }
        },
        child: _blocBuilder(),
      ),
    );
  }

  Widget _blocBuilder() {
    return BlocBuilder<AllHazardBloc, AllHazardState>(
        builder: (context, state) {
      if (state is AllHazardError) {
        return SmartRefresher(
            enablePullUp: pullUp,
            enablePullDown: true,
            controller: _pullRefresh,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            footer: const MyCustomFooter(),
            header: WaterDropMaterialHeader(
              backgroundColor: Colors.white,
              color: _colorList.elementAt(_selectedIndex!),
            ),
            child: ListView(children: [Text(state.errMSG)]));
      } else if (state is InitialAllHazard) {
        return SmartRefresher(
            enablePullUp: pullUp,
            enablePullDown: true,
            controller: _pullRefresh,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            footer: const MyCustomFooter(),
            header: WaterDropMaterialHeader(
              backgroundColor: Colors.white,
              color: _colorList.elementAt(_selectedIndex!),
            ),
            child: ListView(
              children: const [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ],
            ));
      }
      return SmartRefresher(
          enablePullUp: pullUp,
          enablePullDown: true,
          controller: _pullRefresh,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          footer: const MyCustomFooter(),
          header: WaterDropMaterialHeader(
            backgroundColor: Colors.white,
            color: _colorList.elementAt(_selectedIndex!),
          ),
          child: ListView(
              children: _data!
                  .map(
                    ((e) => WidgetHazard(
                          e,
                          _rule!,
                          reload,
                          username: username!,
                          disetujui: _selectedIndex,
                          option: widget.option,
                        )),
                  )
                  .toList()));
    });
  }

  Future<DateTime?> _selectDate(BuildContext context, DateTime initDate) async {
    return await DatePicker.showDatePicker(context,
        showTitleActions: true, maxTime: dt, currentTime: initDate);
  }

  _showBottomDialog() {
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
                      _tglPick("Dari", _dari),
                      const SizedBox(
                        height: 20,
                      ),
                      _tglPick("Sampai", _sampai),
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
          color: _hseColor,
          elevation: 10,
          child: InkWell(
              onTap: () async {
                var selected = await _selectDate(context, ___inital!);
                if (selected != null) {
                  if (__title == "Dari") {
                    stateSet(() {
                      _dari = selected;
                      ___inital = selected;
                    });
                  } else if (__title == "Sampai") {
                    stateSet(() {
                      _sampai = selected;
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
                    Text(fmt.format(___inital!), style: _style),
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget _submitWidgetDTrange() {
    TextStyle _style =
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    return Card(
      color: _hseColor,
      elevation: 10,
      child: InkWell(
          onTap: () {
            _page = 1;
            _data?.clear();
            _allHazardBloc.loadListHazard(
                disetujui: _selectedIndex!,
                halaman: _page,
                pertama: true,
                kedua: false,
                paging: false,
                dari: fmt.format(_dari!),
                sampai: fmt.format(_sampai!));
            Navigator.pop(context);
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

  _getPref() async {
    var pref = await SharedPreferences.getInstance();
    _rule = pref.getString(Constants.RULE);
    username = pref.getString(Constants.USERNAME);
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
            bool res =
                await Constants().goTo(() => const FormHazard(), context);
            if (res) {
              _onItemTapped(0);
            }
          }),
          child: Icon(
            Icons.add,
            color: _colorList.elementAt(_selectedIndex!),
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
            backgroundColor: _colorList.elementAt(_selectedIndex!)),
        BottomNavigationBarItem(
            icon: const Icon(Icons.approval_outlined),
            label: 'Approved',
            backgroundColor: _colorList.elementAt(_selectedIndex!)),
        BottomNavigationBarItem(
          icon: const Icon(Icons.cancel),
          label: 'Cancel',
          backgroundColor: _colorList.elementAt(_selectedIndex!),
        )
      ],
      currentIndex: _selectedIndex!,
      onTap: _onItemTapped,
    );
  }

  void _onRefresh() async {
    setState(() {
      _data = [];
      _page = 1;
      _allHazardBloc.loadListHazard(
          disetujui: _selectedIndex!,
          halaman: _page,
          pertama: true,
          kedua: false,
          paging: false,
          dari: fmt.format(_dari!),
          sampai: fmt.format(_sampai!));
    });
  }

  void reload({bool s = false}) async {
    _data!.clear();
    _page = 1;
    if (s) {
      _allHazardBloc.loadListHazard(
          disetujui: _selectedIndex!,
          halaman: _page,
          pertama: true,
          kedua: false,
          paging: false,
          dari: fmt.format(_dari!),
          sampai: fmt.format(_sampai!));
    }
  }

  void _onLoading() async {
    setState(() {
      if (_page < lastPage) {
        isLoading = true;
        _page++;
        _allHazardBloc.loadListHazard(
            disetujui: _selectedIndex!,
            halaman: _page,
            pertama: false,
            kedua: false,
            paging: true,
            dari: fmt.format(_dari!),
            sampai: fmt.format(_sampai!));
      } else {
        _pullRefresh.refreshCompleted();
        _pullRefresh.loadComplete();
      }
    });
  }
}
