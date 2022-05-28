import 'package:face_id_plus/abp_energy/landing/loading_abp.dart';
import 'package:face_id_plus/abp_energy/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/login/screen/menu_auth.dart';
import 'package:face_id_plus/abp_energy/main/home.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final _service = ApiService();

  @override
  void initState() {
    sqlResource();
    super.initState();
  }

  sqlResource() async {
    await _service.kemungkinanGet();
    await _service.keparahanGet();
    await _service.metrikGet();
    await _service.perusahaanGet();
    await _service.lokasiGet();
    await _service.detKeparahanGet();
    await _service.pengendalianGet();
    await _service.detPengendalianGet();
    await _service.usersGet();
    _getPref();
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingAbp();
  }

  _getPref() async {
    var pref = await SharedPreferences.getInstance();
    bool? isLogin = pref.getBool(Constants.ISLOGIN);
    if (isLogin != null) {
      if (isLogin) {
        Constants().goToReplace(() => const Home(), context);
      } else {
        Constants().goToReplace(() => const MenuAuth(), context);
      }
    } else {
      Constants().goToReplace(() => const MenuAuth(), context);
    }
  }
}
