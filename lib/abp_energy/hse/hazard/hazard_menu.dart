import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/hazard_ke_saya.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/hazard_list.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/hazard_user.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/master/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/master/bloc/state.dart';
import 'package:face_id_plus/abp_energy/master/model/user_profile.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HazardMenu extends StatefulWidget {
  const HazardMenu({Key? key}) : super(key: key);

  @override
  State<HazardMenu> createState() => _HazardMenuState();
}

class _HazardMenuState extends State<HazardMenu> {
  String? fullName,
      nik,
      dept,
      company,
      profile,
      username,
      rule,
      fotoProfile,
      tglSekarang;
  late ProfileBloc _bloc;
  late CounterHazardBloc _blocCounter;

  final Color _hazardMenu = const Color.fromARGB(255, 74, 112, 13);
  final BoxDecoration _gradient = const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      Color.fromARGB(255, 14, 189, 104),
      Color.fromARGB(255, 5, 117, 2),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ));

  @override
  void initState() {
    _bloc = ProfileBloc(UsersRepository());
    _blocCounter = CounterHazardBloc(HazardRepository());
    var dt = DateTime.now();
    var fmt = DateFormat('dd MMMM yyyy');
    tglSekarang = fmt.format(dt);
    getPref();
    super.initState();
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString(Constants.USERNAME);
      rule = pref.getString(Constants.RULE);
      nik = pref.getString(Constants.NIK);
      fotoProfile = pref.getString(Constants.fotoProfile);
      _bloc.loadProfile(username);
      _blocCounter.loadCounter(username, nik);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _gradient,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Center(child: Text("$tglSekarang")),
            )
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: MultiBlocProvider(
          providers: [
            BlocProvider<ProfileBloc>(create: (context) => _bloc),
            BlocProvider<CounterHazardBloc>(create: (context) => _blocCounter),
          ],
          child: BlocBuilder<ProfileBloc, StateBloc>(
            builder: (context, state) {
              if (state is LoadedProfile) {
                var res = state.data;
                var profile = res.dataUser!;
                return ListView(
                  children: [
                    Center(
                      child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: (fotoProfile != null)
                                    ? Image.network(
                                        fotoProfile!,
                                        height: 80,
                                        fit: BoxFit.fill,
                                      )
                                    : const Image(
                                        image: AssetImage(
                                            'assets/images/ic_abp.png'),
                                        height: 40,
                                      )),
                          )),
                    ),
                    Center(
                      child: Text(
                        "${profile.namaLengkap}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Card(
                        elevation: 20,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 5),
                        child: _userProf(res)),
                    _menuCar(profile)
                  ],
                );
              }
              return ListView();
            },
          ),
        ),
      ),
    );
  }

  Widget _userProf(UserProfileModel profile) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                "Hazard",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: _hazardMenu),
              ),
              Text("${profile.dataHazard}",
                  style: TextStyle(color: _hazardMenu, fontSize: 20)),
            ],
          ),
          Column(
            children: [
              Text(
                "Inspeksi",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: _hazardMenu),
              ),
              Text("${profile.datInspeksi}",
                  style: TextStyle(color: _hazardMenu, fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuCar(DataUser profile) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        BlocBuilder<CounterHazardBloc, StateBloc>(
          builder: (context, state) {
            if (state is LoadedCounterHazard) {
              return _hazard(state);
            }
            return Container();
          },
        ),
        // _hazardKesaya(),
        BlocBuilder<CounterHazardBloc, StateBloc>(
          builder: (context, state) {
            if (state is LoadedCounterHazard) {
              if (kDebugMode) {
                print("kesaya = ${state.data.kesayaDibatalkan}");
              }
              return _hazardKeSaya(profile, state);
            }
            return Container();
          },
        ),
        BlocBuilder<CounterHazardBloc, StateBloc>(
          builder: (context, state) {
            if (state is LoadedCounterHazard) {
              return _hazardSeluruh(profile, state);
            }
            return Container();
          },
        ),
        // _inspeksi()
      ]),
    );
  }

  Widget _hazard(LoadedCounterHazard state) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hazard Report",
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
                        await Constants().goTo(
                            () =>
                                const HazardUser(option: "user", disetujui: 0),
                            context);
                        getPref();
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
                            child: Text("${state.data.waiting}",
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
                        await Constants().goTo(
                            () =>
                                const HazardUser(option: "user", disetujui: 1),
                            context);
                        getPref();
                      },
                      child: ListTile(
                        title: const Center(
                            child: Text(
                          "Approved",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                        subtitle: Center(
                            child: Text("${state.data.approve}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: const Color.fromARGB(255, 186, 27, 15),
                    child: InkWell(
                      onTap: () async {
                        await Constants().goTo(
                            () =>
                                const HazardUser(option: "user", disetujui: 2),
                            context);
                        getPref();
                      },
                      child: ListTile(
                        title: const Center(
                            child: Text(
                          "Canceled",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                        subtitle: Center(
                            child: Text("${state.data.cancel}",
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
    );
  }

  Widget _hazardKeSaya(
    DataUser profile,
    LoadedCounterHazard counter,
  ) {
    return Visibility(
      visible: (rule == null)
          ? false
          : (rule!.contains("admin_hse"))
              ? true
              : (rule!.contains("administrator"))
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
                          await Constants().goTo(
                              () => const HazardKeSaya(
                                  option: "saya", disetujui: 0),
                              context);
                          getPref();
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
                              child: Text("${counter.data.kesayaWaiting}",
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
                          await Constants().goTo(
                              () => const HazardKeSaya(
                                  option: "saya", disetujui: 1),
                              context);
                          getPref();
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
                              child: Text("${counter.data.kesayaDisetujui}",
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
                          await Constants().goTo(
                              () => const HazardKeSaya(
                                  option: "saya", disetujui: 2),
                              context);
                          getPref();
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
                              child: Text("${counter.data.kesayaDibatalkan}",
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

  Widget _hazardSeluruh(
    DataUser profile,
    LoadedCounterHazard counter,
  ) {
    return Visibility(
      visible: (rule == null)
          ? false
          : (rule!.contains("admin_hse"))
              ? true
              : (rule!.contains("administrator"))
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
                          await Constants().goTo(
                              () =>
                                  const HazardList(option: "all", disetujui: 0),
                              context);
                          getPref();
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
                              child: Text("${counter.data.allWaiting}",
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
                          await Constants().goTo(
                              () =>
                                  const HazardList(option: "all", disetujui: 1),
                              context);
                          getPref();
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
                              child: Text("${counter.data.allDisetujui}",
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
                          await Constants().goTo(
                              () =>
                                  const HazardList(option: "all", disetujui: 2),
                              context);
                          getPref();
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
                              child: Text("${counter.data.allDibatalkan}",
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

  // ignore: unused_element
  Widget _inspeksi() {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Inspeksi",
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
                      onTap: () {
                        // Constants().goTo(() =>  HazardList(option:"all"), context);
                      },
                      child: const ListTile(
                        title: Center(
                            child: Text(
                          "Waiting",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        )),
                        subtitle: Center(
                            child: Text("0",
                                style: TextStyle(
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
                      onTap: () {
                        // Constants().goTo(() =>  HazardList(option:"all"), context);
                      },
                      child: const ListTile(
                        title: Center(
                            child: Text(
                          "Approved",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                        subtitle: Center(
                            child: Text("0",
                                style: TextStyle(
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
                      onTap: () {
                        // Constants().goTo(() =>  HazardList(option:"all"), context);
                      },
                      child: const ListTile(
                        title: Center(
                            child: Text(
                          "Canceled",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                        subtitle: Center(
                            child: Text("0",
                                style: TextStyle(
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
    );
  }
}
