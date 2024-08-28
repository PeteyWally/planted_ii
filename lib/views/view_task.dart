/*  lib  views  TASK  */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/taskviewmodel.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(":Tasks:"),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: taskViewModel.tasks.length,
              itemBuilder: (context, index) {
                final task = taskViewModel.tasks[index];
                return ListTile(
                  title: Text(task.name)
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}