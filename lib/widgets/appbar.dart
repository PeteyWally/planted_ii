import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../style/text_style.dart';
import '../style//colors.dart';

class AppBar_Garden extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String missionStatement;
  final String? backgroundColorKey;
  static const double toolbarHeight = 90.0;

  const AppBar_Garden({
    super.key,
    required this.title,
    required this.missionStatement,
    this.backgroundColorKey,
  });

  @override
  Widget build(BuildContext context) {
    final Color appBarBackgroundColor = backgroundColorKey != null
        ? colorMap[backgroundColorKey] ?? Colors.green
        : Colors.white;

    return AppBar(
      toolbarHeight: toolbarHeight,
      backgroundColor: appBarBackgroundColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyling.h1Style,
          ),
          Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  missionStatement,
                  style: TextStyling.missionStyle,
                  maxLines: 2,
                  minFontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
