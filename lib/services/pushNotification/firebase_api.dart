import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../../main.dart';

// final navigatorKey = GlobalKey<NavigatorState>();

class FirebaseApi{

  final _firebaseMessaging = FirebaseMessaging.instance;

  void _handleMessage(RemoteMessage? message) {
    print("hello122222");
    navigatorKey.currentState?.pushNamed('/gMapScreen');
  }

  Future initPushNotifications() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print(fCMToken);
    initPushNotifications();
  }



}

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data);
  navigatorKey.currentState?.pushNamed('/gMapScreen');
}
