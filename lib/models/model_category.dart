/*  lib  models  CATEGORY < CATEGORY+GRID  */

import '../models/model_task.dart';
import 'package:flutter/material.dart';
import '../data/interfaces/repo_tasks.dart';

class CategoryModel {
  final String id;
  final String name;
  final Widget icon;
  final String iconColor;
  final int sizeTime; /* alloted time used in grid */
  final List<String> subTaskIds;
  final TaskRepository _taskRepository;

  CategoryModel({
    required this.id,
    required this.name,
    Widget? icon,
    this.iconColor = 'grey',
    this.sizeTime = 120,
    /* default 2 hours */
    required this.subTaskIds,
    required TaskRepository taskRepository,
  })  : icon = icon ?? const Icon(Icons.add),
        _taskRepository = taskRepository;

  // Convenience method to get tasks based on task IDs and a repository
  Future<List<TaskModel>> _getSubTasks() async {
    // Use Future.wait to fetch tasks concurrently
    return Future.wait(subTaskIds.map((taskId) async {
      final task = await _taskRepository.getTaskById(taskId);
      if (task != null) {
        return task;
      } else {
        throw Exception('Task with ID $taskId not found');
      }
    }));
  }

  // Calculated time from sub-tasks
  Future<double> get calcTime async {
    try {
      final tasks = await _getSubTasks();
      // Use fold to sum up the task times
      return tasks.fold<double>(0.0, (total, task) => total + (task.time));
    } catch (e) {
      print('Error calculating time: $e');
      return 0.0;
    }
  }

  // Calculated remaining time
  Future<double> get remainingTime async {
    final calcTimeValue =
        await calcTime; // Await the future to get the double value
    return sizeTime.toDouble() - calcTimeValue;
  }
}
