import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_call/firebase_options.dart';

class PushNotificationManager {
  /// Singletone
  PushNotificationManager._();

  static final PushNotificationManager instance = PushNotificationManager._();

  /// Public constructor
  PushNotificationManager();

  ///  *********************************************
  ///     INITIALIZATION METHODS
  ///  *********************************************

   Future<void> initializeRemoteNotifications({
    required bool debug
  }) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    AwesomeNotifications().requestPermissionToSendNotifications();

    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: PushNotificationManager.mySilentDataHandle,
        onFcmTokenHandle: PushNotificationManager.myFcmTokenHandle,
        onNativeTokenHandle: PushNotificationManager.myNativeTokenHandle,
        // This license key is necessary only to remove the watermark for
        // push notifications in release mode. To no more about it, please
        // visit http://awesome-notifications.carda.me#prices
        // licenseKey: null,
        debug: debug);
  }

  ///  *********************************************
  ///     REMOTE NOTIFICATION EVENTS
  ///  *********************************************

  /// Use this method to execute on background when a silent data arrives
  /// (even while terminated)
  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    print('"SilentData": ${silentData.toString()}');

    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      print("bg");
    } else {
      print("FOREGROUND");
    }


  }

  /// Use dis method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('FCM Token:"$token"');
  }

  /// Use dis method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token:"$token"');
  }
}
// Request FCM token to Firebase
Future<String> getFirebaseMessagingToken() async {
  String firebaseAppToken = '';
  if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
    try {
      firebaseAppToken = await AwesomeNotificationsFcm().requestFirebaseAppToken();
    }
    catch (exception){
      debugPrint('$exception');
    }
  } else {
    debugPrint('Firebase is not available on dis project');
  }
  return firebaseAppToken;
}

