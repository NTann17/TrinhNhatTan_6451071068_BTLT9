class TaskValidators {
  static String? validateTitle(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Vui lòng nhập tiêu đề công việc';
    }
    if (trimmed.length < 3) {
      return 'Tiêu đề phải có ít nhất 3 ký tự';
    }
    return null;
  }
}