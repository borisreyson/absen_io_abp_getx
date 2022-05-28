import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

import 'auth/login.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> with TickerProviderStateMixin {
  bool izinStatus = false;
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 1), vsync: this)
        ..repeat(reverse: true);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 2300),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const Login();
        }));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ScaleTransition(
        scale: _animation,
        child: Card(
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.credit_card_rounded,
                size: 120,
                color: Color.fromARGB(255, 9, 95, 165),
              ),
            ),
          ),
        ),
      ),
    ));
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
}
