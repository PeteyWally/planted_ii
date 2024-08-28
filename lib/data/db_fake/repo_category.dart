import 'package:planted_ii/data/interfaces/repo_tasks.dart';
import 'package:planted_ii/models/model_category.dart';
import 'package:flutter/material.dart';

class CategoryRepository {
  final TaskRepository _taskRepository;

  CategoryRepository(this._taskRepository);

  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      CategoryModel(
        id: 'c1',
        name: 'Chores',
        icon: const Icon(Icons.brush),
        iconColor: 'UserBlueLight',
        sizeTime: 60,
        subTaskIds: [
          't1',
          't2',
          't3',
        ],
        taskRepository: _taskRepository,
      ),
      CategoryModel(
        id: 'c2',
        name: 'Garage',
        icon: const Icon(Icons.carpenter_sharp),
        iconColor: 'UserBlueLight',
        sizeTime: 120,
        subTaskIds: [
          't3',
          't4',
          't5',
          't6',
        ],
        taskRepository: _taskRepository,
      ),
    ];
  }
}
