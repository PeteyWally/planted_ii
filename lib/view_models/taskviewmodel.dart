/*  lib  viewmodels  TASK  */

import 'package:flutter/material.dart';
import '../models/model_task.dart';
import '../models/model_category.dart';
import '../data/interfaces/repo_tasks.dart';
import '../data/interfaces/repo_category.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;
  final CategoryRepository _categoryRepository;
  List<TaskModel> _tasks = [];
  List<CategoryModel> _categories = [];
  bool _isLoading = true;

  TaskViewModel({
    required TaskRepository taskRepository,
    required CategoryRepository categoryRepository,
  })  : _taskRepository = taskRepository,
        _categoryRepository = categoryRepository {
    _loadTasks();
    _loadCategories();
  }

  List<TaskModel> get tasks => _tasks;
  List<CategoryModel> get categories => _categories;
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

  Future<void> _loadCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await _categoryRepository.getCategories();
    } catch (e) {
      print('Error loading categories: $e');
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

  void toggleTask(TaskModel task) {
    task.isCompleted = !task.isCompleted;
    updateTask(task);
  }

  Future<void> deleteTask(String id) async {
    try {
      await _taskRepository.deleteTask(id);
      _loadTasks(); // Refresh the task list
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  Future<Icon?> getCategoryIconForTask(TaskModel task) async {
    try {
      final categories = await _categoryRepository.getCategories();
      final category = categories.firstWhere(
        (category) => category.subTaskIds.contains(task.id),
        orElse: () => CategoryModel(
          id: '',
          name: 'dull+noid',
          icon: null,
          subTaskIds: [],
          taskRepository: _taskRepository,
        ),
      );
      return category.icon as Icon?;
    } catch (e) {
      print('Error fetching category icon: $e');
      return null;
    }
  }
}
