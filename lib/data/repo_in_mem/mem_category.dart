import 'package:flutter/material.dart';
import 'package:planted_ii/data/interfaces/repo_tasks.dart';
// import 'package:planted_ii/data/repo_in_mem/mem_task.dart';
import '../interfaces/repo_category.dart';
import 'package:planted_ii/models/model_category.dart';

class InMemoryCategoryRepository implements CategoryRepository {
  final Map<String, CategoryModel> _categories = {};
  final TaskRepository _taskRepository;

  InMemoryCategoryRepository(this._taskRepository) {
    _loadInitialData();
  }

  void _loadInitialData() {
    _categories.addAll({
      'chore': CategoryModel(
        id: '4',
        name: 'Chores',
        icon: const Icon(Icons.brush),
        iconColor: 'UserBlueLight',
        sizeTime: 60,
        subTaskIds: [
          'c1',
          'c2',
          'c3',
        ],
        taskRepository: _taskRepository,
      ),
      'garage': CategoryModel(
        id: '5',
        name: 'Garage',
        icon: const Icon(Icons.carpenter_sharp),
        iconColor: 'UserBlueLight',
        sizeTime: 120,
        subTaskIds: [
          'h1',
        ],
        taskRepository: _taskRepository,
      ),
      'car': CategoryModel(
        id: '6',
        name: 'Car',
        icon: const Icon(Icons.car_repair),
        iconColor: 'UserBlueLight',
        sizeTime: 150,
        subTaskIds: [
          'v1',
          'f1',
          'f1',
          'f1',
        ],
        taskRepository: _taskRepository,
      ),
      'morning': CategoryModel(
        id: '7',
        name: 'Morning',
        icon: const Icon(Icons.sunny),
        iconColor: 'UserBlueLight',
        sizeTime: 150,
        subTaskIds: [
          'm1',
          'f1',
        ],
        taskRepository: _taskRepository,
      ),
    });
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      return _categories.values.toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  @override
  Future<CategoryModel?> getCategoryById(String id) async {
    try {
      return _categories[id];
    } catch (e) {
      print('Error fetching category by ID: $e');
      return null;
    }
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    try {
      _categories[category.id] = category;
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    try {
      _categories[category.id] = category;
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      _categories.remove(id);
    } catch (e) {
      print('Error deleting category: $e');
    }
  }
}
