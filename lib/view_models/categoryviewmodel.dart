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

//========================================================================

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

  /* DateTime _currentDate = DateTime.now();
  
  DateTime get currentDate => _currentDate;

  // Get the list of days for the grid
  List<DateTime> get days {
    return List.generate(7, (index) => _currentDate.add(Duration(days: index)));
  }
  
  // Get the list of hours for the grid
  List<int> get hours {
    return List.generate(14, (index) => index + 1); // 1 to 14
  }
  
  // Update current date, only allow scrolling down
  void scrollDown() {
    _currentDate = _currentDate.add(Duration(days: 7));
    notifyListeners();
  } */

  Future<List<CategoryModel>> getBlocksForGrid() async {
    final blocks = <CategoryModel>[];

    if (_categories.isEmpty) {
      print('No categories avail');
      return blocks;
    }
    for (var category in _categories) {
      // final subTasks = await fetchSubTasks(category.subTaskIds);
      // for (var task in subTasks) {
      blocks.add(CategoryModel(
        id: _generateUniqueId(),
        name: category.name,
        sizeTime: category.sizeTime,
        icon: category.icon,
        iconColor: category.iconColor, // Placeholder for icon color
        subTaskIds: [], // No sub-tasks for the blocks
        taskRepository: _taskRepository,
      ));
      // }
    }

    return blocks; // Return the processed list of blocks
  }

//grid view buttons to adjust sizeTime
  void increaseCategorySizeTime(String categoryId, int increment) {
    try {
      final category = _categories.firstWhere((c) => c.id == categoryId);
      category.increaseSizeTime(increment);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      // Handle the error, e.g., show a message to the user
    }
  }

  void decreaseCategorySizeTime(String categoryId, int decrement) {
    try {
      final category = _categories.firstWhere((c) => c.id == categoryId);
      category.decreaseSizeTime(decrement);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      // Handle the error, e.g., show a message to the user
    }
  }

//========================================================================
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

/* version 1 */
  // Future<void> updateCategory(CategoryModel category) async {
  //   try {
  //     await _categoryRepository.updateCategory(category);
  //     await _loadCategories(); // Refresh categories
  //   } catch (e) {
  //     print('Error updating category: $e');
  //   }
  // }
/* version 2 */
  void updateCategory(CategoryModel category) {
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _categories[index] = category;
      notifyListeners();
    }
  }
}
