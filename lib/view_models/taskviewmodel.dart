/*  lib  viewmodels  TASK  */

import 'package:flutter/material.dart';
import '../models/model_task.dart';
import '../data/interfaces/repo_tasks.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;
  List<TaskModel> _tasks = [];
  bool _isLoading = true;

  TaskViewModel(this._taskRepository) {
    _loadTasks();
  }

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;

  Future<void> _loadTasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await _taskRepository.getTasks();
    } catch (e) {
      print('Error loading tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await _taskRepository.addTask(task);
      _loadTasks(); // Refresh the task list
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _taskRepository.updateTask(task);
      _loadTasks(); // Refresh the task list
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _taskRepository.deleteTask(id);
      _loadTasks(); // Refresh the task list
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}