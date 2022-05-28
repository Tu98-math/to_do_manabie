import '/base/base_view_model.dart';
import '/model/task_model.dart';

class AllViewModel extends BaseViewModel {
  BehaviorSubject<List<TaskModel>?> bsTask =
      BehaviorSubject<List<TaskModel>?>();

  AllViewModel(ref) : super(ref) {
    init();
  }

  init() async {
    await getTask.initDatabase();
    getTask.getAllTask().listen((event) {
      bsTask.add(event);
    });
  }

  addTask(TaskModel task) {
    getTask.insertTask(task);
  }

  updateTask(TaskModel task) {
    getTask.updateTask(task);
  }
}
