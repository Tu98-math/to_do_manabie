import '/model/task_model.dart';
import '/base/base_view_model.dart';

class CompleteViewModel extends BaseViewModel {
  BehaviorSubject<List<TaskModel>?> bsTask =
      BehaviorSubject<List<TaskModel>?>();

  @override
  void dispose() {
    bsTask.close();
    super.dispose();
  }

  CompleteViewModel(ref) : super(ref) {
    init();
  }

  init() async {
    getTask.getAllCompletedTask(true).listen((event) {
      bsTask.add(event);
    });
  }

  addTask(TaskModel task) async {
    if (bsRunning.value) {
      showToast();
    } else {
      startRunning();
      await getTask.insertTask(task);
      endRunning();
      showToast(text: "Created task");
    }
  }

  updateTask(TaskModel task) async {
    if (bsRunning.value) {
      showToast();
    } else {
      startRunning();
      await getTask.updateTask(task);
      showToast(text: "Tasks have been updated");
      endRunning();
    }
  }

  removeTask(TaskModel task) async {
    if (bsRunning.value) {
      showToast();
    } else {
      startRunning();
      await getTask.removeTask(task);
      endRunning();
      showToast(text: "Task deleted");
    }
  }
}
