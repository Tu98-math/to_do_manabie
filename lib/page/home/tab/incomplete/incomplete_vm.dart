import 'dart:async';

import '/base/base_view_model.dart';
import '/model/task_model.dart';

class IncompleteViewModel extends BaseViewModel {
  BehaviorSubject<List<TaskModel>?> bsTask =
      BehaviorSubject<List<TaskModel>?>();

  late StreamSubscription<List<TaskModel>?> streamTask;

  @override
  void dispose() {
    streamTask.cancel();
    super.dispose();
  }

  IncompleteViewModel(ref) : super(ref) {
    init();
  }

  init() async {
    streamTask = taskRes.getAllCompletedTask(false).listen((event) {
      bsTask.add(event);
    });
  }

  Future<void> addTask(TaskModel task) async {
    if (bsRunning.value) {
      showToast();
    } else {
      startRunning();
      await taskRes.insertTask(task);
      endRunning();
      showToast(text: "Created task");
    }
  }

  Future<void> updateTask(TaskModel task) async {
    if (bsRunning.value) {
      showToast();
    } else {
      startRunning();
      await taskRes.updateTask(task);
      showToast(text: "Tasks have been updated");
      endRunning();
    }
  }

  Future<void> removeTask(TaskModel task) async {
    if (bsRunning.value) {
      showToast();
    } else {
      startRunning();
      await taskRes.removeTask(task);
      endRunning();
      showToast(text: "Task deleted");
    }
  }
}
