/*  lib  widget  TASK-LIST  */

import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  final List<String> tasks;
  
  TaskList({
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(tasks[index]),
        );
      },
    );
  }
}