import 'dart:async';
import 'package:face_id_plus/abp_energy/master/model/berita.dart' as berita;
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:face_id_plus/absensi/landing/splash.dart';
import 'package:face_id_plus/buletin/detail_buletin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/landing/auth_check.dart';
import 'package:face_id_plus/abp_energy/master/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/master/bloc/state.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late BeritaBloc _beritaBloc;
  final refreshController = RefreshController();
  late int _selectedIndex, page, lastPage;

  List<Color> iconColors = [
    const Color(0xFF7C6B9C),
    const Color(0xff64926D),
    const Color(0xFF732937)
  ];

  List<Color> textColors = [
    const Color.fromARGB(255, 243, 242, 242),
    Colors.white,
    Colors.white
  ];
  late List<berita.Data> data;
  @override
  void initState() {
    data = [];
    _selectedIndex = 0;
    page = 1;
    lastPage = 0;
    _beritaBloc = BeritaBloc(BeritaRepository());
    _beritaBloc.loadBerita(page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BeritaBloc>(
      create: (context) => _beritaBloc,
      child: Scaffold(
        bottomNavigationBar: navigasi(),
        appBar: AppBar(
          title: const Text(
            "Buletin",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: BlocListener<BeritaBloc, StateBloc>(
          listener: (context, state) {
            if (state is LoadedBerita) {
              setState(() {
                var res = state.data.data;
                if (res != null) {
                  data.addAll(res);
                }
              });
            }
          },
          child: SmartRefresher(
            controller: refreshController,
            onRefresh: _pullRefresh,
            onLoading: _paginate,
            child: ListView(
              children: data
                  .map(
                    (e) => _content(e),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(berita.Data _list) {
    DateFormat fmt = DateFormat("dd MMMM yyyy");
    var tanggal = DateTime.parse("${_list.tgl}");
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetailBuletin(listBuletin: _list)));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    fmt.format(tanggal),
                    textAlign: TextAlign.right,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  title: Text("${_list.judul}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text("\n${_list.pesan}", maxLines: 6),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget navigasi() {
    return BottomNavigationBar(
      selectedFontSize: 18,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 131, 17, 9),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      elevation: 10,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.newspaper_rounded,
          ),
          label: 'Berita',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.co_present_rounded,
          ),
          label: 'Absensi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.apps_rounded),
          label: 'Abp System',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int value) async {
    setState(() {
      _selectedIndex = value;
    });
    if (value == 2) {
      var res = await Constants().goTo(() => const AuthCheck(), context);
      if (kDebugMode) {
        print("reslog $res");
      }
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _selectedIndex = 0;
        });
      });
    } else if (value == 1) {
      var res = await Constants().goTo(() => const Splash(), context);
      if (kDebugMode) {
        print("reslog $res");
      }
    } else if (value == 0) {}
  }

  void _pullRefresh() {
    setState(() {
      data = [];
      page = 1;
      _beritaBloc.loadBerita(
        page,
      );
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    });
  }

  void _paginate() async {
    setState(() {
      if (page < lastPage) {
        page++;
        _beritaBloc.loadBerita(
          page,
        );
      } else {
        refreshController.refreshCompleted();
        refreshController.loadComplete();
      }
    });
  }
}
