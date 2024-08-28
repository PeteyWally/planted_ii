import 'package:flutter/material.dart';
import '../style/colors.dart';
//import 'package:auto_size_text/auto_size_text.dart';

class TextStyling {
  static final h1Style = TextStyle(
    color: Colors.blueGrey[400],
    fontFamily: 'Mono',
    fontSize: 34.0, /* was 30 */
    fontWeight: FontWeight.bold,
  );
  static const missionStyle = TextStyle(
    color: Colors.black54,
    fontFamily: 'Mono',
    fontSize: 17.0, /* was 18 */
    fontStyle: FontStyle.italic,
  );
  static const p1Style =  TextStyle(
    color: Colors.black54,
    fontFamily: 'Mono',
    fontSize: 13.0, /* was 15 */
    fontWeight: FontWeight.normal,
  );
}

class ButtonStyling {
  static final buttonStyle = ButtonStyle(
    //backgroundColor: WidgetStateProperty.all(Colors.blue[200]), // Background color
    foregroundColor: WidgetStateProperty.all(Colors.blueGrey[200]), // Text color
    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 8)),// Padding
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder( // Shape
        borderRadius: BorderRadius.circular(12),
    )),
    elevation: WidgetStateProperty.all(4), // Shadow
    textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 14, fontFamily: 'Mono')), // Text style
    minimumSize: WidgetStateProperty.all(const Size(150, 42)), // Minimum size
    side: WidgetStateProperty.all(BorderSide(color: Colors.blueGrey.shade600)), // Border
  );

  static final flexButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(colorMap['UserBlue']), // Background color
    //foregroundColor: WidgetStateProperty.all(Colors.green[200]), // Text color
    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 4, vertical: 4)),// Padding
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder( // Shape
        borderRadius: BorderRadius.circular(8),
    )),
    elevation: WidgetStateProperty.all(2), // Shadow
    textStyle: WidgetStateProperty.all(TextStyling.p1Style),
    iconSize: WidgetStateProperty.all(20.0),
    iconColor: WidgetStateProperty.all(colorMap['UserRed']),
    minimumSize: WidgetStateProperty.all(const Size(100, 38)), // Minimum size
    side: WidgetStateProperty.all(BorderSide(color: Colors.blueGrey.shade500)), // Border
  );
}