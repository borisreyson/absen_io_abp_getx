import 'package:face_id_plus/abp_energy/monitoring/screen/menu_monitoring.dart';
import 'package:face_id_plus/abp_energy/rkb/screen/menu_rkb.dart';
import 'package:face_id_plus/abp_energy/sarpras/screen/MenuSapras.dart';
import 'package:face_id_plus/abp_energy/landing/animated_loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import 'package:camera/camera.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

List<CameraDescription> cameras = [];
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseInit();
  cameras = await availableCameras();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

firebaseInit() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
      appId: '1:448618578101:ios:2bc5c1fe2ec336f8ac3efc',
      messagingSenderId: '448618578101',
      projectId: 'react-native-firebase-testing',
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: _mainPage());
  }

  _mainPage() {
          // return const AnimatedLoading();
          return const MenuSapras();
  }
}
