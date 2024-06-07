import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_call/call_sc.dart';
import 'package:video_call/video_call/constants/constants.dart';
import 'package:video_call/video_call/utils/api.dart';
//import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'one-to-one/one_to_one_meeting_screen.dart';

class VideocallManager {
  // static const String channel = "t2";

  bool _isLoadUI = false;

  static Widget callWidget(BuildContext context, {required bool isCallIsRunning}) => IconButton(
      onPressed: () async {



        // final token = await fetchToken(Get.context!);
        // print('🙄token\n${token}');
        // final meetingId = await createMeeting(AUTH_TOKEN);
        if (isCallIsRunning) {
  Navigator.pop(context);
  }else {
          try {

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  // const RoomScreen()
                  OneToOneMeetingScreen(
                      meetingId: "bwzb-2mxj-ylc8",
                      token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIzMDI3ZjM2ZC0xNWM2LTRiNjUtODdjOS1iNzdmNWRkZjNkMTciLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcxNzYwOTAxMiwiZXhwIjoxODc1Mzk3MDEyfQ.ZDUeDkwgHFTdwit63YepFiPZ6bWW-aN9SoCXKEmHpvQ",
                      displayName: "TEST NAME")
              ),
            );
          } catch (_) {

          }
        }
//             AppNavigation.toRoute(AppRoutes.call, arguments: md);
      },
      icon: Icon(
        CupertinoIcons.phone_fill,
        //color: ColorManager.primary,
      ));

  createVideoCall() async {
    //  throw StateError("something");

    //throw Exception();
    //throw "dis is a crash!";
    // List? list;
    //
    // list!.add("add");
    //FirebaseCrashlytics.instance.crash();

    await _sendMessage();
    // rt.to(kRoute.video_call);
  }

  Future _sendMessage() async {}

  static void join() async {}
}
