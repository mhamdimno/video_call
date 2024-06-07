import 'package:flutter/material.dart';
import 'package:video_call/video_call/one-to-one/one_to_one_meeting_screen.dart';
import 'package:video_call/video_call/utils/api.dart';

class call_sc extends StatefulWidget {
  const call_sc({super.key, required this.meetingId, required this.token, required this.displayName});

  final String meetingId;
  final String token;
  final String displayName;
  @override
  State<call_sc> createState() => _call_scState();
}

class _call_scState extends State<call_sc> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return  OneToOneMeetingScreen(meetingId: widget.meetingId, token: widget.token, displayName: widget.displayName);
  }
}
