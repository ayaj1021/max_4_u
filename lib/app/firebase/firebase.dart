import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi{
final _firebaseMessaging = FirebaseMessaging.instance;

Future<void> initNotification()async{
  await _firebaseMessaging.requestPermission();
  final FCMToken = await _firebaseMessaging.getToken();
  debugPrint('Token: $FCMToken');
}
}