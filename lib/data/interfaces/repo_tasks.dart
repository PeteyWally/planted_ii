import '/models/model_task.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel?> getTaskById(String id);
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}