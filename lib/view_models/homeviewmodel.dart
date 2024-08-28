/*  lib  viewmodels  HOME  */

import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Map<String, String>> _widgets = [
    {'title': '-calendar-', 'route': '/calendar'},
    {'title': '-taskly-', 'route': '/task'},
    {'title': '-categories-', 'route': '/category'},
    {'title': '-grid-', 'route': '/grid'},
  ];

  List<Map<String, String>> get widgets => _widgets;

  void addWidget(String title, String route) {
    _widgets.add({'title': title, 'route': route});
    notifyListeners();
  }

  void removeWidget(String title, String route) {
    _widgets.removeWhere((widget) => widget['title'] == title);
    notifyListeners();
  }
  
}