import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/hse/hazard/hazard_menu.dart';
import 'package:face_id_plus/abp_energy/master/screen/profile.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? username, rule, fotoProfile;

  @override
  void initState() {
    getPref();
    super.initState();
  }

  getPref() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString(Constants.USERNAME);
      rule = pref.getString(Constants.RULE);
      fotoProfile = pref.getString(Constants.fotoProfile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                Constants().goTo(() => ProfileScreen(username), context);
              },
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: (fotoProfile != null)
                        ? Image.network(
                            fotoProfile!,
                            fit: BoxFit.fill,
                          )
                        : const Image(
                            image: AssetImage('assets/images/ic_abp.png'),
                            height: 40,
                          )),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _menu(),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _menu() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      children: [
        Card(
          elevation: 10,
          child: InkWell(
            onTap: () {
              goTo(() => const HazardMenu());
            },
            child: ListTile(
              title: Image.asset("assets/images/car_ic.png"),
              subtitle: const Text("C . A . R", textAlign: TextAlign.center),
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: InkWell(
            onTap: () {},
            child: const ListTile(
              title: Icon(
                Icons.car_repair_outlined,
                size: 85,
              ),
              subtitle: Text("Sarpras", textAlign: TextAlign.center),
            ),
          ),
        ),
      ],
    );
  }

  goTo(Function() toPage) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => toPage()));
  }
}
