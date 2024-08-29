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
      body: taskViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: taskViewModel.tasks.length,
              itemBuilder: (context, index) {
                final task = taskViewModel.tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      taskViewModel.toggleTask(task);
                    },
                  ),
                  title: Text(task.name),
                  trailing: FutureBuilder<Icon?>(
                    future: taskViewModel.getCategoryIconForTask(task),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        print(
                            'Error fetching category icon: ${snapshot.error}');
                        return Icon(Icons.error);
                      } else {
                        return snapshot.data ?? Icon(Icons.help_outline);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
