import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/master/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/master/bloc/state.dart';
import 'package:face_id_plus/abp_energy/master/model/user_profile.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final String? username;
  const ProfileScreen(this.username, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? fullName, nik, dept, company, profile;
  late ProfileBloc _bloc;
  @override
  void initState() {
    _bloc = ProfileBloc(UsersRepository());
    _bloc.loadProfile(widget.username);
    getPref();
    super.initState();
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      fullName = pref.getString(Constants.NAME);
      profile = pref.getString(Constants.fotoProfile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profil Saya",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            BlocBuilder<ProfileBloc, StateBloc>(
              builder: (context, state) {
                if (state is LoadedProfile) {
                  var res = state.data;
                  var profil = res.dataUser!;
                  return Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: Column(
                          children: [
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: (profil.photoProfile != null)
                                        ? Image.network(
                                            profil.photoProfile!,
                                            fit: BoxFit.fill,
                                            height: 80,
                                          )
                                        : const Image(
                                            image: AssetImage(
                                                'assets/images/ic_abp.png'),
                                            fit: BoxFit.cover,
                                            height: 80,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "@${profil.username}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${profil.namaLengkap}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${profil.nik}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 122, 118, 118),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "${profil.dept}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 122, 118, 118),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "${profil.namaPerusahaan}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 141, 137, 137),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (state is Loading) {
                  return _profileShimmer();
                } else if (state is Error) {
                  return _profileShimmer();
                }
                return _profileShimmer();
              },
            ),
            const SizedBox(
              height: 40,
            ),
            BlocBuilder<ProfileBloc, StateBloc>(
              builder: (context, state) {
                if (state is LoadedProfile) {
                  var res = state.data;
                  var profil = res.dataUser!;
                  return Column(
                    children: [
                      Container(
                        height: 0.5,
                        color: const Color.fromARGB(255, 112, 111, 111),
                      ),
                      ubahData(profil),
                      ubahPassword(profil),
                    ],
                  );
                }
                return Container();
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: (() async {
            var res = await Constants().showMyDialog(context, "Log Out");
            if (res) {
              var exit = await Constants().sign_out(context);
              if (exit) {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              }
            }
          }),
          child: const Icon(Icons.exit_to_app),
        ),
      ),
    );
  }

  Widget ubahPassword(DataUser profil) {
    return Visibility(
      visible: (profil.rule!.contains("administrator")) ? true : false,
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Color.fromARGB(255, 112, 111, 111),
              ),
            ),
          ),
          child: const ListTile(
            leading: Icon(Icons.key),
            title: Text(
              "Ubah Password",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 124, 124, 124)),
            ),
          ),
        ),
      ),
    );
  }

  Widget ubahData(DataUser profil) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Color.fromARGB(255, 112, 111, 111),
            ),
          ),
        ),
        child: const ListTile(
          leading: Icon(Icons.mode_edit_outline_outlined),
          title: Text(
            "Ubah Profil",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 124, 124, 124)),
          ),
        ),
      ),
    );
  }

  Widget _profileShimmer() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          color: const Color.fromARGB(255, 214, 221, 232),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child: CupertinoActivityIndicator(
                  radius: 20,
                ),
              ))),
      SizedBox(
        width: MediaQuery.of(context).size.width / 3,
      )
    ]);
  }
}
