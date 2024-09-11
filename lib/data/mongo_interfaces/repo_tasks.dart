/*  lib data mongo-interfaces TASKS  */

import 'package:mongo_dart/mongo_dart.dart';
import '/models/model_task.dart';
import '../mongo_config.dart';

class MongoTaskRepository implements TaskRepository {
  final DbCollection _collection = MongoConfig.db.collection('tasks');

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final tasks = await _collection.find().toList();
      return tasks.map((e) => TaskModel.fromMap(e)).toList();
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  @override
  Future<TaskModel?> getTaskById(String id) async {
    try {
      final task =
          await _collection.findOne(where.id(ObjectId.fromHexString(id)));
      return task != null ? TaskModel.fromMap(task) : null;
    } catch (e) {
      print('Error fetching task by ID: $e');
      return null;
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      await _collection.insertOne(task.toMap());
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await _collection.updateOne(
        where.id(ObjectId.fromHexString(task.id)),
        modify
            .set('name', task.name)
            .set('startTime', task.startTime.toIso8601String())
            .set('endTime', task.endTime.toIso8601String())
            .set('isCompleted', task.isCompleted),
      );
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await _collection.remove(where.id(ObjectId.fromHexString(id)));
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
