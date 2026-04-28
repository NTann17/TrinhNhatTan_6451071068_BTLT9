import '../models/task_model.dart';
import '../services/task_firestore_service.dart';

class TaskRepository {
  TaskRepository({TaskFirestoreService? service})
      : _service = service ?? TaskFirestoreService();

  final TaskFirestoreService _service;

  Stream<List<TaskModel>> watchTasks() => _service.watchTasks();

  Future<void> addTask(String title) => _service.addTask(title);

  Future<void> updateTaskStatus({
    required String taskId,
    required bool isDone,
  }) {
    return _service.updateTaskStatus(taskId: taskId, isDone: isDone);
  }

  Future<void> deleteTask(String taskId) => _service.deleteTask(taskId);
}