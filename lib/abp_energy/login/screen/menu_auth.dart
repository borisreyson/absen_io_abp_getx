import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/login/screen/daftar.dart';
import 'package:face_id_plus/abp_energy/login/screen/masuk.dart';
import 'package:face_id_plus/abp_energy/main/home.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuAuth extends StatefulWidget {
  const MenuAuth({Key? key}) : super(key: key);

  @override
  State<MenuAuth> createState() => _MenuAuthState();
}

class _MenuAuthState extends State<MenuAuth> {
  int? isLogin;
  @override
  void initState() {
    _getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, "back");
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ))),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            InkWell(
              onTap: () {
                goTo(() => const Daftar());
              },
              child: Card(
                margin: const EdgeInsets.all(20),
                elevation: 20,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset("assets/images/new_user.png"),
                  ),
                  subtitle: const Text("Daftar", textAlign: TextAlign.center),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                goTo(() => const Masuk());
              },
              child: Card(
                margin: const EdgeInsets.all(20),
                elevation: 20,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset("assets/images/login_ic.png"),
                  ),
                  subtitle: const Text("Masuk", textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  goTo(Function() toPage) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => toPage()));
  }

  _getPref() async {
    var pref = await SharedPreferences.getInstance();
    var isLogin = pref.getBool(Constants.ISLOGIN);
    if (isLogin != null) {
      if (isLogin) {
        // Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const Home();
        }));
      }
    }
  }
}
