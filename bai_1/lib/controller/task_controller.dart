import '../models/task_model.dart';
import '../repository/task_repository.dart';

class TaskController {
  TaskController({TaskRepository? repository})
      : _repository = repository ?? TaskRepository();

  final TaskRepository _repository;

  Stream<List<TaskModel>> watchTasks() => _repository.watchTasks();

  Future<void> addTask(String title) => _repository.addTask(title);

  Future<void> updateTaskStatus(TaskModel task, bool isDone) {
    return _repository.updateTaskStatus(taskId: task.id, isDone: isDone);
  }

  Future<void> deleteTask(String taskId) => _repository.deleteTask(taskId);
}