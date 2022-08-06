import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/utils/utils.dart';

class MainAbsenController extends GetxController {
  late StreamController<bool> pingVps;
  late StreamController<bool> pingServer;
  late StreamController<bool> pingLokal;
  late StreamController<bool> pingServerOnline;
  final isOnline = false.obs;
  final lokalOnline = false.obs;
  final serverOnline = false.obs;
  final serverVps = false.obs;
  final Duration _duration = const Duration(seconds: 5);
  final isRunning = false.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    serverStream();
    super.onReady();
  }

  @override
  void onClose() {
    closePing();
    print("Close");
  }

  @override
  void dispose() {
    print("dispose");
    closePing();
  }

  serverStream() {
    pingVps = StreamController.broadcast();
    pingServer = StreamController.broadcast();
    pingLokal = StreamController.broadcast();
    pingServerOnline = StreamController.broadcast();

    pingVps.stream.listen((bool isConnected) {
      serverVps.value = isConnected;
      if (kDebugMode) {
        print("isConnected Vps $isConnected");
      }
    });

    pingServer.stream.listen((bool isConnected) {
      isOnline.value = isConnected;
      if (kDebugMode) {
        print("isConnected $isConnected");
      }
    });

    pingLokal.stream.listen((bool localConnected) {
      lokalOnline.value = localConnected;
      if (kDebugMode) {
        print("lokalOnline $lokalOnline");
      }
    });

    pingServerOnline.stream.listen((bool onlineServer) {
      serverOnline.value = onlineServer;
      if (kDebugMode) {
        print("onlineServer $onlineServer");
      }
    });
    // reloadCekServer();
    pingServerRun();
  }

  pingServerRun() async {
    print("start stream");
    if (!pingVps.isClosed &&
        !pingServer.isClosed &&
        !pingServerOnline.isClosed &&
        !pingLokal.isClosed) {
      print(
          "server ${pingVps.isClosed} ${pingServer.isClosed} ${pingServerOnline.isClosed} ${pingLokal.isClosed}");
      pingVps.add(await Utils().pingVps());
      pingServer.add(await Utils().pingServer());
      pingServerOnline.add(await Utils().pingServerOnline());
      pingLokal.add(await Utils().pingServerLokal());
      timerAddnew();
    }
  }

  timerAddnew() async {
    print("repeate stream");
    Timer.periodic(_duration, (timer) async {
      isRunning.value = true;
      if (!isRunning.value) {
        timer.cancel();
        pingVps.close();
        pingServer.close();
        pingServerOnline.close();
        pingLokal.close();
        print("timer ${timer.isActive}");
      }
      if (!pingVps.isClosed &&
          !pingServer.isClosed &&
          !pingServerOnline.isClosed &&
          !pingLokal.isClosed) {
        pingVps.add(await Utils().pingVps());
        pingServer.add(await Utils().pingServer());
        pingServerOnline.add(await Utils().pingServerOnline());
        pingLokal.add(await Utils().pingServerLokal());
      }
    });
  }

  reloadCekServer() {
    closePing();
    timerAddnew();
  }

  closePing() {
    isOnline.value = false;
    serverOnline.value = false;
    lokalOnline.value = false;
    serverVps.value = false;
    isRunning.value = false;
  }

  closeStream() async {
    pingVps.close();
    pingServer.close();
    pingServerOnline.close();
    pingLokal.close();
  }
}
