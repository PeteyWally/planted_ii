/*  lib  models  TASK  */



import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String name;
//entering not required     ??
  double time; // 60=hr, calculated in Category
  Widget icon;
  String iconColor;  
  bool isCompleted;
  DateTime? startTime;
  DateTime? endTime;
  Map<String, dynamic> customMetrics;

  TaskModel ({
    required this.id,
    required this.name,
    this.time = 60, /* default size 1 hour */
    Widget? icon,
    this.iconColor = 'Colors.black',    
    this.isCompleted = false,
    this.startTime,
    this.endTime,
    Map<String, dynamic>? customMetrics,
  }) : 
  icon = icon ?? Icon(Icons.add),
  customMetrics = customMetrics ?? {};
}