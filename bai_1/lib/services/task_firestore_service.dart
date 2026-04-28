import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';

class TaskFirestoreService {
  TaskFirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _tasksCollection =>
      _firestore.collection('tasks');

  Stream<List<TaskModel>> watchTasks() {
    return _tasksCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(TaskModel.fromDocument)
              .where((task) => task.title.isNotEmpty)
              .toList(),
        );
  }

  Future<void> addTask(String title) async {
    await _tasksCollection.add({
      'title': title.trim(),
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTaskStatus({
    required String taskId,
    required bool isDone,
  }) async {
    await _tasksCollection.doc(taskId).update({'isDone': isDone});
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksCollection.doc(taskId).delete();
  }
}