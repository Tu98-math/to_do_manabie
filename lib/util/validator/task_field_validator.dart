class TaskFieldValidator {
  static String? validate(String? value) {
    return (value == null)
        ? "Please enter your task"
        : (value.trim() == '')
            ? "Please enter your task"
            : null;
  }
}
