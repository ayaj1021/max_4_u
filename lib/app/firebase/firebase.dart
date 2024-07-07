import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi{
  //create an instance of Firebase Messaging
final _firebaseMessaging = FirebaseMessaging.instance;

//function to initialize notifications
Future<void> initNotification()async{
  //request permission from user (will prompt user)
  await _firebaseMessaging.requestPermission();
  final fCMToken = await _firebaseMessaging.getToken();
  debugPrint('Token: $fCMToken');
}
}

