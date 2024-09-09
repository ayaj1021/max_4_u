import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:max_4_u/app/presentation/features/notification/notification_screen.dart';
import 'package:max_4_u/main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Title: ${message.notification?.title}');
  log('Body: ${message.notification?.body}');
  log('Payload: ${message.data}');
}

class FirebaseApi {
  //create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance  Notifications',
      description: 'This channel is used for important  notifications',
      importance: Importance.defaultImportance);

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (_) => NotificationScreen()));
  }

  Future initLocalNotifications() async {
    // const iOS = iOSIn
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings);

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);

    //onSelectNotification: (payLoad){});
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
     // await showNotification(message);
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              _androidChannel.id, _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher'),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

//function to initialize notifications
  Future<void> initNotification() async {
    //request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint('Token: $fCMToken');
    initPushNotifications();
    initLocalNotifications();
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
