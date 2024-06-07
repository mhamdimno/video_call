import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:video_call/video_call/utils/toast.dart';

import '../constants/constants.dart';


Future<String> fetchToken(BuildContext context) async {

  // final String? AUTH_GENERATION = AUTH_GENERATION;
  // String? _AUTH_TOKEN = AUTH_TOKEN;
  //
  // if ((_AUTH_TOKEN?.isEmpty ?? true) && (AUTH_GENERATION?.isEmpty ?? true)) {
  //   showSnackBarMessage(
  //       message: "Please set the environment variables", context: context);
  //   throw Exception("Either AUTH_TOKEN or AUTH_URL is not set in .env file");
  // }
  //
  // if ((_AUTH_TOKEN?.isNotEmpty ?? false) && (AUTH_GENERATION?.isNotEmpty ?? false)) {
  //   showSnackBarMessage(
  //       message: "Please set only one environment variable", context: context);
  //   throw Exception("Either AUTH_TOKEN or AUTH_URL can be set in .env file");
  // }
  //
  // // if (AUTH_GENERATION?.isNotEmpty ?? false) {
  // //   final Uri getTokenUrl = Uri.parse('$_AUTH_URL/get-token');
  // //   final http.Response tokenResponse = await http.get(getTokenUrl);
  // //   _AUTH_TOKEN = json.decode(tokenResponse.body)['token'];
  // // }

  return AUTH_GENERATION ?? "";
}

Future<String> createMeeting(String _token) async {
  final String? _VIDEOSDK_API_ENDPOINT = VIDEOSDK_API_ENDPOINT;
print('🙄$_VIDEOSDK_API_ENDPOINT\n${'$_VIDEOSDK_API_ENDPOINT/rooms'}');
  final Uri getMeetingIdUrl = Uri.parse('$_VIDEOSDK_API_ENDPOINT/rooms');
  final http.Response meetingIdResponse =
      await http.post(getMeetingIdUrl, headers: {
    "Authorization": _token,
  });
  print('🙄_token2\n${_token}');
print('🙄meetingIdResponse.statusCode\n${meetingIdResponse.statusCode}');
  if (meetingIdResponse.statusCode != 200) {
    throw Exception(json.decode(meetingIdResponse.body)["error"]);
  }
  var _meetingID = json.decode(meetingIdResponse.body)['roomId'];
  return _meetingID;
}

Future<bool> validateMeeting(String token, String meetingId) async {
  final String? _VIDEOSDK_API_ENDPOINT = VIDEOSDK_API_ENDPOINT;

  final Uri validateMeetingUrl =
      Uri.parse('$_VIDEOSDK_API_ENDPOINT/rooms/validate/$meetingId');
  final http.Response validateMeetingResponse =
      await http.get(validateMeetingUrl, headers: {
    "Authorization": token,
  });

  if (validateMeetingResponse.statusCode != 200) {
    throw Exception(json.decode(validateMeetingResponse.body)["error"]);
  }

  return validateMeetingResponse.statusCode == 200;
}

Future<dynamic> fetchSession(String token, String meetingId) async {
  final String? _VIDEOSDK_API_ENDPOINT = VIDEOSDK_API_ENDPOINT;

  final Uri getMeetingIdUrl =
      Uri.parse('$_VIDEOSDK_API_ENDPOINT/sessions?roomId=$meetingId');
  final http.Response meetingIdResponse =
      await http.get(getMeetingIdUrl, headers: {
    "Authorization": token,
  });
  List<dynamic> sessions = jsonDecode(meetingIdResponse.body)['data'];
  return sessions.first;
}
