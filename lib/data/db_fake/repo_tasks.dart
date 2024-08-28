import '../../models/model_task.dart';

class TaskRepository {
  final List<TaskModel> _tasks = [
    TaskModel(
      id: 't1',
      name: 'Laundry',
      startTime: DateTime(2024,8,19,10),
      endTime: DateTime(2024,8,19,12),
      isCompleted: false,
      // customMetrics: ,
    ),

    TaskModel(
      id: 't2',
      name: 'Dishes',
      startTime: DateTime(2024,8,19,2),
      endTime: DateTime(2024,8,19,3),
      isCompleted: false,
      // customMetrics: ,
    ),

    TaskModel(
      id: 't3',
      name: 'Clean',
      startTime: DateTime(2024,8,19,2),
      endTime: DateTime(2024,8,19,3),
      isCompleted: false,
      // customMetrics: ,
    ),

    TaskModel(
      id: 't4',
      name: 'change-oil',
      startTime: DateTime(2024,8,19,2),
      endTime: DateTime(2024,8,19,3),
      isCompleted: false,
      // customMetrics: ,
    ),

    TaskModel(
      id: 't5',
      name: 'move-stuff',
      startTime: DateTime(2024,8,19,2),
      endTime: DateTime(2024,8,19,3),
      isCompleted: false,
      // customMetrics: ,
    ),

    TaskModel(
      id: 't6',
      name: 'sit',
      startTime: DateTime(2024,8,19,2),
      endTime: DateTime(2024,8,19,3),
      isCompleted: false,
      // customMetrics: ,
    ),

  ];

  List<TaskModel>  getTasks() {
    return _tasks;
  }

  void addTask(TaskModel task) {
    _tasks.add(task);
  }

  void updateTask(TaskModel task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }
}

