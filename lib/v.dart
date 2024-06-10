import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_call/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
class NotifiactionCore {
  static Future<String> getFirebaseMessagingToken() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "basic_channel",
          channelName: "basic_channel",
          channelDescription: "basic_channel",
          importance: NotificationImportance.Max,
          playSound: true,
          criticalAlerts: true,
          enableLights: true,
          channelShowBadge: true,
          enableVibration: true,
        ),
      ],
      debug: true,
    );
    if (!(await AwesomeNotifications().isNotificationAllowed())) {
      await AwesomeNotifications()
          .requestPermissionToSendNotifications(channelKey: "basic_channel");
    }

    String firebaseAppToken = '';
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        firebaseAppToken =
        await AwesomeNotificationsFcm().requestFirebaseAppToken();
      } catch (exception) {
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    return firebaseAppToken;
  }

  static Future<void> initializeRemoteNotifications(
      {required bool debug}) async {
    //group.awn.54dee40f
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    await AwesomeNotificationsFcm().initialize(
      onFcmSilentDataHandle: mySilentDataHandle,
      onFcmTokenHandle: myFcmTokenHandle,
      onNativeTokenHandle: myNativeTokenHandle,
      debug: debug,
    );
  }

  //  *********************************************
  ///     REMOTE NOTIFICATION EVENTS
  ///  *********************************************

  /// Use this method to execute on background when a silent data arrives
  /// (even while terminated)
  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    print('"SilentData": ${silentData.toString()}');
    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      print("bg with data $silentData");
    } else {
      print("FOREGROUND");
    }
    print("starting long task");
    print("long task done");
    await createNotif();
    return Future.value();
  }

  /// Use this method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('FCM Token:"$token"');
  }

  /// Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token:"$token"');
  }

  static Future createNotif() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecond,
          wakeUpScreen: true,
          badge: 5,
          channelKey: "basic_channel",
          title: "test",
          body: "Manga",
        ));
  }
}