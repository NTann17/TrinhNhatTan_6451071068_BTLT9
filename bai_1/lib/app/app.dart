import 'package:flutter/material.dart';

import '../controller/task_controller.dart';
import '../utils/app_theme.dart';
import '../views/home_view.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  static final TaskController _controller = TaskController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal To-do List',
      theme: AppTheme.lightTheme,
      home: HomeView(controller: _controller),
    );
  }
}