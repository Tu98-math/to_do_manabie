import '../../model/task_model.dart';
import '/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  BehaviorSubject<List<TaskModel>?> bsTask =
      BehaviorSubject<List<TaskModel>?>();

  BehaviorSubject<bool> bsLoading = BehaviorSubject.seeded(true);

  HomeViewModel(ref) : super(ref) {
    init();
  }

  init() async {
    await getTask.initDatabase();
    bsLoading.add(false);
    getTask.getAllTask().listen((event) {
      bsTask.add(event);
    });
  }
}
