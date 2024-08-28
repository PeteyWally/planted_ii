import '../interfaces/repo_tasks.dart';
import 'package:planted_ii/models/model_task.dart';

class InMemoryTaskRepository implements TaskRepository {
  final Map<String, TaskModel> _tasks = {};

  InMemoryTaskRepository() {
    _tasks.addAll({
/* loads initial data, not synced to db_fake 
TODO: sync */

      'f1': TaskModel(
        id: 'f1',
        name: 'Placeholder',
        startTime: DateTime(2024, 8, 19, 10),
        endTime: DateTime(2024, 8, 19, 12),
        isCompleted: false,
      ),
      'c1': TaskModel(
        id: 'c1',
        name: 'Laundry',
        startTime: DateTime(2024, 8, 19, 10),
        endTime: DateTime(2024, 8, 19, 12),
        isCompleted: false,
        // customMetrics: ,
      ),
      'c2': TaskModel(
        id: 'c2',
        name: 'Dishes',
        startTime: DateTime(2024, 8, 19, 2),
        endTime: DateTime(2024, 8, 19, 3),
        isCompleted: false,
        // customMetrics: ,
      ),
      'c3': TaskModel(
        id: 'c3',
        name: 'Clean',
        startTime: DateTime(2024, 8, 19, 2),
        endTime: DateTime(2024, 8, 19, 3),
        isCompleted: false,
        // customMetrics: ,
      ),
      'v1': TaskModel(
        id: 'v1',
        name: 'change-oil',
        startTime: DateTime(2024, 8, 19, 2),
        endTime: DateTime(2024, 8, 19, 3),
        isCompleted: false,
        // customMetrics: ,
      ),
      't5': TaskModel(
        id: 'g1',
        name: 'move-stuff',
        startTime: DateTime(2024, 8, 19, 2),
        endTime: DateTime(2024, 8, 19, 3),
        isCompleted: false,
        // customMetrics: ,
      ),
      'm1': TaskModel(
        id: 'm1',
        name: 'sit',
        startTime: DateTime(2024, 8, 19, 2),
        endTime: DateTime(2024, 8, 19, 3),
        isCompleted: false,
        // customMetrics: ,
      ),
    });
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    return _tasks.values.toList();
  }

  @override
  Future<TaskModel?> getTaskById(String id) async {
    return _tasks[id];
  }

  @override
  Future<void> addTask(TaskModel task) async {
    _tasks[task.id] = task;
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    _tasks[task.id] = task;
  }

  @override
  Future<void> deleteTask(String id) async {
    _tasks.remove(id);
  }
}
