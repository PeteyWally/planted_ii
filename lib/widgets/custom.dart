/*  lib  widget  CUSTOM  */

import 'package:flutter/material.dart';

class CustomWid extends StatelessWidget {
  final String title;
  final Function() onTap;

  CustomWid({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Text(title),
      ),
    );
  }
}