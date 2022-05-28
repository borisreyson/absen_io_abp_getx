import 'package:face_id_plus/abp_energy/landing/loading_abp.dart';
import 'package:face_id_plus/abp_energy/service/lokasi.dart';
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/landing/landing.dart';

class AnimatedLoading extends StatefulWidget {
  const AnimatedLoading({Key? key}) : super(key: key);

  @override
  State<AnimatedLoading> createState() => _AnimatedLoadingState();
}

class _AnimatedLoadingState extends State<AnimatedLoading> {
  bool izinStatus = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      var perizinan = await statusIzin();
      var penyimpanan = await izinPenyimpanan();

      if (perizinan && penyimpanan) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LandingPage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Lokasi()));
      }
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const LoadingAbp();
  }

  Future<bool> statusIzin() async {
    var camera = handler.Permission.camera;
    var status = await camera.status;
    if (status == handler.PermissionStatus.granted) {
      izinStatus = true;
    }
    if (status == handler.PermissionStatus.denied) {
      izinStatus = false;
    } else if (status == handler.PermissionStatus.permanentlyDenied) {
      izinStatus = false;
    }
    return izinStatus;
  }

  Future<bool> izinPenyimpanan() async {
    var camera = handler.Permission.storage;
    var status = await camera.status;
    if (status == handler.PermissionStatus.granted) {
      izinStatus = true;
    }
    if (status == handler.PermissionStatus.denied) {
      izinStatus = false;
    } else if (status == handler.PermissionStatus.permanentlyDenied) {
      izinStatus = false;
    }
    return izinStatus;
  }
}

