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

  TaskModel({
    required this.id,
    required this.name,
    this.time = 60,
    /* default size 1 hour */
    Widget? icon,
    this.iconColor = 'Colors.black',
    this.isCompleted = false,
    this.startTime,
    this.endTime,
  }) : icon = icon ?? Icon(Icons.add);

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['_id'].toString(),
      name: map['name'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      isCompleted: map['isCompleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}
