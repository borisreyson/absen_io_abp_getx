import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationAPI{
  static final _androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  static final _iOSInit = IOSInitializationSettings();
  static final _notifications = FlutterLocalNotificationsPlugin();

  Future onSelectNotification(String payload)
  async{
    print("payload $payload");
  }
  static Future _notificationsDetails()async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name', channelDescription: 'channelDescription',
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }
  static initNotif(){
    InitializationSettings _initSetting = InitializationSettings(android: _androidInit,iOS:_iOSInit);
    _notifications.initialize(_initSetting);
  }
  static Future showNotification({
    int id=1,
    String? title,
    String? body
  })async=>
      _notifications.show(id, title, body, await _notificationsDetails());
}