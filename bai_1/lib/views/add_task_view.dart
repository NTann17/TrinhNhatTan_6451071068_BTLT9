import 'package:flutter/material.dart';

import '../controller/task_controller.dart';
import '../utils/task_validators.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key, required this.controller});

  final TaskController controller;

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await widget.controller.addTask(_titleController.text);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm công việc')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  validator: TaskValidators.validateTitle,
                  decoration: const InputDecoration(
                    labelText: 'Tiêu đề công việc',
                    hintText: 'Ví dụ: Đi tập gym lúc 7h',
                    prefixIcon: Icon(Icons.task_alt),
                  ),
                  onFieldSubmitted: (_) => _saveTask(),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _isSaving ? null : _saveTask,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save),
                  label: Text(_isSaving ? 'Đang lưu...' : 'Lưu công việc'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}