import 'package:flutter/material.dart';
import 'package:video_call/constants.dart';

import '../../../utils/spacer.dart';

class WaitingToJoin extends StatelessWidget {
  const WaitingToJoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          //  Lottie.asset("assets/joining_lottie.json", width: 100),
            const VerticalSpacer(20),
            const Text("Loading ...",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
