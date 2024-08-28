/*  lib  views  LOADING  */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:planted_ii/style/text_style.dart';

class LoadingScreen extends StatelessWidget {
  final String missionStatement;

  LoadingScreen({required this.missionStatement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar_Garden(
      //   title: 'Loading',
      //   missionStatement: missionStatement,
      // ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitFadingCube(
              color: Colors.blue,
              size: 50.0,
            ),
            const SizedBox(height: 20),
            Text(
              missionStatement,
              style: TextStyling.missionStyle.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
