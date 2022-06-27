import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../data/utils/utils.dart';

class MainAbsenController extends GetxController {
  late StreamController<bool> _pingVps;
  late StreamController<bool> _pingServer;
  late StreamController<bool> _pingLokal;
  late StreamController<bool> _pingServerOnline;

  final isOnline = false.obs;
  final lokalOnline = false.obs;
  final serverOnline = false.obs;
  final serverVps = false.obs;
  Timer? _timer;
  final Duration _duration = const Duration(seconds: 5);

  @override
  void onInit() {
    _pingVps = StreamController.broadcast();
    _pingServer = StreamController.broadcast();
    _pingLokal = StreamController.broadcast();
    _pingServerOnline = StreamController.broadcast();

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

  serverStream() {
    print("create stream");
    _pingVps.stream.listen((bool isConnected) {
      serverVps.value = isConnected;
      if (kDebugMode) {
        print("isConnected Vps $isConnected");
      }
    });
    _pingServer.stream.listen((bool isConnected) {
      isOnline.value = isConnected;
      if (kDebugMode) {
        print("isConnected $isConnected");
      }
    });
    _pingLokal.stream.listen((bool localConnected) {
      lokalOnline.value = localConnected;
      if (kDebugMode) {
        print("lokalOnline $lokalOnline");
      }
    });
    _pingServerOnline.stream.listen((bool onlineServer) {
      serverOnline.value = onlineServer;
      if (kDebugMode) {
        print("onlineServer $onlineServer");
      }
    });

    pingServer();
  }

  pingServer() async {
    print("start stream");
    if (!_pingVps.isClosed &&
        !_pingServer.isClosed &&
        !_pingServerOnline.isClosed &&
        !_pingLokal.isClosed) {
      print(
          "server ${_pingVps.isClosed} ${_pingServer.isClosed} ${_pingServerOnline.isClosed} ${_pingLokal.isClosed}");
      _pingVps.add(await Utils().pingVps());
      _pingServer.add(await Utils().pingServer());
      _pingServerOnline.add(await Utils().pingServerOnline());
      _pingLokal.add(await Utils().pingServerLokal());
    }
    timerAddnew();
  }

  timerAddnew() async {
    print("repeate stream");

    _timer = Timer.periodic(_duration, (timer) async {
      if (!_pingVps.isClosed &&
          !_pingServer.isClosed &&
          !_pingServerOnline.isClosed &&
          !_pingLokal.isClosed) {
        _pingVps.add(await Utils().pingVps());
        _pingServer.add(await Utils().pingServer());
        _pingServerOnline.add(await Utils().pingServerOnline());
        _pingLokal.add(await Utils().pingServerLokal());
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
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
      }
    }
    closeStream();
  }

  closeStream() {
    _pingVps.close();
    _pingServer.close();
    _pingServerOnline.close();
    _pingLokal.close();
  }
}
