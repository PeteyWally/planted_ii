/*  lib  viewmodels  CATEGORY  */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../data/interfaces/repo_category.dart';
import '../data/interfaces/repo_tasks.dart'; // Import task repository interface
import '../models/model_task.dart';
import '../models/model_category.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _categoryRepository;
  final TaskRepository _taskRepository;
  List<CategoryModel> _categories = [];
  bool _isLoading = true;

  CategoryViewModel(
      {required CategoryRepository categoryRepository,
      required TaskRepository taskRepository})
      : _categoryRepository = categoryRepository,
        _taskRepository = taskRepository {
    _loadCategories();
  }

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;

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

//PUBLIC method getter sub-tasks from IDs
  Future<List<TaskModel>> fetchSubTasks(List<String> subTaskIds) async {
    try {
      // Fetch tasks concurrently
      final tasks = await Future.wait(subTaskIds.map((id) async {
        final task = await _taskRepository.getTaskById(id);
        if (task == null) {
          throw Exception('Task with ID $id not found');
        }
        return task;
      }));
      return tasks;
    } catch (e) {
      print('Error fetching sub-tasks: $e');
      return []; // Return an empty list on error
    }
  }

//TODO: change this to display categories not subtasks
  Future<List<CategoryModel>> getBlocksForGrid() async {
    final blocks = <CategoryModel>[];

    if (_categories.isEmpty) {
      print('No categories avail');
      return blocks;
    }
    for (var category in _categories) {
      final subTasks = await fetchSubTasks(category.subTaskIds);
      for (var task in subTasks) {
        blocks.add(CategoryModel(
          id: _generateUniqueId(),
          name: task.name,
          sizeTime: _calculateBlockSize(task),
          iconColor: 'UserBlue', // Placeholder for icon color
          subTaskIds: [], // No sub-tasks for the blocks
          taskRepository: _taskRepository,
        ));
      }
    }

    return blocks; // Return the processed list of blocks
  }

  void increaseSizeTime(CategoryModel category, int increment) {
    category.increaseSizeTime(increment);
    notifyListeners();
  }

  void decreaseSizeTime(CategoryModel category, int decrement) {
    category.decreaseSizeTime(decrement);
    notifyListeners();
  }

  String _generateUniqueId() {
    return const Uuid().v4();
  }

  int _calculateBlockSize(TaskModel task) {
    final duration = (task.endTime
            ?.difference(task.startTime ?? DateTime.now())
            .inMinutes) ??
        0;
    return (duration);
  }

  double calculateWidth(CategoryModel category) {
    return category.sizeTime.toDouble();
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      await _categoryRepository.addCategory(category);
      await _loadCategories(); // Refresh categories
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _categoryRepository.updateCategory(category);
      await _loadCategories(); // Refresh categories
    } catch (e) {
      print('Error updating category: $e');
    }
  }
}
